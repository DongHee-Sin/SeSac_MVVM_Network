//
//  LoginViewModel.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import Foundation

import RxSwift
import RxCocoa


final class LoginViewModel {
    
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
}




extension LoginViewModel: CommonViewModel {
    
    struct Input {}
    
    struct Output {}
    
    
    func transform(input: Input) -> Output {
        return Output()
    }
}
