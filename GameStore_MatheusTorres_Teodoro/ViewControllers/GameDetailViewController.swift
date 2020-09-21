//
//  GameDetailViewController.swift
//  GameStore_MatheusTorres_Teodoro
//
//  Created by Matheus Torres on 20/09/20.
//

import UIKit

class GameDetailViewController: UIViewController {
    let game: Game
    
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var plotTextView: UITextView!
    
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
    
    init?(coder: NSCoder, game: Game) {
        self.game = game
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameInLayout()
    }
    
    func setupGameInLayout() {
        switch game.platform {
            case "N":
                platformLabel.text = "Nintendo Switch"
                platformLabel.textColor = .systemRed
            case "P":
                platformLabel.text = "Playstation 4"
                platformLabel.textColor = .systemBlue
            case "X":
                platformLabel.text = "XBOX One"
                platformLabel.textColor = .systemGreen
            default:
                platformLabel.text = "???"
                platformLabel.textColor = .systemOrange
        }
        titleLabel.text = game.name
        downloadImage(urlstr: game.image, imageView: coverImage)
        priceLabel.text = String(format: "%.2f", CGFloat(game.price))
        plotTextView.text = game.plot
    }
    
    func downloadImage(urlstr: String, imageView: UIImageView){
        let url = URL(string: urlstr)!
        let task = URLSession.shared.dataTask(with: url){
            data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
