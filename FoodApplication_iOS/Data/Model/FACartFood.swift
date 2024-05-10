//
//  FACartFood.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation

// FACartFood Modeli
class FACartFood {
    var cart_food_id: String?
    var user_id: String?
    var user_name: String?
    var cart_food_name: String?
    var cart_food_price: String?
    var cart_food_unit_price: String?
    var cart_food_count: Int?
    var cart_food_image_name: String?
    var food_documentID: String?
    
    init(cart_food_id: String, user_id: String, user_name: String, cart_food_name: String, cart_food_price: String, cart_food_count: Int, cart_food_image_name: String, food_documentID: String? = nil, cart_food_unit_rpice: String) {
        self.cart_food_id = cart_food_id
        self.user_id = user_id
        self.user_name = user_name
        self.cart_food_name = cart_food_name
        self.cart_food_price = cart_food_price
        self.cart_food_count = cart_food_count
        self.cart_food_image_name = cart_food_image_name
        self.food_documentID = food_documentID
        self.cart_food_unit_price = cart_food_unit_rpice
    }
}
