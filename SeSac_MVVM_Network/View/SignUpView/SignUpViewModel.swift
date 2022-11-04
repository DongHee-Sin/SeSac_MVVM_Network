//
//  SignUpViewModel.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation

import RxSwift
import RxCocoa


final class SignUpViewModel: CheckValidEmail {
    
    let userName = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let isButtonEnabled = PublishRelay<Bool>()

}




// MARK: - Input / Output
extension SignUpViewModel: CommonViewModel {
    
    struct Input {
        let userNameTextField: ControlProperty<String?>
        let emailTextField: ControlProperty<String?>
        let passwordTextField: ControlProperty<String?>
        let signUpTap: ControlEvent<Void>
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
        let userNameValidation = userName.map { $0.count >= 2 }.distinctUntilChanged()
        let emailValidation = email.withUnretained(self)
            .map { (vm, value) in
                vm.isValidEmail(value: value)
            }.distinctUntilChanged()
        let passwordValidation = password.map { $0.count >= 8 }.distinctUntilChanged()
        
        return Output(userNameTextField: input.userNameTextField.orEmpty,
                      emailTextField: input.emailTextField.orEmpty,
                      passwordTextField: input.passwordTextField.orEmpty,
                      signUpTap: input.signUpTap,
                      userNameValidation: userNameValidation,
                      emailValidation: emailValidation,
                      passwordValidation: passwordValidation)
    }
}
