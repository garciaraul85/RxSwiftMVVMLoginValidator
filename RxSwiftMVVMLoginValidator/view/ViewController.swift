//
//  ViewController.swift
//  RxSwiftMVVMLoginValidator
//
//  Created by Saulo Garcia on 9/21/20.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginEnabledLabel: UILabel!
    
    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUIToVM()
    }
    
    func bindUIToVM() {
        
        // _ means we wont use the result
        _ = emailTextField
            .rx
            .text
            .map { $0 ?? ""} // if nil return empty
            .bind(to: loginViewModel.emailText) // bind V with VM
        
        _ = passwordTextField
            .rx
            .text
            .map { $0 ?? ""}
            .bind(to: loginViewModel.passwordText)
        
        // if not valid disable login button
        _ = loginViewModel
            .isValid
            .bind(to: loginButton.rx.isEnabled)
        
        // update label without using binding
        
        loginViewModel.isValid.subscribe(onNext: { [unowned self] isValid in
            self.loginEnabledLabel.text = isValid ? "Enabled" : "Not Enabled"
            self.loginEnabledLabel.textColor = isValid ? .green : .red
        }).disposed(by: disposeBag)
        
    }

}

