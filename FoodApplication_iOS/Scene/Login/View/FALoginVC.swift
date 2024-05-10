//
//  FALoginVC.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit
import FirebaseAuth

class FALoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginToMyAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.text = "admin6@gmail.com" // Silinecek
        passwordTextField.text = "123456" // Silinecek

        loginToMyAccountButton.setCustomColorShadow(radius: 10, opacity: 0.5, color: UIColor(named: "FAgradientColor1")!.cgColor)
        
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    // MARK: IBActions
    @IBAction func loginToMyAccountButtonPressed(_ sender: UIButton) {
        
        // Email ve password yazıldı mı ?
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        // Boş ise durdur ve alert ver
        if email == "" || password == "" {
            let alert = FAHelper.createAlert(title: "Please fill all fields", message: "")
            present(alert, animated: true)
            return
        }
        
        // Firebase ile giriş yapma işlemi (email & password)
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err = error {
                
                print("Error: \(err.localizedDescription)")
                let alert = FAHelper.createAlert(title: "Failed to log in", message: "") // hata olursa alert at
                self.present(alert, animated: true)
                
            } else {
                
                // Giriş işlemi başarılı olduktan sorna yapılacaklar...
                print("User signed in")
                self.performSegue(withIdentifier: "FALoginToHomepageSegue", sender: nil) // Homepage ekranına geç
            }
        }
    }
    
    @IBAction func createAnAccountButtonPressed(_ sender: UIButton) {
        
    }
    
}
