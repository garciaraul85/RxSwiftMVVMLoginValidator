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
    var emailText = PublishSubject<String>()
    var passwordText = PublishSubject<String>()
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(
            emailText.asObservable().startWith(""),
            passwordText.asObservable().startWith("")) {
            email, password in
            email.count >= 3 && password.count >= 3
        }.startWith(false)
    }
    
}
