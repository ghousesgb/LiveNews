//
//  ActivityIndicatorUtility.swift
//  LiveNews
//
//  Created by Ghouse Basha Shaik on 24/09/19.
//  Copyright © 2019 Ghouse Basha Shaik. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorUtility {
    static var container: UIView = UIView()
    static var loadingView: UIView = UIView()
    static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     @param uiView - add activity indicator to this view
     */
    static func showActivityIndicator(uiView: UIView) {
        uiView.accessibilityIdentifier = "ActivityIndicatorView"
        container.frame = uiView.bounds
        container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        loadingView.frame =  CGRect.init(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = CGPoint.init(x: uiView.frame.size.width / 2, y: uiView.frame.size.height / 2)
        loadingView.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint.init(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }

    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     @param uiView - remove activity indicator from this view
     */
    static func hideActivityIndicator(uiView: UIView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            container.removeFromSuperview()
        }
    }

}
