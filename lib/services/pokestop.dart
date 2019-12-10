import 'package:poke_dex/models/pokemon.dart';

import 'network_helper.dart';

class PokemonService {
  NetworkHelper networkHelper = NetworkHelper();

  Future<List<Pokemon>> getRandomPokemon() async {

    try{
      var decodedData = await networkHelper.getData('random');
//      print(decodedData['data'].toString());
      List<Pokemon> pokeList = [];
      pokeList = Data.fromJson(decodedData['data']).pokemon;
      return pokeList;
    }catch(e){
      print(e);
    }
  }

  Future<List<Pokemon>> getSearchPokemon(String query) async {

    try{
      var decodedData = await networkHelper.getData(query.toLowerCase());
      List<Pokemon> pokemons = Data.fromJson(decodedData['data']).pokemon;
      return pokemons;
    }catch (e){
      print(e);
    }

  }
}
