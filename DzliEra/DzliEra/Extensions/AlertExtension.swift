//
//  AlertExtension.swift
//  DzliEra
//
//  Created by Levan Loladze on 04.03.24.
//

import Foundation
import UIKit

extension UIViewController {
    //Show a basic alert
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: nil))
        //Add more actions
        self.present(alert, animated: true, completion: nil)
    }
}
