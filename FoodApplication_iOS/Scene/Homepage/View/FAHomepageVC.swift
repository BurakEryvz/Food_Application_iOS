//
//  FAHomepageVC.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit
import RxSwift
import FirebaseAuth

class FAHomepageVC: UIViewController, FATabBarControllerDelegate {
    func tabBarSearchButtonPressed() {
        searchBar.becomeFirstResponder()
    }
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var foods = [FAFood]() // CollectionView'da kullanılacak foods dizisi
    var filteredFoods = [FAFood]() // SearcBar'ın filtrelediği data
    var viewModel = FAHomepageViewModel()
    var loginUser = Auth.auth().currentUser // FirebaseAuth tarafından sağlanan şu anki kullanıcı
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Custom CollectionViewCell xib'inin ViewController'a kayıt edilmesi
        collectionView.register(UINib(nibName: "FAHomepageFoodCell", bundle: nil), forCellWithReuseIdentifier: "FAHomepageFoodCell")
        
        // RxSwift tarafından izlenen ve viewModel'dan gelen foods dizisinin collectionView'de kullanılacak foods'a aktarılması
        var _ = viewModel.foods.subscribe { foods in
            self.foods = foods
            self.filteredFoods = foods
            DispatchQueue.main.async {
                self.collectionView.reloadData() // Değişiklikler otomatik güncellenir.
            }
            
        }
        
        // CollectionView görünümünün özelleştirilmesi
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 32, bottom: 10, right:32)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let itemWidth = (UIScreen.main.bounds.width - 74) / 2
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: 260)
        
        collectionView.collectionViewLayout = flowLayout
        
        searchBar.delegate = self
        
        if let tabBarController = self.tabBarController as? FATabBarController {
            tabBarController.customDelegate = self
        }
        
    }
    
    
}


// MARK: - extensions - CollectionView
extension FAHomepageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Kaç tane item olacak ?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredFoods.count
    }
    
    // Hücrelerin oluşturulması
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let food = filteredFoods[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FAHomepageFoodCell", for: indexPath) as! FAHomepageFoodCell // Custom CollectionViewCell'in kullanılması
        
        cell.foodImage.image = UIImage(named: food.food_image_name ?? "burger")
        cell.foodNameLabel.text = food.food_name
        cell.foodPriceLabel.text = "💲\(food.food_price!)"
        cell.cellContainerView.layer.cornerRadius = 15
        
        return cell
    }
    
    // Bir hücreye seçildiğinde yapılacaklar...
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true) // Seçim kapansın
        
        // OrderPopup ekranına geçilsin ve seçilen yemeğin nesnesi gönderilsin
        performSegue(withIdentifier: "FAHomepageToOrderPopupSegue", sender: foods[indexPath.row])
        
    }
    
    // Segue gerçekleşmeden önce hazırlık
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Belirtilen kimlikteki segue geçişi yapılırsa data aktarımı olsun.
        if segue.identifier == "FAHomepageToOrderPopupSegue" {
            if let data = sender as? FAFood {
                let destinationVC = segue.destination as! FAOrderPopupVC
                destinationVC.currentFood = data
            }
        }
        
    }
    
    
    
}

// MARK: - extension - searchBar

extension FAHomepageVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // SearcBar'a yazılan yazı FAFood'nesnesinin food_name özelliğine göre filtreleme yapıp bunu filteredFoods dizisine aktarır ve collectionViewde gösterilir.
        filteredFoods = searchText.isEmpty ? foods : foods.filter { $0.food_name?.range(of: searchText, options: .caseInsensitive) != nil }
        
        // Filtreleme işleminden sonra collectiınView güncellenmeli
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    
    
}

