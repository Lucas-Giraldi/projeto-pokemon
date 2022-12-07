import 'package:flutter/material.dart';
import 'package:pokemon_flutter_app/pages/pokemon_info.dart';

import '../models/pokemon.dart';

class PokemonList extends StatefulWidget {
  List<Pokemon> list;

  PokemonList({Key? key, required this.list}) : super(key: key);

  @override
  State<PokemonList> createState() {
    return PokemonListState();
  }
}

/// Widget de estado - onde vai ser implementado o layout
class PokemonListState extends State<PokemonList> {
  late List<Pokemon> pokemonLista = widget.list;
  TextEditingController myController = TextEditingController();

  void searchPokemon(String query) {
    final pokemon = widget.list.where((element) {
      final nomePokeLower = element.name.toLowerCase();
      final input = query.toLowerCase();

      return nomePokeLower.contains(input);
    }).toList();

    setState(() => pokemonLista = pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextFormField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Pesquise o nome do Pokemon",
                icon: Icon(Icons.search)),
            controller: myController,
            onChanged: searchPokemon,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pokemonLista.length,
              itemBuilder: (context, index) {
                var pokemonsConsulta = pokemonLista[index];
                return ListTile(
                  leading: Image.network(pokemonsConsulta.image),
                  title: Text("${pokemonsConsulta.name} "),
                  subtitle: Text(pokemonsConsulta.getTypeString()),
                  textColor: pokemonsConsulta.baseColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PokemonInfo(pokemon: pokemonsConsulta),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
