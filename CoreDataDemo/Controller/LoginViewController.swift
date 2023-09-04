//
//  LoginVC.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 30/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginview = LoginView()
    let coreDataManager = CoreDataManager()


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        loginview.loginButtonComplite = loginTap
    }
    
    func configure(){
        view.addSubview(loginview)
        
        loginview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func loginTap(){
       
        guard let login = loginview.loginTF.text, !login.isEmpty,
              let password = loginview.passwordTF.text, !password.isEmpty
        else {
            CoreDataAlert.showAlert(title: "Ошибка", message: "Заполните все поля!")
            return }
        
        let authUser = coreDataManager.authUser(login: login, password: password)
        
        if authUser{
            let vc = TaskViewController()
            let navController = UINavigationController(rootViewController: vc)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            
            print("User login successfully.")
        }else{
            CoreDataAlert.showAlert(title: "Ошибка", message: "Неправельны логин или пароль!")
        }
    }

}
