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
    
    @IBAction func onClick(_ sender: UIButton!) {
        print("email: \(String(describing: emailTextField.text)), password: \(String(describing: passwordTextField.text))")
    }
    
    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUIToVM()
    }
    
    func bindUIToVM() {
        emailTextField.becomeFirstResponder()
        
        // _ means we wont use the result
        _ = emailTextField
            .rx
            .text
            .map { $0 ?? ""} // if nil return empty
            .bind(to: loginViewModel.emailText) // bind V with VM
            .disposed(by: disposeBag)
        
        _ = passwordTextField
            .rx
            .text
            .map { $0 ?? ""}
            .bind(to: loginViewModel.passwordText)
            .disposed(by: disposeBag)
        
        // if not valid disable login button
        _ = loginViewModel
            .isValid
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid
            .map { $0 ? 1 : 0.1}
            .bind(to: loginButton.rx.alpha)
            .disposed(by: disposeBag)
        
    }

}

