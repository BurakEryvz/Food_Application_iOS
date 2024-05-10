//
//  FACartViewModel.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation
import RxSwift
import FirebaseAuth

class FACartViewModel {
    var foodDaoRepo = FAFoodDaoRepository() // foodDaoRepository nesnesinin tanımlanması
    var cartFoods = BehaviorSubject<[FACartFood]>(value: [FACartFood]()) // RxSwift tarafından izlenen cartFoods dizisi
    
    var logginUser = Auth.auth().currentUser // FirebaseAuth tarafından sağlanan ve şu anki giriş yapan kullanıcının bazı özelliklerini tutan değişken.
    
    init() {
        // ViewModel nesnesi oluşturulduğunda yapılacakalar...
        cartFoods = foodDaoRepo.cartFoodsList
        foodDaoRepo.loadCartFoods(user_id: logginUser!.uid)
    }
    
    func loadFoods() {
        foodDaoRepo.loadCartFoods(user_id: logginUser!.uid)
    }
    
    func removeCartFood(food_documentID: String) {
        foodDaoRepo.removeCartFood(food_documentID: food_documentID)
        foodDaoRepo.loadCartFoods(user_id: logginUser!.uid)
    }
    
    func updateCartFood(food_documentID: String, type: String) {
        foodDaoRepo.updateCartFood(food_documentID: food_documentID, type: type)
        foodDaoRepo.loadCartFoods(user_id: logginUser!.uid)
    }
}
