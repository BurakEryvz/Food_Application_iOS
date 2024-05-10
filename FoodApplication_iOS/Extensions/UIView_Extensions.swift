//
//  UIView_Extensions.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import Foundation
import UIKit

extension UIView {
    
    // Belirli kenarların yuvalarlanması için fonksiyonun
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    // Eni ve boyu eşit olan UIView'ları dairesel yapan fonksiyon
    func circleView(borderWidth: CGFloat, borderColor: CGColor) {
        layer.cornerRadius = (frame.size.width) / 2
        clipsToBounds = false
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        
    }
    
    // Default olarak kullandığım gölge
    func setDefaultShadow(radius: CGFloat, opacity: Float) {
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = opacity
    }
    
    // Rengi, açısı ve opaklığı değiştirilebilen göngelendirme fonksiyonu
    func setCustomColorShadow(radius: CGFloat, opacity: Float, color: CGColor) {
        layer.shadowRadius = radius
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowOpacity = opacity
        layer.shadowColor = color
    }
    
}
