//
//  FAFoodDaoRepository.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation
import RxSwift
import FirebaseFirestore



class FAFoodDaoRepository {
    
    
    var foodsList = BehaviorSubject<[FAFood]>(value: [FAFood]()) // RxSwift Tarafından izlenen foodList dizisi
    var cartFoodsList = BehaviorSubject<[FACartFood]>(value: [FACartFood]()) // RxSwift tarafından izlenen cartFoodList dizisi
    
    let db = Firestore.firestore()
    
    
    func loadFoods() {
        
        var foods = [FAFood]() // Firestoredan gelen verilerin tutulacağı dizi
        
        db.collection("Foods").addSnapshotListener { querySnapshot, error in // Realtime olarak Foods koleksiyonunun izlenmesi
            
            if let err = error {
                
                print("Error: \(err.localizedDescription)")
                
            } else {
                
                if let documents = querySnapshot?.documents {
                    
                    for document in documents { // Dökümanlar arasında gezinme
                        
                        let data = document.data()
                        
                        // Firestoredaki fieldların değişkenlere atanması işlemi
                        let food_id = document.documentID
                        let food_name = data["food_name"] as? String ?? "Null"
                        let food_image_name = data["food_image_name"] as? String ?? "Null"
                        let food_price = data["food_price"] as? String ?? "Null"
                        
                        // Firestoredan gelen verilerle food nesnesi oluşturulur
                        let food = FAFood(food_id: food_id, food_name: food_name, food_image_name: food_image_name, food_price: food_price)
                        
                        // Oluşturulan nesne foods dizisine aktarılır
                        foods.append(food)
                        
                    }
                }
                // foods dizisi RxSwift tarafından izlenen foodsList dizisine aktarılır.
                self.foodsList.onNext(foods)
            }
        }
    }
    
    func addToCart(cart_food_id: String, user_id: String, user_name: String, cart_food_name: String, cart_food_price: String, cart_food_count: Int, cart_food_image_name: String, cart_food_unit_price: String) {
        
        var ref: DocumentReference? = nil
        
        // Firestore'daki CartFoods koleksiyonuna yeni döküman ekleme işlemi
        ref = db.collection("CartFoods").addDocument(data: [
            
            // Oluşturulacak fieldlar
            "cart_food_unit_price": cart_food_unit_price,
            "cart_food_id" : cart_food_id,
            "user_id" : user_id,
            "user_name" : user_name,
            "cart_food_name" : cart_food_name,
            "cart_food_price" : cart_food_price,
            "cart_food_count" : cart_food_count,
            "cart_food_image_name": cart_food_image_name
            
        ], completion: { error in
            
            if let err = error {
                // Döküman ekleme başarısızı olduğunda yapılacaklar...
                print("Error: \(err)")
                
            } else {
                // Döküman ekleme başarılı olduğu durumda yapılacaklar...
                print("Document added with ID: \(ref!.documentID)")
                
            }
        })
    }
    
    func loadCartFoods(user_id: String) {
        
        var cartFoods = [FACartFood]() // Firestore'dan gelecek verilerin aktarılacağı cartFoods dizisi
        
        let query = db.collection("CartFoods").whereField("user_id", isEqualTo: user_id) // CartFoods koleksiyonundaki belirlenen user_id'deki dökümanları işaret eden sorgu
        
        query.getDocuments { querySnapshot, error in // sorgunun gerçek zamanlı olarak dinlenmesi
            
            if let err = error {
                
                print("Error: \(err.localizedDescription)")
                
            } else {
                
                if let documents = querySnapshot?.documents {
                    
                    for document in documents { // Tüm dökümanlar arasında gezinme
                        let data = document.data()
                        
                        // Firestoredaki verilerin değişkenlere atanması işlemi
                        let food_documentID = document.documentID as? String
                        let cart_food_id = data["cart_food_id"] as? String ?? "Null"
                        let user_id = data["user_id"] as? String ?? "Null"
                        let user_name = data["user_name"] as? String ?? "Null"
                        let cart_food_name = data["cart_food_name"] as? String ?? "Null"
                        let cart_food_image_name = data["cart_food_image_name"] as? String ?? "Null"
                        let cart_food_price = data["cart_food_price"] as? String ?? "Null"
                        let cart_food_count = data["cart_food_count"] as? Int ?? 1
                        let cart_food_unit_price = data["cart_food_unit_price"] as? String ?? "Null"
                        
                        // Değişkenlerle cartFood nesnesi oluşturulur.
                        let cartFood = FACartFood(cart_food_id: cart_food_id, user_id: user_id, user_name: user_name, cart_food_name: cart_food_name, cart_food_price: cart_food_price, cart_food_count: cart_food_count, cart_food_image_name: cart_food_image_name, food_documentID: food_documentID, cart_food_unit_rpice: cart_food_unit_price)
                        
                        // Yeni cartFood nesnesi cartFoods dizisine eklenir.
                        cartFoods.append(cartFood)
                    }
                }
                // cartFoods dizisi RxSwift tarafından dinlenen cartFoodsList dizisine aktarılır.
                self.cartFoodsList.onNext(cartFoods)
            }
            
        }
        
    }
    
  
    func removeCartFood(food_documentID: String) {
        
        db.collection("CartFoods").document(food_documentID).delete { error in // Belirlenen documentID'li dökümanın silinme işlemi
            
            if let err = error {
                
                print("Error: \(err)") // Silme işlemi başarısız olursa yapılacaklar...
                
            } else {
                
                print("Food removed.") // Silme işlemi başarılı olursa yapılacaklar...
            }
        }
    }
    
    func updateCartFood(food_documentID: String, type: String) {
        let documentRef = db.collection("CartFoods").document(food_documentID)
        
        documentRef.getDocument { document, error in
            
            if let err = error {
                print("updateCartFood document couldn't fetched : \(err)")
            } else {
                
                let data = document?.data()
                
                if var old_cart_food_count = data?["cart_food_count"] as? Int, var old_cart_food_price = data?["cart_food_price"] as? String, var old_cart_food_unit_price = data?["cart_food_unit_price"] as? String {
                    
                    var new_cart_food_count = 0
                    var new_cart_food_price = ""
                    
                    if type == "PLUS" {
                        new_cart_food_count = old_cart_food_count + 1
                        new_cart_food_price = String(Int(old_cart_food_unit_price)! * new_cart_food_count)
                    }
                    
                    if type == "MINUS" {
                        new_cart_food_count = old_cart_food_count - 1
                        new_cart_food_price =  String(Int(old_cart_food_unit_price)! * new_cart_food_count)
                    }
                    
                    documentRef.updateData(
                        [
                            "cart_food_price" : new_cart_food_price,
                            "cart_food_count": new_cart_food_count
                        ]) { error in
                            
                            if let err = error {
                                print("updateCartFood document couldn't updated.")
                            }
                        }
                }
            }
        }
    }
    
    
    
    
    
    
    
    
}
