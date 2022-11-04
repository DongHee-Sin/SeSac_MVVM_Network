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
        bind()
    }
    
    
    private func bind() {
        let input = SignUpViewModel.Input(userNameTextField: signupView.userNameTextField.rx.text,
                                          emailTextField: signupView.emailTextField.rx.text,
                                          passwordTextField: signupView.passwordTextField.rx.text,
                                          signUpTap: signupView.signupButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        
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
            .withUnretained(self)
            .bind { (vc, _) in
                let api = EndPoint.signUp(userName: vc.viewModel.userName.value, email: vc.viewModel.email.value, password: vc.viewModel.password.value)
                guard let url = api.url else { return }
                
                APIService.share.request(type: SignUp.self, url: url, method: .post, parameters: api.parameters, headers: api.header) { [weak self] response in
                    
                    switch response {
                    case .success(_):
                        self?.showAlert(title: "회원가입 성공", completionHandler: { _ in
                            self?.dismiss(animated: true)
                        })
                    case .failure(let error):
                        self?.showAlert(title: error.localizedDescription)
                    }
                }
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
