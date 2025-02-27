//
//  AlertBoxExtension.swift
//  Assignment
//
//  Created by Keval Thumar on 25/02/25.
//

import Foundation
import UIKit

extension UIViewController {
    public func openAlert(title: String,
                          message: String,
                          alertStyle: UIAlertController.Style,
                          actionTitle: String,
                          actionStyle: UIAlertAction.Style,
                          action: ((UIAlertAction) -> Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let alertAction = UIAlertAction(title: actionTitle, style: actionStyle, handler: action)
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true)
    }
}
