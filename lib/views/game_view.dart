import 'package:cclh/viewmodels/game_viewmodel.dart';
import 'package:cclh/views/select_view.dart';
import 'package:cclh/views/winner_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameView extends StatefulWidget {
const GameView({ super.key });

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context){
    final gameViewModel = Provider.of<GameViewModel>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for(var player in gameViewModel.players) 
              Column(
                children: [
                  CircleAvatar(child: Text(player.points.toString())),
                  Text(player.name)
              ],
            )
          ],
        ),
        const SizedBox(height: 20,),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 60),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Carta Negra",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  gameViewModel.currentBlackCard!, // Mostrar la carta negra actual
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30),
        if(gameViewModel.cardsPlayed.isEmpty) ...[
          !gameViewModel.amIJudge ? const SelectView() : const Center(child: Text('Espera que los jugadores elijan respuesta'))
        ] else ...[
          const WinnerView()
        ]
      ],
    );
  }
}