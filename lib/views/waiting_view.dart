import 'package:cclh/viewmodels/game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WaitingView extends StatelessWidget {
  const WaitingView({super.key});

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Jugadores en la sala",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: gameViewModel.players.length,
            itemBuilder: (context, index) {
              final player = gameViewModel.players[index];
              return ListTile(
                tileColor: Theme.of(context).colorScheme.surface,
                leading: const Icon(Icons.arrow_forward),
                title: Text(player.name, textScaler: const TextScaler.linear(1.5),),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: FilledButton(
            onPressed: gameViewModel.players.length < 3 || !gameViewModel.amIHost ? null : () {
              gameViewModel.startGame();
            },
            child: const Text("Empezar Partida"),
          ),
        ),
      ],
    );
  }
}