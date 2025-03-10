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
            AlertBoxExtension.shared.showAlert(title: "Alert", message: "Please add details.", viewController: self, style: .default)
            return
        }
        
        if !email.validateEmailId() {
            AlertBoxExtension.shared.showAlert(title: "Alert", message: "Invalid email address.", viewController: self, style: .default)
        } else if password.count < 6 {
            AlertBoxExtension.shared.showAlert(title: "Alert", message: "Please enter a valid password.", viewController: self, style: .default)
        } else {
            login(withEmail: email, withPassword: password)
        }
    }
    
    func saveUser(_ user: UserModel) {
        let success = DatabaseHelper.shared.insertUser(firstName: user.firstName ?? "", lastName: user.lastName ?? "", height: "\(user.heightFeet  ?? 0)' \(user.heightInch ?? 0)\"", birthDate: user.dob  ?? "", gender: user.gender == 0 ? "Male" : "Female", email: emailText.text ?? "", viewController: self)

        if success {
            UserDefaults.standard.set(emailText.text, forKey: "email")
            let welcomeVC = self.storyboard?.instantiateViewController(identifier: "WelcomeViewController") as! WelcomeViewController
            self.navigationController?.pushViewController(welcomeVC, animated: true)
        }
    }

    private func login(withEmail email: String, withPassword password: String) {
        ApiCaller.shared.getUserData(email: email, password: password) { result in
            switch result {
            case .success(let userData):
                self.saveUser(userData)
                
            case .failure(let error):
                var errorMessage = "Something went wrong. Please try again."

                if let apiError = error as? ApiError {
                    switch apiError {
                    case .requestFailed(let err):
                        errorMessage = "Request failed: \(err.localizedDescription)"
                    case .invalidCredentials:
                        errorMessage = "Invalid email or password."
                    }
                } else {
                    errorMessage = error.localizedDescription
                }

                DispatchQueue.main.async {
                    AlertBoxExtension.shared.showAlert(title: "Login Failed", message: errorMessage, viewController: self, style: .destructive)
                }
            }
        }
    }
}
