//
//  FAGreetingsVC.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit
import Lottie

class FAGreetingsVC: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var animationContainerView: UIView!
    @IBOutlet weak var createAnAccountButton: UIButton!
    
    private var animationView = LottieAnimationView(name: "FAgreetingsAnimation") // Lottie Animation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnAccountButton.setCustomColorShadow(radius: 10, opacity: 0.5, color: UIColor(named: "FAgradientColor1")!.cgColor)
        
        animationView.frame = animationContainerView.frame // Tanımlanan animation'a containerView'in frame'i verilir
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop // animasyon döngüde çalışsın
        animationView.animationSpeed = 0.5 // animasyon 0.5 hızında çalışsın
        
        view.addSubview(animationView) // animasyonun ana view'a eklenmesi
        
        // animationView'ın ekrandaki konumlandırılışı
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: animationContainerView.topAnchor, constant: 0),
            animationView.bottomAnchor.constraint(equalTo: animationContainerView.bottomAnchor, constant: 0),
            animationView.leadingAnchor.constraint(equalTo: animationContainerView.leadingAnchor, constant: 0),
            animationView.trailingAnchor.constraint(equalTo: animationContainerView.trailingAnchor, constant: 0)
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animationView.play() 
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        animationView.stop()
    }
    
    
    @IBAction func createAnAccountButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
    }
    
}
