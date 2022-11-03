//
//  Profile.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/04.
//

import Foundation


struct Profile: Codable {
    let user: User
}


struct User: Codable {
    let photo: String
    let email: String
    let username: String
}
