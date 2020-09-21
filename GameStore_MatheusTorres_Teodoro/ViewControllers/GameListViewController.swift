//
//  GameListViewController.swift
//  GameStore_MatheusTorres_Teodoro
//
//  Created by Matheus Torres on 19/09/20.
//

import UIKit
import Lottie

class GameListViewController: UIViewController {
    var window: UIWindow?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingAnimationView: AnimationView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Game>!
    
    var arrayOfGames: [Game] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "lightColor")
        guard let currentUser = UserDefaults.standard.value(forKey: "loggedUser") as? String else { return }
        self.title = "User: \(currentUser)"
        collectionView.isHidden = true
        loadingAnimationView.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = configureLayout()
        getGames()
        setupAnimation()
    }
    
    func setupAnimation() {
        loadingAnimationView.contentMode = .scaleAspectFit
        loadingAnimationView.animationSpeed = 1
        loadingAnimationView.loopMode = .loop
        loadingAnimationView.play()
    }
    
    func getGames () {
        let url = URL(string: "https://gameszada.herokuapp.com/")!
        let task = URLSession.shared.dataTask(with: url) {
            data, res, error in
            if let data = data {
                if let json = try? JSONDecoder().decode([Game].self, from: data) {
                    for newGame in json {
                        self.arrayOfGames.append(newGame)
                    }
                    DispatchQueue.main.async {
                        self.configureDataSource()
                        self.collectionView.isHidden = false
                        self.loadingAnimationView.isHidden = true
                    }
                }
            }
        }
        task.resume()
    }
    
    
    @IBAction func clickedOnProfile(_ sender: Any) {
        guard let currentUser = UserDefaults.standard.value(forKey: "loggedUser") as? String else { return }
        let alert = UIAlertController(title: "Good bye!", message: "Do you want to log out from \(currentUser)", preferredStyle: .alert)
        
        let actionLogout = UIAlertAction(title: "Yes", style: .destructive) {_ in
            UserDefaults.standard.set(false, forKey: "isLogged")
            UserDefaults.standard.set("", forKey: "loggedUser")
            let mainViewController =  self.storyboard!.instantiateViewController(identifier: "MainViewController")
            let mainVCNavigator = UINavigationController(rootViewController: mainViewController)
            mainVCNavigator.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "lightColor")!]
            UIApplication.shared.windows.first?.rootViewController = mainVCNavigator
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
        
        alert.addAction(actionLogout)
        alert.addAction(UIAlertAction(title: "No", style: .default))
        
        present(alert, animated: true)
    }
    
    func configureLayout() -> UICollectionViewCompositionalLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Game>(collectionView: self.collectionView) {
            collectionView, indexPath, game -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameCell.reuseIdentifier, for: indexPath) as? GameCell else { fatalError("Cell couldn't be created") }
            
            self.downloadImage(urlstr: self.arrayOfGames[indexPath.row].image, imageView: cell.coverImage)
            
            cell.coverImage.contentMode = .scaleAspectFill
            cell.layer.cornerRadius = 8
            
            return cell
        }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Game>()
        initialSnapshot.appendSections([.main])
        for game in arrayOfGames {
            initialSnapshot.appendItems([game])
        }
        
        dataSource.apply(initialSnapshot, animatingDifferences: false)
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
