//
//  CharactersViewController.swift
//  Desafio001
//
//  Created by Elder Alcantara on 10/03/21.
//

import UIKit
import Lottie


class CharactersViewController: UIViewController {
    
    var viewModel: CharactersViewModel = CharactersViewModel()
    
    private var animationView: AnimationView?
    
    
    @IBOutlet weak var listCharactersNotFoundView: UIView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var charactersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.title = "Detalhe Reserva"
        let image = UIImage(named: "logo-marvel")
        self.navigationBar.titleView = UIImageView(image: image)
        
        
        self.showLoading(loading: true)
        self.listCharactersNotFoundView.isHidden = true
        self.charactersTableView.isHidden = true
        
        self.viewModel = CharactersViewModel()
        
        
        self.charactersTableView.register(UINib(nibName: "CharacterTableViewCell", bundle: nil), forCellReuseIdentifier: "CharacterTableViewCell")
        
        
        self.viewModel.getListHeroes { (success) in
            
            DispatchQueue.main.async{
                
                self.showLoading(loading: false)
                
                if success == true {
                    
                    print(">>> List Characters is found!")
                    self.charactersTableView.isHidden = false
                    self.charactersTableView.delegate = self
                    self.charactersTableView.dataSource = self
                    self.charactersTableView.reloadData()
                    
                    
                } else {
                    
                    print(">>> List Characters not found!")
                    self.listCharactersNotFoundView.isHidden = false
                    
                }
            }
        }
        
        
        
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

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfCharacters
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CharacterTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "CharacterTableViewCell", for: indexPath) as? CharacterTableViewCell
        
        cell?.setupCell(character: self.viewModel.charactersList[indexPath.row])
        
        return cell ?? UITableViewCell()
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let characterDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        
        characterDetailsViewController.modalPresentationStyle = .popover
        let sender: Character = self.viewModel.charactersList[indexPath.row]
        characterDetailsViewController.viewModel.currentCharacter = sender
        
        self.present(characterDetailsViewController, animated: true, completion: nil)
        
    }
    
}

