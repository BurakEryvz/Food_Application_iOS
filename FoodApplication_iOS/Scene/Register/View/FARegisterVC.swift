//
//  FARegisterVC.swift
//  FoodApplication_iOS
//
//  Created by Burak Eryavuz.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FARegisterVC: UIViewController {

    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var createAnAccountButton: UIButton!
    
    let db = Firestore.firestore() // Firestore veritabanının bağlanması
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createAnAccountButton.setCustomColorShadow(radius: 10, opacity: 0.5, color: UIColor(named: "FAgradientColor1")!.cgColor)
        
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 15
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        confirmPasswordTextField.layer.masksToBounds = true
        confirmPasswordTextField.layer.cornerRadius = 15
        confirmPasswordTextField.layer.borderWidth = 0.5
        confirmPasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - IBActions
    @IBAction func createAnAccountButtonPressed(_ sender: UIButton) {
        
        // textFieldların kontrolü
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else {
            return
        }
        
        // Boş string kontrolü
        if email == "" || password == "" || confirmPassword == "" {
            
            // Her hangi bir textfield boş ise alert atar ve durdurur.
            let alert = FAHelper.createAlert(title: "Please fill all fields", message: "")
            self.present(alert, animated: true)
            return
        }
        
        if password != confirmPassword {
            
            // Password ve Confirm Password textfieldları eşleşmiyorsa alert atar ve durdurur
            let alert = FAHelper.createAlert(title: "Passwords do not match.", message: "")
            self.present(alert, animated: true)
            return
        }
        
        // FirebaseAuth ile kayıt olma işlemi (Email & password)
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                
                print("Error: \(err.localizedDescription)")
                // kayıt başarısız olursa alert atar ve işlemi durdurur.
                let alert = FAHelper.createAlert(title: "Your account could not be created, please try again with different values.", message: "")
                self.present(alert, animated: true)
                return
                
            } else {
                // Kayıt olduktan sonra login ekranına yönlendirme
                self.performSegue(withIdentifier: "FARegisterToLoginSegue", sender: nil)
                
            }
        }
        
    }
    
    @IBAction func signInToMyAccountButtonPressed(_ sender: UIButton) {
        
    }
    
}
