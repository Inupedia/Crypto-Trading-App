//
//  LoginViewController.swift
//  Trading App
//
//  Created by Pengju Zhang on 3/12/22.
//

import UIKit
import FirebaseAuth
import Combine

class LoginViewController: UIViewController {
    
    enum LoginStatus {
        case signUp
        case signIn
    }

    @IBOutlet var loginCard: CustomView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var primaryBtn: UIButton!
    @IBOutlet var accessoryBtn: UIButton!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    var emailIsEmpty = true
    var passwordIsEmpty = true
    var loginStatus: LoginStatus = .signUp {
        didSet {
            if loginStatus == .signIn {
                self.titleLabel.text = "Sign in"
                self.primaryBtn.setTitle("Sign In", for: .normal)
                self.accessoryBtn.setTitle("Don't have an account?", for: .normal)
                self.passwordTextfield.textContentType = .password
            } else {
                self.titleLabel.text = "Sign up"
                self.primaryBtn.setTitle("Create Account", for: .normal)
                self.accessoryBtn.setTitle("Already have an account?", for: .normal)
                self.passwordTextfield.textContentType = .newPassword
            }
        }
    }
    private var tokens: Set<AnyCancellable> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut) {
            self.loginCard.alpha = 1
            self.loginCard.frame = self.loginCard.frame.offsetBy(dx: 0, dy: -400)
        }
        
        emailTextfield.publisher(for: \.text).sink { newValue in
            self.emailIsEmpty = (newValue == "" || newValue == nil)
        }
        .store(in: &tokens)
        
        passwordTextfield.publisher(for: \.text).sink { newValue in
            self.passwordIsEmpty = (newValue == "" || newValue == nil)
        }
        .store(in: &tokens)
    }
    
    @IBAction func primaryButtonAction(_ sender: UIButton) {
        if (emailIsEmpty || passwordIsEmpty) {
            let alert = UIAlertController(title: "Missing Information", message: "Please make sure to enter a valid email address and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present (alert, animated: true, completion: nil)
        } else {
            if loginStatus == .signUp {
                Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { authResult, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    // segue to the home screen
                    self.gotoHomeScreen()
                }
            } else {
                Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { authResult, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    self.gotoHomeScreen()
                }
            }
        }
    }
    @IBAction func accessoryButtonAction(_ sender: UIButton) {
        loginStatus = (loginStatus == .signIn) ? .signUp : .signIn
    }
    
    func gotoHomeScreen() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomTabBarViewController") as! CustomTabBarViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
