//
//  ViewController.swift
//  GameStore_MatheusTorres_Teodoro
//
//  Created by Matheus Torres on 19/09/20.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    var window: UIWindow?

    @IBOutlet weak var gameStoreView: AnimationView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        prepareForSegue()
    }
    
    @IBSegueAction func showLogInView(_ coder: NSCoder) -> LoginViewController? {
        LoginViewController(coder: coder, login: true)
    }
    
    @IBSegueAction func showSignUp(_ coder: NSCoder) -> LoginViewController? {
        LoginViewController(coder: coder, login: false)
    }
    
    func prepareForSegue() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    func setupAnimation() {
        gameStoreView.contentMode = .scaleAspectFill
        gameStoreView.animationSpeed = 0.6
        gameStoreView.play()
    }
    
    func setupLayout() {
        logInButton.layer.cornerRadius = 5
        logInButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        logInButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        logInButton.layer.shadowOpacity = 1.0
        
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        signUpButton.layer.shadowOpacity = 1.0
    }
}

