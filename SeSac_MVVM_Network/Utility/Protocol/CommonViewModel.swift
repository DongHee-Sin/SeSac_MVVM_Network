//
//  CommonViewModel.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/03.
//

import Foundation


protocol CommonViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
