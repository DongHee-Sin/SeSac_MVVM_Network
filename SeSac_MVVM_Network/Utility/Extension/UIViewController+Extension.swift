//
//  UIViewController+Extension.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import UIKit


extension UIViewController {
    
    // MARK: - Alert
    typealias CompletionHandler = (UIAlertAction) -> Void
    
    func showAlert(title: String, message: String? = nil, buttonTitle: String = "확인", cancelTitle: String? = nil, completionHandler: CompletionHandler? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: buttonTitle, style: .default, handler: completionHandler)
        
        if let cancelTitle = cancelTitle {
            let cancelButton = UIAlertAction(title: cancelTitle, style: .cancel)
            alertController.addAction(cancelButton)
        }
        
        alertController.addAction(okButton)
        
        present(alertController, animated: true)
    }
    
    
    
    
    // MARK: - Change Root ViewController
    func changeRootViewController(to rootVC: UIViewController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        sceneDelegate?.window?.rootViewController = rootVC
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    
    
    
    // MARK: - Transition VC
    enum TransitionStyle {
            case present
            case push
        }
        
        
        func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present) {
            
            switch transitionStyle {
            case .present:
                self.present(viewController, animated: true)
            case .push:
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            
        }
}
