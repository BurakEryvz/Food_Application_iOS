//
//  FAHomepageFoodCell.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit

class FAHomepageFoodCell: UICollectionViewCell {

    
    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var addToFavouriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContainerView.layer.cornerRadius = 15
        
    }
    
    
    @IBAction func addToFavouriteButtonPressed(_ sender: UIButton) {
        
    }
    

}
