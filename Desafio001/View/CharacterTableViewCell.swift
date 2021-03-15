//
//  CharacterTableViewCell.swift
//  Desafio001
//
//  Created by Elder Alcantara on 11/03/21.
//

import UIKit
import Kingfisher


class CharacterTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var charactersImageImageView: UIImageView!
    @IBOutlet weak var charactersNameLabel: UILabel!
    
    var viewModel: CharactersViewModel = CharactersViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    
    func setupCell(character:Character) {
        self.charactersNameLabel.text = character.name
        
        let imageURL: String = character.thumbnail.url
        let _imageURL = imageURL.replacingOccurrences(of: "http", with: "https")
        let url = URL(string: _imageURL)
        self.charactersImageImageView.kf.setImage(with: url)
        
        self.charactersImageImageView.layer.cornerRadius = 40.0
        //self.charactersImageImageView.layer.masksToBounds = true
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        
    }
    
    
    
}



