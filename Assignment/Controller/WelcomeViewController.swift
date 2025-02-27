//
//  WelcomeViewController.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var dateText: UIDatePicker!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var gender: UIButton!

    // Gender Button Click
    @IBAction func onClickGender(_ sender: UIAction) {
        self.gender.setTitle(sender.title, for: .normal)
    }

    func getUser() -> UserModel? {
        if let savedData = UserDefaults.standard.data(forKey: "userModel"),
            let decodedUser = try? JSONDecoder().decode(
                UserModel.self, from: savedData)
        {
            return decodedUser
        }
        return nil
    }

    override func viewDidLoad() {
        let user = getUser()
        if let userData = user {
            firstNameText.text = userData.firstName
            lastNameText.text = userData.lastName
            gender.setTitle(
                userData.gender == 1 ? "Male" : "Female", for: .normal)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = dateFormatter.date(from: userData.dob ?? "") {
                dateText.date = date
            }

            height.text =
                "\(userData.heightFeet ?? 0)'\(userData.heightInch ?? 0)\" or \(userData.heightCM ?? 0) cm"
        }

    }
    // Save Data Button
    @IBAction func sendData(_ sender: UIButton) {
        guard let firstName = firstNameText.text, !firstName.isEmpty,
            let lastName = lastNameText.text, !lastName.isEmpty,
            let heightValue = height.text, !heightValue.isEmpty,
            let genderValue = gender.titleLabel?.text,
            genderValue != "Select Gender"
        else {
            openAlert(
                title: "Alert", message: "Please add details.",
                alertStyle: .alert, actionTitle: "Okay", actionStyle: .default
            ) { _ in
                print("Okay clicked!")
            }
            return
        }

        let birthDate = formatDate(dateText.date)  //date to string

        let isInserted = DatabaseHelper.shared.insertUser(
            firstName: firstName, lastName: lastName, height: heightValue,
            birthDate: birthDate, gender: genderValue)

        if isInserted {

            openAlert(
                title: "Success", message: "Data saved successfully!",
                alertStyle: .alert, actionTitle: "OK", actionStyle: .default
            ) { _ in
                self.firstNameText.text = ""
                self.lastNameText.text = ""
                self.height.text = ""
                self.dateText.date = Date()
                self.gender.setTitle("Select Gender", for: .normal)
            }

        } else {
            openAlert(
                title: "Error",
                message: "Failed to save data. Please try again.",
                alertStyle: .alert, actionTitle: "OK", actionStyle: .destructive
            ) { _ in
                print("Failed to save data")
            }
        }
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

}
