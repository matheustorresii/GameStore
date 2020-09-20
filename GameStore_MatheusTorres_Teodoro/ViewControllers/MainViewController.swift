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
    
    override func viewWillAppear(_ animated: Bool) {
        if let isLogged = UserDefaults.standard.value(forKey: "isLogged") as? Bool {
            if isLogged {
                loadBaseController()
            }
        }
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
    
    func loadBaseController() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let window = self.window else { return }
        window.makeKeyAndVisible()
        if UserDefaults.standard.bool(forKey: "isLogged") == false {
            let mainVC: MainViewController = storyboard.instantiateViewController(identifier: "MainViewController") as! MainViewController
            self.window?.rootViewController = mainVC
        } else {
            let gameListVC: GameListViewController = storyboard.instantiateViewController(identifier: "GameListViewController") as! GameListViewController
            self.window?.rootViewController = gameListVC
        }
        self.window?.makeKeyAndVisible()
    }
}

