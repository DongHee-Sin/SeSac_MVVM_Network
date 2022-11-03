//
//  BaseViewController.swift
//  SeSac_MVVM_Network
//
//  Created by 신동희 on 2022/11/03.
//

import UIKit
import RxSwift


class BaseViewController: UIViewController {

    var disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    
    func configure() {}
}
