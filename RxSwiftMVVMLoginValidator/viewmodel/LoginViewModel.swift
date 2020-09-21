//
//  LoginViewModel.swift
//  RxSwiftMVVMLoginValidator
//
//  Created by Saulo Garcia on 9/21/20.
//

import Foundation
import RxSwift
import RxRelay

struct LoginViewModel {
    var emailText = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) {
            email, password in
            email.count >= 3 && password.count >= 3
        }
    }
    
}
