//
//  AlertBoxExtension.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import Foundation
import UIKit

class AlertBoxExtension {
    static let shared = AlertBoxExtension()
    private init() {

    }

    func showAlert(
        title: String,
        message: String,
        viewController: UIViewController,
        style: UIAlertAction.Style,
        handler: ((UIAlertAction) -> Void)? = nil
    ) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(
                title: title, message: message, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: style, handler: handler)
            
            alertController.addAction(alertAction)
            viewController.present(alertController, animated: true)
        }
    }


}
