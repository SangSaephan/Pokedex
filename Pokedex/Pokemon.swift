//
//  Pokemon.swift
//  Pokedex
//
//  Created by Sang Saephan on 1/27/17.
//  Copyright © 2017 Sang Saephan. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _type: String!
    private var _description: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _evolution: String!
    private var _pokemonUrl: String!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var type: String {
        if _type == nil {
            _type = "N/A"
        }
        
        return _type
    }
    
    var description: String {
        if _description == nil {
            _description = "N/A"
        }
        
        return _description
    }
    
    var defense: String {
        if _defense == nil {
            _defense = "N/A"
        }
        
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = "N/A"
        }
        
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = "N/A"
        }
        
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = "N/A"
        }
        
        return _attack
    }
    
    var evolution: String {
        if _evolution == nil {
            _evolution = "N/A"
        }
        
        return _evolution
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(_pokedexId!)/"
    }
    
    // Download Pokemon information
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonUrl).responseJSON { response in
            if let dictionary = response.result.value as? Dictionary<String, Any> {
                
                if let description = dictionary["descriptions"] as? [Dictionary<String, Any>] {
                    if let resourceUri = description[0]["resource_uri"] as? String {
                        let url = "\(BASE_URL)\(resourceUri)"
                        
                        Alamofire.request(url).responseJSON(completionHandler: { response in
                            if let descriptionDict = response.result.value as? Dictionary<String, Any> {
                                if let descriptionText = descriptionDict["description"] as? String {
                                    self._description = descriptionText.replacingOccurrences(of: "POKMON", with: "Pokemon").replacingOccurrences(of: "POK BALLS", with: "Pokeballs")
                                }
                            }
                            completed()
                        })
                    }
                }
                
                if let type = dictionary["types"] as? [Dictionary<String, Any>] {
                    if let typeName = type[0]["name"] as? String {
                        self._type = typeName.capitalized
                    }
                    
                    // Concatenate addition types, if any
                    if type.count > 1 {
                        for index in 1..<type.count {
                            if let name = type[index]["name"] as? String {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                
                if let defense = dictionary["defense"] as? Int {
                   self._defense = "\(defense)"
                }
                
                if let height = dictionary["height"] as? String {
                    self._height = height
                }
                
                if let weight = dictionary["weight"] as? String {
                    self._weight = weight
                }
                
                if let attack = dictionary["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let evolution = dictionary["evolutions"] as? [Dictionary<String, Any>] {
                    
                    // Check for empty array since some Pokemon from the API are returning empty arrays
                    if evolution.isEmpty {
                        self._evolution = "N/A"
                    } else {
                        let nextEvo = evolution[0]
                        // Some pokemon evolve by leveling up, others by stone. We make this check
                        if let level = nextEvo["level"] as? Int {
                            if let name = nextEvo["to"] as? String {
                                self._evolution = "\(name) at level \(level)"
                            }
                        } else if let method = nextEvo["method"] as? String {
                            // There are some unrealistic evolutions, so we dont set those
                            if method != "stone" {
                                self._evolution = "N/A"
                            } else {
                                if let name = nextEvo["to"] as? String {
                                    self._evolution = "\(name) by \(method)"
                                }
                            }
                        }
                    }
                }
            }
            completed()
        }
    }
}
