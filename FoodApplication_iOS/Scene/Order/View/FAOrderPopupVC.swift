//
//  FAOrderPopupVC.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit
import FirebaseAuth

class FAOrderPopupVC: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var orderCountContainerView: UIView!
    @IBOutlet weak var orderCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodPriceLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    var currentFood: FAFood? // Homepageden segue ile gelen seçilen yemek nesnesi
    var viewModel = FAOrderPopupViewModel()
    var loginUser = Auth.auth().currentUser // FirebaseAuth tarafından sağlanan şu anki kullanıcı bilgileri
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.setDefaultShadow(radius: 5, opacity: 0.2)
        addToCartButton.setCustomColorShadow(radius: 10, opacity: 0.5, color: UIColor(named: "FAgradientColor1")!.cgColor)
        
        if let name = currentFood?.food_name, let imageName = currentFood?.food_image_name, let price = currentFood?.food_price, let id = currentFood?.food_id {
            foodNameLabel.text = name
            foodImageView.image = UIImage(named: imageName)
            foodPriceLabel.text = price
        }
        
        // Popup açıldığında kendi UIView'ının dışına tıklandığında kaptılmasını sağlayan kod
        let tapControl = UIControl(frame: containerView.bounds)
        tapControl.backgroundColor = UIColor.clear
        tapControl.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        view.addSubview(tapControl)
        
        
    }
    
    // Popup açıldığında kendi UIView'ının dışına tıklandığında kaptılmasını sağlayan kod
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Ekranda herhangi bir yere tıklandığında dismiss işlemini gerçekleştirin
        dismiss(animated: true, completion: nil)
    }
    

    
    // MARK: - IBActions
    
    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
        
        if let cart_food_id = currentFood?.food_id, let cart_food_name = currentFood?.food_name, let cart_food_price = currentFood?.food_price, let cart_food_image_name = currentFood?.food_image_name {
            
            // Kullancının seçimlerine göre sepetine (Firestore: CartFoods) yemeği ekleyen kod
            viewModel.addToCart(cart_food_id: cart_food_id, user_id: loginUser!.uid, user_name: "burak", cart_food_name: cart_food_name, cart_food_price: String(Int(stepper.value) * Int(cart_food_price)!), cart_food_count: Int(stepper.value), cart_food_image_name: cart_food_image_name, cart_food_unit_price: cart_food_price)
            
            
        }
    }
    
    // UIStepper'ın değeri değiştiğinde sipariş sayısını değiştiren kod
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        orderCountLabel.text = String(Int(stepper.value))
    }
    


}
