//
//  FACartFoodCell.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit

protocol FACartFoodDelegate {
    func minusButtonPressed(indexPath: IndexPath)
    func plusButtonPressed(indexPath: IndexPath)
}

class FACartFoodCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var foodImageContainerView: UIView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var foodCountLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    
    var delegate: FACartFoodDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 15
        containerView.setDefaultShadow(radius: 3, opacity: 0.1)
        foodImageContainerView.layer.cornerRadius = 20
        foodImageContainerView.setDefaultShadow(radius: 3, opacity: 0.1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        delegate?.minusButtonPressed(indexPath: self.indexPath!)
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        delegate?.plusButtonPressed(indexPath: self.indexPath!)
    }
    
}
