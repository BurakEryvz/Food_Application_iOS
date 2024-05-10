//
//  FAOrderPopupViewModel.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation
import FirebaseAuth

class FAOrderPopupViewModel{
    var foodDaoRepo = FAFoodDaoRepository()
    let loginUser = Auth.auth().currentUser
    
    func addToCart(cart_food_id: String, user_id: String, user_name: String, cart_food_name: String, cart_food_price: String, cart_food_count: Int, cart_food_image_name: String, cart_food_unit_price: String) {
        
        foodDaoRepo.addToCart(cart_food_id: cart_food_id, user_id: user_id, user_name: user_name, cart_food_name: cart_food_name, cart_food_price: cart_food_price, cart_food_count: cart_food_count, cart_food_image_name: cart_food_image_name, cart_food_unit_price: cart_food_unit_price)
        foodDaoRepo.loadCartFoods(user_id: loginUser!.uid)
      
    }
}
