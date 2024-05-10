//
//  FAFavouritesVC.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz on 7.05.2024.
//

import UIKit

class FAFavouritesVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "FAHomepageFoodCell", bundle: nil), forCellWithReuseIdentifier: "FAHomepageFoodCell")
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 32, bottom: 10, right:32)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        let itemWidth = (UIScreen.main.bounds.width - 74) / 2
        
        flowLayout.itemSize = CGSize(width: itemWidth, height: 260)
        
        collectionView.collectionViewLayout = flowLayout
    }
    

   

}

extension FAFavouritesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FAHomepageFoodCell", for: indexPath) as! FAHomepageFoodCell
        
        return cell
    }
    
    
}
