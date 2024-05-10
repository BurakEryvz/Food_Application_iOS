//
//  FAHelper.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation
import UIKit

struct FAHelper {
    
    // Global olarak erişilebilen bir Alert oluşturma fonksiyonu
    static func createAlert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Okey", style: .cancel) { action in
            // Okey butonu tıklandıktan sonra yapılacaklar buraya eklenebilir...
        }
        
        alert.addAction(okAction)
        
        return alert
    }
    
}
