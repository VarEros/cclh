import 'package:cclh/viewmodels/game_viewmodel.dart';
import 'package:cclh/views/select_view.dart';
import 'package:cclh/views/waiting_view.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cartas contra la Humanidad"),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
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
              const SelectView()
            ] else ...[
              const WinnerView()
            ]
          ],
        ),
      ),
    );
  }
}