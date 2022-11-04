//
//  SignUpViewModel.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation

import RxSwift
import RxCocoa


final class SignUpViewModel {
    
    let userName = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let isButtonEnabled = PublishRelay<Bool>()
    
    
    
    
    private func isValidEmail(value: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: value)
    }
}




// MARK: - Input / Output
extension SignUpViewModel: CommonViewModel {
    
    struct Input {
        let userNameTextField: ControlProperty<String?>
        let emailTextField: ControlProperty<String?>
        let passwordTextField: ControlProperty<String?>
        let signUpTap: ControlEvent<Void>
        
        let userNameText: BehaviorRelay<String>
        let emailText: BehaviorRelay<String>
        let passwordText: BehaviorRelay<String>
    }
    
    
    struct Output {
        let userNameTextField: ControlProperty<String>
        let emailTextField: ControlProperty<String>
        let passwordTextField: ControlProperty<String>
        let signUpTap: ControlEvent<Void>
        
        let userNameValidation: Observable<Bool>
        let emailValidation: Observable<Bool>
        let passwordValidation: Observable<Bool>
    }
    
    
    func transform(input: Input) -> Output {
        let userNameValidation = input.userNameText.map { $0.count >= 2 }.distinctUntilChanged()
        let emailValidation = input.emailText.withUnretained(self)
            .map { (vc, value) in
                vc.isValidEmail(value: value)
            }.distinctUntilChanged()
        let passwordValidation = input.passwordText.map { $0.count >= 8 }.distinctUntilChanged()
        
        return Output(userNameTextField: input.userNameTextField.orEmpty,
                      emailTextField: input.emailTextField.orEmpty,
                      passwordTextField: input.passwordTextField.orEmpty,
                      signUpTap: input.signUpTap,
                      userNameValidation: userNameValidation,
                      emailValidation: emailValidation,
                      passwordValidation: passwordValidation)
    }
}
