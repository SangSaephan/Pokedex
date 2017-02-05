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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var previousEvoImageView: UIImageView!
    @IBOutlet weak var nextEvoImageView: UIImageView!
    @IBOutlet weak var movesView: UIView!
    @IBOutlet weak var move1Label: UILabel!
    @IBOutlet weak var move2Label: UILabel!
    @IBOutlet weak var move3Label: UILabel!
    @IBOutlet weak var move4Label: UILabel!
    @IBOutlet weak var move5Label: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonLabel.text = pokemon.name.capitalized
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        mainImageView.image = UIImage(named: "\(pokemon.pokedexId)")
        previousEvoImageView.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    func updateUI() {
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        evolutionLabel.text = "Next Evolution: \(pokemon.evolution)"
        descriptionLabel.text = pokemon.description
        
        // If a next evolution exists, set its image
        if pokemon.evolution != "N/A" {
            nextEvoImageView.image = UIImage(named: "\(pokemon.pokedexId + 1)")
        } else {
            nextEvoImageView.isHidden = true
        }
        
        move1Label.text = pokemon.moves[0]
        move2Label.text = pokemon.moves[1]
        move3Label.text = pokemon.moves[2]
        move4Label.text = pokemon.moves[3]
        move5Label.text = pokemon.moves[4]
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            movesView.isHidden = true
        case 1:
            movesView.isHidden = false
        default:
            break
        }
    }
}
