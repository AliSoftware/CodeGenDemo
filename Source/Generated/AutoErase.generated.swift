// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


 - Pokemon / PokemonType

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