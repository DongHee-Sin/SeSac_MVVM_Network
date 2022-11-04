//
//  LoginView.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import UIKit

import SnapKit
import Then


final class LoginView: BaseView {
    
    // MARK: - Propertys
    let loginButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.title = PlaceHolder.login.rawValue
        config.baseForegroundColor = .white
        config.image = UIImage(systemName: "person.fill")
        config.imagePlacement = .top
        config.imagePadding = 8
        $0.configuration = config
    }
    
    private let loginStackView = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 8
        $0.axis = .vertical
    }
    
    let emailTextField = UITextField().then {
        $0.placeholder = PlaceHolder.email.rawValue
        $0.keyboardType = .emailAddress
    }
    
    let passwordTextField = UITextField().then {
        $0.placeholder = PlaceHolder.password.rawValue
    }
    
    let signUpButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle(PlaceHolder.signUp.rawValue, for: .normal)
    }
    
    
    
    
    // MARK: - Methods
    override func configureUI() {
        [emailTextField, passwordTextField].forEach {
            loginStackView.addArrangedSubview($0)
        }
        
        [loginStackView, loginButton, signUpButton].forEach {
            self.addSubview($0)
        }
    }
    
    
    override func setConstraint() {
        loginButton.snp.makeConstraints { make in
            make.width.height.equalTo(110)
            make.top.trailing.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(loginButton.snp.leading).offset(-20)
            make.height.equalTo(loginButton)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(loginStackView.snp.bottom).offset(12)
            make.leading.equalTo(loginStackView.snp.leading)
        }
    }
}
