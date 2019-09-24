//
//  AlertController.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    var alert : UIAlertController?
    
    func showAlert(_ title: String? = nil,
                      message: String? = nil,
                      okButtonTitle: String? = nil,
                      okButtonStyle: UIAlertAction.Style = .default,
                      okButtonHandler:((UIAlertAction?) -> Void)? = nil ,
                      cancelButtonTitle: String? = nil,
                      cancelButtonStyle: UIAlertAction.Style = .default,
                      cancelButtonHandler:((UIAlertAction?) -> Void)? = nil,
                      CompletionHandler:(() -> Void)? = nil,
                      View : UIViewController) {
        
        if (cancelButtonTitle == nil && okButtonTitle == nil) {
            dismissAlert()
        }
        
        alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if okButtonTitle != nil { alert?.addAction(UIAlertAction(title: okButtonTitle, style: okButtonStyle, handler: okButtonHandler)) }
        if cancelButtonTitle != nil { alert?.addAction( UIAlertAction(title: cancelButtonTitle, style: cancelButtonStyle, handler: cancelButtonHandler)) }
        
        if View.presentedViewController == nil {
            DispatchQueue.main.async(execute: {
                guard let nAlert = self.alert else { return }
                View.present(nAlert, animated: true, completion: CompletionHandler)
            })
        }
        
        // Auto dismiss alert with delay if no buttons were added
        if (cancelButtonTitle == nil && okButtonTitle == nil) {
            // Delay the dismissal by 1 seconds
            let delay = (2 * Double(NSEC_PER_SEC))
            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: time, execute: {
                self.alert?.dismiss(animated: true, completion: CompletionHandler)
            })
        }
    }
    
    func dismissAlert(_ Completion_Handler:(() -> Void)? = nil) {
        alert?.dismiss(animated: true, completion: Completion_Handler)
    }
    
}
