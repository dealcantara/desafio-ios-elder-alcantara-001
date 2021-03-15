//
//  ExpensiveComicViewController.swift
//  Desafio001
//
//  Created by Elder Alcantara on 12/03/21.
//

import UIKit
import Lottie

class ExpensiveComicViewController: UIViewController {
    
    private var animationView: AnimationView?
    
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var comicPriceLabel: UILabel!
    @IBOutlet weak var comicNotFoundView: UIView!
    
    
    var viewModel: ComicViewModel = ComicViewModel()
    var characterId: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.showLoading(loading: true)
        self.comicImageView.isHidden = true
        self.comicTitleLabel.isHidden = true
        self.comicDescriptionLabel.isHidden = true
        self.comicPriceLabel.isHidden = true
        self.comicNotFoundView.isHidden = true
        
        self.viewModel = ComicViewModel()
        
        
        
        self.viewModel.getListComics(characterId: self.characterId) { (success) in
            
            DispatchQueue.main.async{
                
                self.showLoading(loading: false)
                
                if success == true {
                    
                    print(">>> COMIC is found!")
                    self.getDetailsComic()
                    
                    self.comicImageView.isHidden = false
                    self.comicTitleLabel.isHidden = false
                    self.comicDescriptionLabel.isHidden = false
                    self.comicPriceLabel.isHidden = false
                    
                    
                } else {
                    
                    print(">>> COMIC is not found!")
                    self.comicNotFoundView.isHidden = false
                }
            }
        }
        
        
    }
    
    @IBAction func backNavigation(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }
        
    }
    
    
    
    
    func getDetailsComic(){
        
        self.viewModel.getMostExpensiveComic{ (success) in
            
            if success == true {
                DispatchQueue.main.async{
                    print(">>> Most Expensive Comic is found!")
                    print(self.viewModel.arrayMostExpensiveComic)
                    
                    self.viewModel.getDetailsMostExpensiveComic()
                    self.setupComic()
                }
                
            } else {
                print(">>> Most Expensive Comic is not found!")
                
            }
        }
    }
    
    func setupComic(){
        
        let imageURL: String = self.viewModel.comicImage
        let _imageURL = imageURL.replacingOccurrences(of: "http", with: "https")
        let url = URL(string: _imageURL)
        self.comicImageView.kf.setImage(with: url)
        
        self.comicTitleLabel.text = self.viewModel.comicTitle
        self.comicDescriptionLabel.text = self.viewModel.comicDescription
        self.comicPriceLabel.text = self.viewModel.comicPrice
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
