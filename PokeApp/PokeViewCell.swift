//
//  PokeViewCell.swift
//  PokeApp
//
//  Created by Caroline Chan on 13/11/22.
//

import UIKit

class PokeViewCell: UICollectionViewCell {
    @IBOutlet weak var pokeContentView: UIView!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeLabelView: UILabel!
    
    override func awakeFromNib() {
        pokeContentView.layer.cornerRadius = 10
    }
}
