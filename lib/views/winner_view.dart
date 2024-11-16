import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class WinnerView extends StatefulWidget {
  const WinnerView({super.key});

  @override
  State<WinnerView> createState() => _WinnerViewState();
}

class _WinnerViewState extends State<WinnerView> {
  int selectedIndex = -1;
  String selectedPlayerId = '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gameViewModel = Provider.of<GameViewModel>(context);

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Selecciona la carta ganadora",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>  Divider(height: 10, color: colorScheme.surface),
              itemCount: gameViewModel.cardsPlayed.length,
              itemBuilder: (context, index) {
                final playedCard = gameViewModel.cardsPlayed[index];
                return ListTile(
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  tileColor: playedCard.isWinner ? colorScheme.surfaceContainerLow : colorScheme.surface,
                  title: Text(playedCard.card, textScaler: const TextScaler.linear(1.3)),
                  subtitle: Text(gameViewModel.winnerSelected ? gameViewModel.getPlayerName(playedCard.playerId) : 'Jugador Anonimo', textScaler: const TextScaler.linear(1.2)),
                  onTap: () {
                    if(!gameViewModel.amIJudge) return;
                      setState(() => selectedIndex = index);
                      selectedPlayerId = playedCard.playerId;
                    },
                    selected: index == selectedIndex,
                    selectedTileColor: colorScheme.surfaceContainerHigh,
                );
              },
            ),
          ),
          if(gameViewModel.amIJudge) ... [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: !gameViewModel.winnerSelected ? OutlinedButton(
                onPressed: selectedPlayerId.isEmpty ? null : () {
                  gameViewModel.selectWinner(selectedPlayerId);
                }, 
                child: const Text('Elegir carta')
              ) :
              OutlinedButton(
                onPressed: () {
                  gameViewModel.startRound();
                }, 
                child: const Text('Empezar siguiente ronda')
              ),
            )
          ]
        ],
      ),
    );
  }
}
