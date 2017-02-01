//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Sang Saephan on 2/1/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonLabel: UILabel!
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonLabel.text = pokemon.name
    }

}
