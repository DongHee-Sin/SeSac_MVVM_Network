//
//  SignUpView.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/03.
//

import UIKit

import SnapKit
import Then


final class SignUpView: BaseView {
    
    // MARK: - Propertys
    let userNameTextField = UITextField().then {
        $0.placeholder = PlaceHolder.userName.rawValue
    }
    
    let emailTextField = UITextField().then {
        $0.placeholder = PlaceHolder.email.rawValue
        $0.keyboardType = .emailAddress
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = PlaceHolder.password.rawValue
    }
    
    let signupButton = UIButton().then {
        $0.setTitle(PlaceHolder.signUp.rawValue, for: .normal)
    }
    
    
    
    
    // MARK: - Methods
    override func configureUI() {
        [userNameTextField, emailTextField, passwordTextField, signupButton].forEach {
            self.addSubview($0)
        }
    }
    
    
    override func setConstraint() {
        userNameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(30)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(30)
            make.top.equalTo(userNameTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(30)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        signupButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self).inset(30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
    }
    
}
