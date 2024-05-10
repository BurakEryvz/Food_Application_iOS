//
//  FAHomepageViewModel.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation
import RxSwift



class FAHomepageViewModel{
    
    var foodDaoRepo = FAFoodDaoRepository()
    var foods = BehaviorSubject<[FAFood]>(value: [FAFood]()) // RxSwift tarafından izlenen foods dizisi
    
    init() {
        foods = foodDaoRepo.foodsList // foodDaoRepository'den gelen foodList'i buradaki foods'a aktarma
        foodDaoRepo.loadFoods()
    }
    
    func loadFoods() {
        foodDaoRepo.loadFoods()
    }
}
