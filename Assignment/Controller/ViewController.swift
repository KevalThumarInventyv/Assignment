//
//  ViewController.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickOnLogin(_ sender: UIButton) {
        validateLoginInputs()
    }
    
    private func validateLoginInputs() {
        guard let email = emailText.text, !email.isEmpty,
              let password = passwordText.text, !password.isEmpty else {
            openAlert(title: "Alert", message: "Please add details.", alertStyle: .alert, actionTitle: "Okay", actionStyle: .default, action: { _ in
                print("Okay clicked!")
            })
            return
        }
        
        if !email.validateEmailId() {
            openAlert(title: "Alert", message: "Invalid email address.", alertStyle: .alert, actionTitle: "Okay", actionStyle: .default, action: { _ in
                print("Okay clicked!")
            })
        } else if password.count < 6 {
            openAlert(title: "Alert", message: "Please enter a valid password.", alertStyle: .alert, actionTitle: "Okay", actionStyle: .default, action: { _ in
                print("Okay clicked!")
            })
        } else {
            login(withEmail: email, withPassword: password)
        }
    }
    
    func saveUser(_ user: UserModel) {
        if let encodedData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedData, forKey: "userModel")
        }
    }

 
    
    private func login(withEmail email: String, withPassword password: String) {
        ApiCaller.shared.getUserData(email: email, password: password) { result in
            switch result {
            case .success(let userData):
                print(userData)
                
                DispatchQueue.main.async {
                    if let welcomeVC = self.storyboard?.instantiateViewController(identifier: "WelcomeViewController") as? WelcomeViewController {
                        self.saveUser(userData)
                        if let navController = self.navigationController {
                            navController.pushViewController(welcomeVC, animated: true)
                        } else {
                            welcomeVC.modalPresentationStyle = .fullScreen
                            self.present(welcomeVC, animated: true)
                        }
                    } else {
                        print("Failed to instantiate WelcomeViewController")
                    }
                }
                
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.openAlert(title: "Login Failed", message: "Invalid email or password", alertStyle: .alert, actionTitle: "Okay", actionStyle: .default, action: { _ in
                        print("Okay clicked!")
                    })
                }
            }
        }
    }
}
