//
//  RegistrationView.swift
//  CoreDataDemo
//
//  Created by Majidov Buzurgmehr on 30/08/23.
//

import UIKit
import SnapKit

class RegistrationView: UIView {

    let registrationLabel = UILabel()
    let tfView = UIView()
    let loginTF: UITextField = {
        return UITextField().setUpTextField(placeholder: " login", isSecure: false)
    }()
    let passwordTF: UITextField = {
        return UITextField().setUpTextField(placeholder: " password", isSecure: true)
    }()
    
    let signUpButton: UIButton = {
        return MainButton().setUp(title: "Sign Up", selector: #selector(signUp))
    }()
    
    let nextSignInButton: UIButton = {
        return LoginButton().setUp(title: "Have already account?", selector: #selector(logIn))
    }()


    var signUpButtonComplite: ()-> Void = {}
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
        self.addSubview(registrationLabel)
        self.addSubview(tfView)
        tfView.addSubview(loginTF)
        tfView.addSubview(passwordTF)
        self.addSubview(signUpButton)
        self.addSubview(nextSignInButton)

        registrationLabel.text = "Registration"
        registrationLabel.font = .Helvetica30
        registrationLabel.textAlignment = .center
        registrationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.left.equalToSuperview().offset(50)
            $0.right.equalToSuperview().inset(50)
        }
        
        tfView.snp.makeConstraints {
            $0.top.equalTo(registrationLabel.snp.bottom).offset(70)
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
        
        nextSignInButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(30)
            $0.right.equalToSuperview().inset(50)
        }
        
    }
    
    @objc func signUp(sender: UIButton){
        self.signUpButtonComplite()
    }
    
    @objc func logIn(sender: UIButton){
        self.loginButtonComplite()
    }
}
