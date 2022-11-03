//
//  LoginError.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import Foundation


enum LoginError: Int, Error {
    case invalidAuthorization = 401
    case invalidInput = 501
}




extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidAuthorization: return "토큰이 만료되었습니다."
        case .invalidInput: return "토큰이 만료되었습니다."
        }
    }
}
