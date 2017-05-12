//
//  Pokemon.swift
//  CodeGenDemo
//
//  Created by Olivier HALLIGON on 12/05/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

class Thunder { }
class Fire { }

// sourcery: typeerase = PokemonType
protocol Pokemon {
  associatedtype PokemonType
  func attack(move: PokemonType)
}

struct Pikachu: Pokemon {
  typealias PokemonType = Thunder
  func attack(move: Thunder) { /*⚡️*/ }
}

class Charmander: Pokemon {
  func attack(move: Fire) { /*🔥*/ }
}

class Raichu: Pokemon {
  typealias PokemonType = Thunder
  func attack(move: Thunder) { /*⚡️*/ }
}

/*
class AnyPokemon<Base>: Pokemon {
  typealias PokemonType = Base

  private let _attack: ((Base) -> Void)

  required init<U:Pokemon>(_ pokemon: U) where U.PokemonType == Base {
    _attack = pokemon.attack
  }

  func attack(move type: Base) {
    return _attack(type)
  }
}
*/

class AnyPokemon<Base>: Pokemon {
  typealias PokemonType = Base

  private let _attack: ((PokemonType) -> Void)

  required init<T: Pokemon>(_ base: T) where T.PokemonType == Base {
    _attack = base.attack
  }

  func attack(move: PokemonType) {
    return _attack(move)
  }
}

func test() {
  let list: [AnyPokemon<Thunder>] = [AnyPokemon(Pikachu()), AnyPokemon(Raichu())]
  list.forEach { (thunderPokemon: AnyPokemon<Thunder>) in
    thunderPokemon.attack(move: Thunder())
  }
}


