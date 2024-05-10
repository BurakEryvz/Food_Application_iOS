//
//  FACartVC.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit
import RxSwift
import FirebaseAuth

class FACartVC: UIViewController, FACartFoodDelegate{
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var processToPaymentButton: UIButton!
    
    var viewModel = FACartViewModel() // ViewModel nesnesi
    var cartFoods = [FACartFood]() 
    
    var totalAmount: Int = 0 // calculateTotalAmount fonksiyonunda kullanılan global değişken
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // viewModeldan gelen ve RxSwift tarafından değişiklikleri izlenen cartFoods dizisinin buradaki cartFoods'a atanması
        var _ = viewModel.cartFoods.subscribe { cartFoods in
            self.cartFoods = cartFoods
            
            DispatchQueue.main.async {
                self.viewModel.loadFoods()
                self.tableView.reloadData() // bu sayede her değişiklikte otomatik olarak tableView güncelleneri
            }
        }
        
        processToPaymentButton.layer.cornerRadius = 20
        processToPaymentButton.setCustomColorShadow(radius: 3, opacity: 0.7, color: UIColor(named: "FAgradientColor1")!.cgColor)
        
        // Custom tableViewCell'in VC'a kayıt edilmesi
        tableView.register(UINib(nibName: "FACartFoodCell", bundle: nil), forCellReuseIdentifier: "FACartFoodCell")
        
        tableView.separatorStyle = .none
        
        calculateTotalAmount()
        
    }
    
    
    
   
    
    
    

    @IBAction func processToPaymentButtonPressed(_ sender: UIButton) {
        
    }
    
}

// MARK: - extension
extension FACartVC: UITableViewDelegate, UITableViewDataSource {
    
    // Kaç tane satır olacak ?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartFoods.count
    }
    
    // Hücrelerin oluşturulması
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FACartFoodCell", for: indexPath) as! FACartFoodCell
        
        let cartFood = cartFoods[indexPath.row]
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        cell.foodImageView.image = UIImage(named: cartFood.cart_food_image_name ?? "burger")
        cell.foodNameLabel.text = cartFood.cart_food_name
        cell.foodPriceLabel.text = "💲\(cartFood.cart_food_price!)"
        cell.foodCountLabel.text = String(cartFood.cart_food_count!)
    
        return cell
    }
    
    // Hücrenin yüksekliği
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144.0
    }
    
    // Hücreyi kaydırarak silme işlemi
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Firestore'dan ilgili belgeyi silme
            let selectedFood = cartFoods[indexPath.row]
            self.viewModel.removeCartFood(food_documentID: selectedFood.food_documentID!)
            totalAmount = totalAmount - Int(selectedFood.cart_food_price!)!
            totalAmountLabel.text = String(totalAmount)
       
        }
    }
    
    
    // TODO: Ekranda güncellenmiyor
    func minusButtonPressed(indexPath: IndexPath) {
        let selectedFood = cartFoods[indexPath.row]
        
        if selectedFood.cart_food_count! > 1 {
            viewModel.updateCartFood(food_documentID: selectedFood.food_documentID!, type: "MINUS")
   
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.totalAmount = 0
            calculateTotalAmount()
        }

    }
    
    func plusButtonPressed(indexPath: IndexPath) {
        let selectedFood = cartFoods[indexPath.row]
        
        viewModel.updateCartFood(food_documentID: selectedFood.food_documentID!, type: "PLUS")
        
        DispatchQueue.main.async {
            self.viewModel.updateCartFood(food_documentID: selectedFood.food_documentID!, type: "PLUS")
            self.tableView.reloadData()
        }
        self.totalAmount = 0
        calculateTotalAmount()
    }
    
    func calculateTotalAmount() {
        for food in cartFoods {
            totalAmount = totalAmount + Int(food.cart_food_price!)!
            
        }
        totalAmountLabel.text = String(totalAmount)
    }
    
    
    
}
