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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Elige una carta ganadora"),
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
                    tileColor: playedCard.isWinner ? colorScheme.surfaceContainerLow : colorScheme.surface,
                    title: Text(playedCard.card, textScaler: const TextScaler.linear(1.3)),
                    subtitle: Text(gameViewModel.getPlayerName(playedCard.playerId), textScaler: const TextScaler.linear(1.2)),
                    onTap: () {
                      if(!gameViewModel.amIJudge) return;
                        setState(() => selectedIndex = index);
                        selectedPlayerId = playedCard.playerId;
                      },
                      selected: index == selectedIndex,
                      selectedColor: colorScheme.surfaceContainerHigh,
                  );
                },
              ),
            ),
            if(gameViewModel.amIJudge) ... [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: gameViewModel.roundStarted ? OutlinedButton(
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
      ),
    );
  }
}
