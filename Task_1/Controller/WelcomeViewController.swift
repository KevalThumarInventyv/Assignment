//
//  WelcomeViewController.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//
import UIKit

enum Gender: String {
    case male = "Male"
    case female = "Female"
}

public struct HeightModel {
    var feet: Int
    var inches: Int

    var formatted: String {
        return "\(feet)' \(inches)\""
    }
}

class WelcomeViewController: UIViewController, UIPickerViewDelegate,
    UIPickerViewDataSource
{

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var datePickerDOB: UIDatePicker!
    @IBOutlet weak var pickerHeight: UIPickerView!

    let feetRange = Array(0...7)
    let inchesRange = Array(0...11)

    var selectedGender: Gender?
    var selectedHeight = HeightModel(feet: 0, inches: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerHeight.delegate = self
        pickerHeight.dataSource = self

        loadUserData()
    }

    func loadUserData() {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            AlertBoxExtension.shared.showAlert(
                title: "Error!",
                message: "You not logged in yet. Please login first.",
                viewController: self,
                style: .destructive
            )
            return
        }

        //        get data from the data base to update UI.
        if let user = DatabaseHelper.shared.getUserData(email: email) {

            txtFirstName.text = user.firstName
            txtLastName.text = user.lastName

            selectedGender = user.gender == "Male" ? .male : .female
            updateGenderButtons()

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            if let date = dateFormatter.date(from: user.birthDate) {
                datePickerDOB.date = date
            }

            print(user.height)
            let components = user.height.split(separator: "'")

            if components.count == 2 {
                let feetString = components[0].trimmingCharacters(
                    in: .whitespaces)
                let inchesString = components[1].replacingOccurrences(
                    of: "\"", with: ""
                ).trimmingCharacters(in: .whitespaces)

                if let feet = Int(feetString), let inches = Int(inchesString) {
                    selectedHeight = HeightModel(
                        feet: feet, inches: inches)
                    pickerHeight.selectRow(
                        feet, inComponent: 0, animated: false)
                    pickerHeight.selectRow(
                        inches, inComponent: 1, animated: false)
                }
            }

        }
    }

    @IBAction func btnFemaleTapped(_ sender: UIButton) {
        selectedGender = .female
        updateGenderButtons()
    }

    @IBAction func btnMaleTapped(_ sender: UIButton) {
        selectedGender = .male
        updateGenderButtons()
    }

    func updateGenderButtons() {
        btnMale.setImage(
            UIImage(
                systemName: selectedGender == .male
                    ? "largecircle.fill.circle" : "circle"), for: .normal)
        btnFemale.setImage(
            UIImage(
                systemName: selectedGender == .female
                    ? "largecircle.fill.circle" : "circle"), for: .normal)
    }

    @IBAction func btnSaveDataTapped(_ sender: UIButton) {
        guard let firstName = txtFirstName.text, !firstName.isEmpty,
            let lastName = txtLastName.text, !lastName.isEmpty,
            let genderValue = selectedGender?.rawValue
        else {
            AlertBoxExtension.shared.showAlert(
                title: "Alert",
                message: "Please add all details.",
                viewController: self,
                style: .default
            )
            return
        }

        let birthDate = formatDate(datePickerDOB.date)
        let heightString = selectedHeight.formatted
        let email = UserDefaults.standard.string(forKey: "email") ?? ""

        let isUpdated = DatabaseHelper.shared.updateUser(
            firstName: firstName,
            lastName: lastName,
            height: heightString,
            birthDate: birthDate,
            gender: genderValue,
            email: email,
            viewController: self
        )

        if isUpdated {
            AlertBoxExtension.shared.showAlert(
                title: "Success",
                message: "Data saved successfully!",
                viewController: self,
                style: .default
            ) { _ in
                self.resetForm()
                print("Go to dashboard")
            }
        } else {
            AlertBoxExtension.shared.showAlert(
                title: "Error",
                message: "Failed to save data. Please try again.",
                viewController: self,
                style: .destructive
            )
        }
    }

    func resetForm() {
        txtFirstName.text = ""
        txtLastName.text = ""
        datePickerDOB.date = Date()
        selectedGender = nil
        updateGenderButtons()
        selectedHeight = HeightModel(feet: 0, inches: 0)
        pickerHeight.selectRow(0, inComponent: 0, animated: false)
        pickerHeight.selectRow(0, inComponent: 1, animated: false)
    }

    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: date)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(
        _ pickerView: UIPickerView, numberOfRowsInComponent component: Int
    ) -> Int {
        return component == 0 ? feetRange.count : inchesRange.count
    }

    func pickerView(
        _ pickerView: UIPickerView, titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return component == 0 ? "\(feetRange[row])'" : "\(inchesRange[row])\""
    }

    func pickerView(
        _ pickerView: UIPickerView, didSelectRow row: Int,
        inComponent component: Int
    ) {
        if component == 0 {
            selectedHeight.feet = feetRange[row]
        } else {
            selectedHeight.inches = inchesRange[row]
        }
    }
}
