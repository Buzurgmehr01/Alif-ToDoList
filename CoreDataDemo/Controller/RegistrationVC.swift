//
//  RegistrationVC.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 30/08/23.
//

import UIKit
import SnapKit

class RegistrationVC: UIViewController {
    
    let registrationView = RegistrationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        registrationView.signUpButtonComplite = signUpButtonTap
        registrationView.loginButtonComplite = loginButtonTap
    }

    func configuration(){
        view.addSubview(registrationView)
        
        registrationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func signUpButtonTap() {
        guard let login = registrationView.loginTF.text, !login.isEmpty,
              let password = registrationView.passwordTF.text, !password.isEmpty else {
            CoreDataAlert.showAlert(title: "Ошибка", message: "Заполните поля")
            return
        }
        
        let checkUser = Users.authUser(login: login, password: password)
        
        if checkUser {
            CoreDataAlert.showAlert(title: "Ошибка", message: "Такой пользователь уже существует!")
        }else{
            
            Users.createUser(login: login, password: password)
            
            let vc = TaskVC()
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            
            print("User registered successfully.")
        }
        
        
    }

    func loginButtonTap(){
        let vc = LoginVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
