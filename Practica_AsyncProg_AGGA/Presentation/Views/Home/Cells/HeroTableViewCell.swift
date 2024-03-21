//
//  HeroTableViewCell.swift
//  Practica_AsyncProg_AGGA
//
//  Created by Alejandro Alberto Gavira García on 20/3/24.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroLbl: UILabel!
    
    //MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .clear
        
        heroImage.layer.borderWidth = 1
        heroImage.layer.masksToBounds = false
        heroImage.layer.borderColor = UIColor.yellow.cgColor
        heroImage.layer.cornerRadius = heroImage.frame.height/2
        heroImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
