//
//  coreDataHelp.swift
//  pokemon
//
//  Created by Enrique Gachuz on 19/03/18.
//  Copyright © 2018 Enrique Gachuz. All rights reserved.
//

import UIKit
import CoreData

func addAllPokemon(){
    
    createPokemon(name: "pikachu", imageName: "004-pikachu.png")
    createPokemon(name: "draniti", imageName: "007-dratini.png")
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}


func createPokemon (name:String,imageName:String){
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageName = imageName
}

func getAllPokemon () -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    do {
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        if pokemons.count == 0 {
            addAllPokemon()
            return getAllPokemon()
        }
        return pokemons
    } catch {}
    return []
}

func getAllCaughtPokemon() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@",true as CVarArg)
    
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {}
    
    return []
}

func getAllUnCaughtPokemon() -> [Pokemon]{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@",false as CVarArg)
    
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {}
    
    return []
}
