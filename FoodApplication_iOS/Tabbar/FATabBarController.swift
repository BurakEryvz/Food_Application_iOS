//
//  FATabBarController.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit

protocol FATabBarControllerDelegate {
    func tabBarSearchButtonPressed()
}


class FATabBarController: UITabBarController{

    @IBOutlet weak var homepageButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var searchButtonContainerView: UIView!
    @IBOutlet weak var tabBarContainerView: UIView!
    
    // Custom colorların değişkenlere atanması
    var defaultItemColor: UIColor = UIColor(named: "FAdarkGrayColor")!
    var selectedItemColor: UIColor = UIColor(named: "FAprimaryColor")!
    var customDelegate: FATabBarControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = 0 // Ekrana ilk önce indexi 0 olan sayfa gelsin
        
        homepageButton.tintColor = selectedItemColor
        cartButton.tintColor = defaultItemColor
        
        homepageButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
        cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
        
        view.addSubview(tabBarContainerView)
        
        // tabBar'ın ekrandaki konumlandırılması
        tabBarContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabBarContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tabBarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tabBarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        searchButtonContainerView.circleView(borderWidth: 0, borderColor: UIColor.white.cgColor)
        
        searchButtonContainerView.setCustomColorShadow(radius: 10, opacity: 0.5, color: UIColor(named: "FAgradientColor1")!.cgColor)
        
        tabBarContainerView.setCustomColorShadow(radius: 3, opacity: 0.3, color: UIColor(named: "FAdarkGrayColor")!.cgColor)
       
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        change(tabIndex: sender.tag)
        
        
        // tıklanan butonun tag'ine göre selectedIndex (görünen sayfa) ve butonların şeklinin değişmesi işlemi
        func change(tabIndex: Int) {
            
            switch tabIndex {
            case 0:
                print("homepage tiklandi")
                homepageButton.tintColor = selectedItemColor
                cartButton.tintColor = defaultItemColor
                
                homepageButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
                cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
            case 1:
                print("cart tiklandi")
                homepageButton.tintColor = defaultItemColor
                cartButton.tintColor = selectedItemColor
                
                homepageButton.setImage(UIImage(systemName: "house"), for: .normal)
                cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
            default:
                print("Default state")
                homepageButton.tintColor = selectedItemColor
                cartButton.tintColor = defaultItemColor
                
                homepageButton.setImage(UIImage(systemName: "house.fill"), for: .normal)
                cartButton.setImage(UIImage(systemName: "cart"), for: .normal)
            }
            selectedIndex = tabIndex
        }
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        customDelegate?.tabBarSearchButtonPressed()
    }
    
    

}
