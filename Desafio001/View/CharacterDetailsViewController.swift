//
//  CharacterDetailsViewController.swift
//  Desafio001
//
//  Created by Elder Alcantara on 11/03/21.
//

import UIKit
import Kingfisher
import SwiftHash
import Lottie



class CharacterDetailsViewController: UIViewController {
    
    private var animationView: AnimationView?
    
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var mostExpensiveComicButton: UIButton!
    @IBOutlet weak var closeCharacterButton: UIButton!
    
    var viewModel: CharactersViewModel = CharactersViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.showLoading(loading: true)
        self.characterImageView.isHidden = true
        self.characterNameLabel.isHidden = true
        self.characterDescriptionLabel.isHidden = true
        self.mostExpensiveComicButton.isHidden = true
        self.mostExpensiveComicButton.layer.cornerRadius = 10.0
        self.closeCharacterButton.isHidden = true
        self.closeCharacterButton.layer.cornerRadius = 30.0
        
        self.setupCharacter()
    }
    
    
    
    func setupCharacter(){
        
        if self.viewModel.currentCharacter != nil {
            
            self.characterNameLabel.text = self.viewModel.charactersName
            
            
            if self.viewModel.charactersDescription != "" {
                
                self.characterDescriptionLabel.text = self.viewModel.charactersDescription
                
                
            } else {
                
                self.characterDescriptionLabel.text = "Description not registered..."
            }
            
            
            let imageURL: String = self.viewModel.charactersImage
            let _imageURL = imageURL.replacingOccurrences(of: "http", with: "https")
            let url = URL(string: _imageURL)
            self.characterImageView.kf.setImage(with: url)
            
            self.showLoading(loading: false)
            self.characterImageView.isHidden = false
            self.characterNameLabel.isHidden = false
            self.characterDescriptionLabel.isHidden = false
            self.mostExpensiveComicButton.isHidden = false
            self.closeCharacterButton.isHidden = false
            
        }
        
        
        
    }
    
    @IBAction func closeCharacter(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    
    
    @IBAction func mostExpensiveComic(_  sender: Any) {
        
        print(">>> ID do Personagem: \(String(describing: self.viewModel.currentCharacter?.id))")
        
        
        //
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let expensiveComicViewController = storyBoard.instantiateViewController(withIdentifier: "ExpensiveComicViewController") as! ExpensiveComicViewController
        
        expensiveComicViewController.characterId = self.viewModel.currentCharacter?.id ?? 0
        
        //expensiveComicViewController.modalPresentationStyle = .fullScreen
        
        
        self.present(expensiveComicViewController, animated: true, completion: nil)
        
        
        
    }
    
    func showLoading(loading: Bool){
        
        if loading {
            animationView = .init(name: "loading")
            animationView!.frame = view.bounds
            animationView!.contentMode = .scaleAspectFit
            animationView!.loopMode = .loop
            animationView!.animationSpeed = 0.5
            view.addSubview(animationView!)
            animationView!.play()
        } else {
            animationView?.isHidden = true
        }
        
    }
    
    
    
}
