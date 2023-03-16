const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("PokemonFactory", () => {
  it("should be deployed", async () => {
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const contract = await PokemonFactory.deploy();
    expect(contract.address).to.not.equal(0);
  });

  it("call createPokemon and named pikachu", async () => {
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const contract = await PokemonFactory.deploy();

    await contract.createPokemon("pikachu", 1, [0, 1]);
    const pokemons = await contract.getAllPokemons();

    expect(pokemons[0].name).to.equal("pikachu");
  });
});
