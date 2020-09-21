//
//  InfoViewController.swift
//  GameStore_MatheusTorres_Teodoro
//
//  Created by Matheus Torres on 20/09/20.
//

import UIKit
import Lottie

class InfoViewController: UIViewController {
    
    @IBOutlet weak var gameboyPulanteAnimationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor(named: "lightColor")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimation()
    }
    
    func setupAnimation() {
        gameboyPulanteAnimationView.animationSpeed = 1
        gameboyPulanteAnimationView.loopMode = .loop
        gameboyPulanteAnimationView.play()
    }
}
