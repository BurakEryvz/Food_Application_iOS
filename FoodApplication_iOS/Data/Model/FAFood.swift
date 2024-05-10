//
//  FAFood.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation

// FAFood Modeli
class FAFood {
    var food_id: String?
    var food_name: String?
    var food_image_name: String?
    var food_price: String?
    
    init(food_id: String, food_name: String, food_image_name: String, food_price: String) {
        self.food_id = food_id
        self.food_name = food_name
        self.food_image_name = food_image_name
        self.food_price = food_price
    }
}


