//
//  LoginViewController.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import UIKit

import RxSwift
import RxCocoa


final class LoginViewController: BaseViewController {

    // MARK: - Propertys
    private let viewModel = LoginViewModel()
    
    
    
    
    // MARK: - Life Cycle
    let loginView = LoginView()
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    // MARK: - Methods
    override func configure() {        
        setNavigationBar()
        bind()
    }
    
    
    private func setNavigationBar() {
        navigationItem.title = PlaceHolder.login.rawValue
    }
    
    
    private func bind() {
        
        let input = LoginViewModel.Input(emailText: loginView.emailTextField.rx.text,
                                         passwordText: loginView.passwordTextField.rx.text,
                                         loginTap: loginView.loginButton.rx.tap,
                                         signUpTap: loginView.signUpButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.emailText
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.email.accept(value)
            }
            .disposed(by: disposeBag)
        
        
        output.passwordText
            .withUnretained(self)
            .bind { (vc, value) in
                vc.viewModel.password.accept(value)
            }
            .disposed(by: disposeBag)
        
        
        output.loginButtonValidation
            .bind(onNext: { value in
                self.loginView.loginButton.isEnabled = value
            })
            .disposed(by: disposeBag)
        
        
        output.loginTap
            .withUnretained(self)
            .bind { (vc, _) in
                let api = EndPoint.login(email: vc.viewModel.email.value, password: vc.viewModel.password.value)
                guard let url = api.url else { return }
                
                APIService.share.request(type: Login.self, url: url, method: .post, parameters: api.parameters, headers: api.header) { response in
                    
                    switch response {
                    case .success(let value):
                        UserDefaultsManager.shared.token = value.token
                        print(value.token)
                    case .failure(let error):
                        vc.showAlert(title: error.localizedDescription)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        output.signUpTap
            .withUnretained(self)
            .bind { (vc, _) in
                let signUpVC = SignUpViewController()
                vc.transition(signUpVC)
            }
            .disposed(by: disposeBag)
    }
}
