//
//  UIHelper.swift


import Foundation
import UIKit
import SwiftMessages

public class UIHelper: NSObject {
    
    
    public static func showSuccessMessage(_ message: String){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.button?.removeFromSuperview()
        view.configureContent(title: Utils.localizedString(forKey: "successTitle"), body: message)
        
        let config = UIHelper.getShowMessageConfig()
        SwiftMessages.show(config: config, view: view)
    }
    
    public static func showErrorMessage(_ message: String){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.button?.removeFromSuperview()
        view.configureContent(title: Utils.localizedString(forKey: "errorTitle"), body: message)
        let config = UIHelper.getShowMessageConfig()
        SwiftMessages.show(config: config, view: view)
    }
    
    private static func getShowMessageConfig() -> SwiftMessages.Config{
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        return config
    }
    

}

