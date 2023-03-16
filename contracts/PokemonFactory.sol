// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint id;
        string name;
        uint[] abilityIds;
    }

    struct Ability {
        string name;
        string description;
    }

    Ability[] private abilities;
    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    event eventNewPokemon(string _name);

    function createPokemon(
        string memory _name,
        uint _id,
        uint[] memory _abilityIds
    ) public {
        bytes memory _nameBytes = bytes(_name);
        require(_id > 0, "id must be greater than 0");
        require(
            _nameBytes.length >= 2,
            "name must be equal or greater than 2 characters"
        );
        Pokemon memory newPoke = Pokemon({
            name: _name,
            id: _id,
            abilityIds: _abilityIds
        });
        pokemons.push(newPoke);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_name);
    }

    function createAbility(
        string memory _name,
        string memory _description
    ) public {
        abilities.push(Ability({name: _name, description: _description}));
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }
}
