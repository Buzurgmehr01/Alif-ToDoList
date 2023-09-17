//
//  LoginView.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 31/08/23.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    let loginLabel = UILabel()
    let tfView = UIView()
    let loginTF: UITextField = {
        return UITextField().setUpTextField(placeholder: " login", isSecure: false)
    }()
    let passwordTF: UITextField = {
        return UITextField().setUpTextField(placeholder: " password", isSecure: true)
    }()
    
    let signUpButton: UIButton = {
        return MainButton().setUp(title: "Log In", selector: #selector(signUp))
    }()
    


    var loginButtonComplite: ()-> Void = {}
   

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        
        self.backgroundColor = .white
        self.addSubview(loginLabel)
        self.addSubview(tfView)
        tfView.addSubview(loginTF)
        tfView.addSubview(passwordTF)
        self.addSubview(signUpButton)

        loginLabel.text = "Authorization"
        loginLabel.font = .Helvetica30
        loginLabel.textAlignment = .center
        loginLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().inset(50)
        }
        
        tfView.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom).offset(70)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        loginTF.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.right.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        
        passwordTF.snp.makeConstraints {
            $0.top.equalTo(loginTF.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(50)
            $0.height.equalTo(30)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(tfView.snp.bottom).offset(30)
            $0.left.right.equalToSuperview().inset(50)
        }
        
    }
    
    @objc func signUp(sender: UIButton){
        self.loginButtonComplite()
    }
    
}
