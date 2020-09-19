//
//  ViewController.swift
//  GameStore_MatheusTorres_Teodoro
//
//  Created by Matheus Torres on 19/09/20.
//

import UIKit
import Lottie

class MainViewController: UIViewController {

    @IBOutlet weak var gameStoreAnimatedView: AnimationView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        setupButtonLayer()
    }
    
    func setupAnimation() {
        gameStoreAnimatedView.contentMode = .scaleAspectFill
        gameStoreAnimatedView.play()
    }
    
    func setupButtonLayer() {
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

