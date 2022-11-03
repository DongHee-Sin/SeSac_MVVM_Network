//
//  SignUpViewController.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/03.
//

import UIKit

import RxSwift
import RxCocoa


final class SignUpViewController: BaseViewController {

    // MARK: - Propertys
    private let viewModel = SignUpViewModel()
    
    
    
    
    // MARK: - Life Cycle
    let signupView = SignUpView()
    override func loadView() {
        view = signupView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    // MARK: - Methods
    override func configure() {
        view.backgroundColor = .white
        
        setNavigationBar()
        bind()
    }
    
    
    private func setNavigationBar() {
        navigationItem.title = "회원가입"
    }
    
    
    private func bind() {
        let input = SignUpViewModel.Input(userNameTextField: signupView.userNameTextField.rx.text,
                                          emailTextField: signupView.emailTextField.rx.text,
                                          passwordTextField: signupView.passwordTextField.rx.text,
                                          signUpTap: signupView.signupButton.rx.tap,
                                          userNameText: viewModel.userName,
                                          emailText: viewModel.email,
                                          passwordText: viewModel.password)
        let output = viewModel.transfrom(input: input)
        
        
        output.userNameTextField
            .bind(to: viewModel.userName)
            .disposed(by: disposeBag)
        
        output.emailTextField
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        output.passwordTextField
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        output.signUpTap
            .bind { _ in
                print("회원가입 버튼 Tap")
            }
            .disposed(by: disposeBag)
        
        
        output.userNameValidation
            .bind(to: signupView.emailTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.emailValidation
            .bind(to: signupView.passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.passwordValidation
            .withUnretained(self)
            .bind { (vc, value) in
                vc.signupView.signupButton.isEnabled = value
                vc.setButtonStyle(value)
            }
            .disposed(by: disposeBag)
    }
    
    
    private func setButtonStyle(_ value: Bool) {
        signupView.signupButton.backgroundColor = value ? .systemMint : .lightGray
        signupView.signupButton.setTitleColor(value ? .white : .black, for: .normal)
    }
}
