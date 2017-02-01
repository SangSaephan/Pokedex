//
//  PokeCell.swift
//  Pokedex
//
//  Created by Sang Saephan on 1/31/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        pokemonNameLabel.text = pokemon.name.capitalized
        pokemonImageView.image = UIImage(named: "\(pokemon.pokedexId)")
    }
    
}
