//
//  EndPoint.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import Foundation
import Alamofire


enum EndPoint {
    
    case signUp(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
    
    private var rawValue: String {
        switch self {
        case .signUp: return "signup"
        case .login: return "login"
        case .profile: return "me"
        }
    }
    
}




extension EndPoint {
    
    private var baseURL: String { "http://api.memolease.com/api/v1/users/" }
    
    var url: URL? { URL(string: baseURL + self.rawValue) }
    
    
    var header: HTTPHeaders {
        switch self {
        case .signUp, .login:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        case .profile:
            return [
                "Authorization": "Bearer \(UserDefaultsManager.shared.token)",
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
    }
    
    
    var parameters: [String: String] {
        switch self {
        case .signUp(let userName, let email, let password):
            return [
                "userName": userName,
                "email": email,
                "password": password
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        default: return [:]
        }
    }
}
