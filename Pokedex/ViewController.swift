//
//  ViewController.swift
//  Pokedex
//
//  Created by Sang Saephan on 1/27/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        parsePokemon()
        initMusic()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokeCell
        let pokemon = self.pokemon[indexPath.row]
        cell.configureCell(pokemon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // Parse each individual pokemon from csv file
    func parsePokemon() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            
            for row in rows {
                let name = row["identifier"]!
                let pokemonId = Int(row["id"]!)!
                
                let pokemon = Pokemon(name: name, pokedexId: pokemonId)
                self.pokemon.append(pokemon)
            }
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    // Initialize music player and play audio
    func initMusic() {
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do {
            
            try musicPlayer = AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.25
        } else {
            musicPlayer.play()
            sender.alpha = 1
        }
    }
    

}

