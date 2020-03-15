import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/screens/detail_page.dart';
import 'package:poke_dex/services/pokestop.dart';
import 'package:poke_dex/utilities/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pokemon> pokeList;
  PokemonService pokemonService;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void getPokemons() async {
    pokemonService = PokemonService();
    pokeList = await pokemonService.getRandomPokemon();
    setState(() {});
  }

  _launchURL() async {
    const url = 'https://github.com/kriticalflare';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Null> refreshList() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    getPokemons();
    await Future.delayed(Duration(seconds: 2)); // coz users
    setState(() {});

    return null;
  }

  List<Widget> pokemonCards() {
    List<Widget> pokeCardList = [];
    for (Pokemon pokemon in pokeList){
      var pokeCard =  GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return DetailsPage(
                  pokemon: pokemon,
                );
              }));
        },
        child: Container(
          margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: ColorUtil.getColor(
                    pokemon.type[0]),
                borderRadius:
                BorderRadius.circular(30.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: pokemon.id,
                  child: Image.network(
                    pokemon.image,
                    height: 110.0,
                    width: 110.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(pokemon.name.english),
              ],
            )),
      );
      pokeCardList.add(pokeCard);
    }
    return pokeCardList;
  }

  @override
  void initState() {
    super.initState();
    getPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            showAboutDialog(
                context: context,
                applicationName: 'Pokedex',
                applicationVersion: '1.0.0',
                applicationIcon: Image.asset('assets/pokedex.png'),
                applicationLegalese:
                    'App by @kriticalflare  \n\nUses icons from icons8.com',
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            _launchURL();
                          },
                          child: Image.asset(
                            'assets/github.png',
                            height: 70,
                            width: 70,
                          )),
                    ),
                  )
                ]);
          },
          child: Text(
            'Pokedex',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearch(context: context, delegate: PokemonSearch());
            },
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: pokeList == null
              ? Center(
                  child: Image.asset(
                    'assets/loading.gif',
                    height: 200,
                    width: 200,
                  ),
                )
              : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Center(
                        child: Text(
                          'Pokemon of the day',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                    RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: refreshList,
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: pokemonCards(),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

class PokemonSearch extends SearchDelegate {
  Future<List<Pokemon>> getSearchPokemon(
      String query, BuildContext context) async {
    PokemonService pokemonService = PokemonService();
    List<Pokemon> pokemon = await pokemonService.getSearchPokemon(query);
    return pokemon;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        color: Colors.black,
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.black,
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: getSearchPokemon(query, context),
      builder: (context, pokemonsnapshot) {
        if (!pokemonsnapshot.hasData &&
            pokemonsnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Image.asset(
              'assets/loading.gif',
              height: 200,
              width: 200,
            ),
          );
        } else if (!pokemonsnapshot.hasData &&
            pokemonsnapshot.connectionState == ConnectionState.done) {
          return Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/pokedex.png'),
                Text(
                  'Oops!',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Pokedex couldn't find what you were looking for.",
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            )),
          );
        } else {
          List<Pokemon> pokemons = pokemonsnapshot.data;
          return ListView.builder(
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset('assets/pokeball.png'),
                title: Text(pokemons[index].name.english),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return DetailsPage(
                      pokemon: pokemons[index],
                    );
                  }));
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions with updated api
    return Container();
  }
}
