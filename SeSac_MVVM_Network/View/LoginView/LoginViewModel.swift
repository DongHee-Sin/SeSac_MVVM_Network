//
//  LoginViewModel.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import Foundation

import RxSwift
import RxCocoa


final class LoginViewModel: CheckValidEmail {
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    
    
    
    private func loginValidation() -> Bool {
        let valid = isValidEmail(value: email.value) && password.value.count >= 8
        
        return valid
    }
}




extension LoginViewModel: CommonViewModel {
    
    struct Input {
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        
        let loginTap: ControlEvent<Void>
        let signUpTap: ControlEvent<Void>
    }
    
    struct Output {
        let emailText: ControlProperty<String>
        let passwordText: ControlProperty<String>
        
        let loginButtonValidation: Observable<Bool>
        
        let loginTap: ControlEvent<Void>
        let signUpTap: ControlEvent<Void>
    }
    
    
    func transform(input: Input) -> Output {
        let emailText = input.emailText.orEmpty
        let passwordText = input.passwordText.orEmpty
        
        let validation = Observable.combineLatest(email, password)
            .withUnretained(self)
            .map({ (vc, value) in
                return vc.isValidEmail(value: value.0) && value.1.count >= 8
            })
        
        return Output(emailText: emailText, passwordText: passwordText, loginButtonValidation: validation, loginTap: input.loginTap, signUpTap: input.signUpTap)
    }
}
