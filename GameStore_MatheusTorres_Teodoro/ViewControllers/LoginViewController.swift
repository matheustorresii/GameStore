//
//  LoginViewController.swift
//  GameStore_MatheusTorres_Teodoro
//
//  Created by Matheus Torres on 19/09/20.
//

import UIKit

class LoginViewController: UIViewController {
    let login: Bool
    let defaultText: String
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    init?(coder: NSCoder, login: Bool) {
        self.login = login
        self.defaultText = login ? "Log In" : "Sign Up"
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    @IBAction func handleAction(_ sender: Any) {
        if loginTextField.text == "", passwordTextField.text == "" {
            alertUser(title: "Error! :(", message: "Complete all the fields", dismissController: false)
        }
        
        let urlString = "https://gameszada.herokuapp.com/\(login ? "login" : "register")"
        let url = URL(string: urlString)!
        guard let textLogin = loginTextField.text, let textPassword = passwordTextField.text else { return }
        let json = ["login": textLogin, "senha": textPassword]
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.uploadTask(with: request, from: jsonData) {
            data, response, error in
            if let data = data {
                if let user = try? JSONDecoder().decode(User.self, from: data) {
                    if self.login {
                        UserDefaults.standard.set(true, forKey: "isLogged")
                        UserDefaults.standard.set(user.login, forKey: "loggedUser")
                    }
                    DispatchQueue.main.async {
                        self.alertUser(title: "Nice! :D", message: "\(self.defaultText) successfully completed!", dismissController: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alertUser(title: "Error! :(", message: "\"\(textLogin)\" already exists", dismissController: false)
                    }
                }
            }
        }
        task.resume()
    }
    
    func alertUser(title: String, message: String, dismissController: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = UIColor(named: "lightColor")
        
        if dismissController {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {
                _ in
                self.dismiss(animated: true) {
                    let _ = self.navigationController?.popToRootViewController(animated: true)
                }
            }))
            if login {
                    let gameListViewController =  self.storyboard!.instantiateViewController(identifier: "GameListViewController")
                    let gameListVCNavigator = UINavigationController(rootViewController: gameListViewController)
                    gameListVCNavigator.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "neutralColor")!]
                    UIApplication.shared.windows.first?.rootViewController = gameListVCNavigator
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
            }
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        }
        
        present(alert, animated: true)
    }
    
    func setupLayout() {
        self.title = defaultText
        
        loginTextField.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        loginTextField.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        loginTextField.layer.shadowOpacity = 1.0
        
        passwordTextField.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        passwordTextField.layer.shadowOpacity = 1.0
        
        actionButton.layer.cornerRadius = 5
        actionButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        actionButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        actionButton.layer.shadowOpacity = 1.0
        actionButton.setTitle(defaultText, for: .normal)
    }
}
