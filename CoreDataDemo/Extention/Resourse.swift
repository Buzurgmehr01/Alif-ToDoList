//
//  Resourse.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 30/08/23.
//

import UIKit


extension UITextField{
    func setUpTextField(placeholder: String, isSecure: Bool) -> UITextField{
        let textField = UITextField()
        textField.backgroundColor = UIColor(hex: 0xF3F4F8, alpha: 1)
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        return textField
    }
}


class MainButton: UIButton{
    
    func setUpMainButton(title: String, selector: Selector)-> UIButton{
        let button = UIButton()
        button.backgroundColor = .mainPrimary
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    func setUpLoginButton(title: String, selector: Selector)-> UIButton{
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle(title, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .Helvetica13
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
}

class CoreDataAlert{
    
    class func showAlert(navController: UINavigationController?, title: String, message: String, buttonText: String = "") {
        
//        guard let topViewController = UIApplication.shared.keyWindow?.rootViewController?.navigationController else {
//            return
//        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText.isEmpty ? "OK" : buttonText, style: .default))
        
        navController?.present(alert, animated: true)
    }
    
}

class InfoLabel: UILabel{
    func infoLabel(text: String) -> UILabel{
        let label = UILabel()
        label.text = text
        label.font = .Helvetica20
        return label
    }
}
