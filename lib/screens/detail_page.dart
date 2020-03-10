import 'package:flutter/material.dart';
import 'package:poke_dex/models/pokemon.dart';
import 'package:poke_dex/utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';

class DetailsPage extends StatelessWidget {
  static final id = 'details';
  final Pokemon pokemon;
  DetailsPage({this.pokemon});

  @override
  Widget build(BuildContext context) {
    final pokeColour = ColorUtil.getColor(pokemon.type[0]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pokeColour,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: pokeColour,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:  EdgeInsets.only(top: 40, left: 30),
                      child: Text(
                        pokemon.name.english,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: chipBuilder(pokemon),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 2,
                  padding: EdgeInsets.only(top: 90),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: double.infinity,
                          ),
                          BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceBetween,
                              maxY: 100,
                              borderData: FlBorderData(
                                show: false
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  margin: 20,
                                  getTitles: (double value){
                                    switch (value.toInt()) {
                                      case 0:
                                        return 'HP';
                                      case 1:
                                        return 'ATK';
                                      case 2:
                                        return 'DEF';
                                      case 3:
                                        return 'SP ATK';
                                      case 4:
                                        return 'SP DEF';
                                      case 5:
                                        return 'SPEED';
                                      default:
                                        return '';
                                    }
                                  }
                                ),
                                leftTitles: const SideTitles(showTitles: false),
                              ),
                              barGroups: [
                                BarChartGroupData(
                                x: 0,
                                barRods: [BarChartRodData(y: pokemon.base.hP.toDouble()/2 , color: pokeColour)],
                                ),
                                BarChartGroupData(
                                    x: 1,
                                    barRods: [BarChartRodData(y: pokemon.base.attack.toDouble()/2, color: pokeColour)],
                                ),
                                BarChartGroupData(
                                  x: 2,
                                  barRods: [BarChartRodData(y: pokemon.base.defense.toDouble()/2, color: pokeColour)],
                                ),
                                BarChartGroupData(
                                  x: 3,
                                  barRods: [BarChartRodData(y: pokemon.base.spAttack.toDouble()/2, color: pokeColour)],
                                ),
                                BarChartGroupData(
                                  x: 4,
                                  barRods: [BarChartRodData(y: pokemon.base.spDefense.toDouble()/2, color: pokeColour)],
                                ),
                                BarChartGroupData(
                                  x: 5,
                                  barRods: [BarChartRodData(y: pokemon.base.speed.toDouble()/2, color: pokeColour)],
                                ),
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0.0,-0.25),
                child: Hero(
                  tag: pokemon.id,
                  child: Image.network(pokemon.image,height: 150 ,width: 150,fit: BoxFit.fill),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

List<Widget> chipBuilder(Pokemon pokemon) {
  List<Widget> chiplist = [];
  var leftpad = SizedBox(
    width: 25,
  );
  chiplist.add(leftpad);
  for(var type in pokemon.type){
    var chip = Padding(
      padding: EdgeInsets.all(8.0),
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0)
        ),
        backgroundColor: Colors.white,
        label: Text(
            type
        ),
      ),
    );
    chiplist.add(chip);
  }
  return chiplist;
}