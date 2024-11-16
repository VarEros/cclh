import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class SelectView extends StatefulWidget {
  const SelectView({super.key});

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  int selectedIndex = 0;
  String selectedCard = '';

  @override
  Widget build(BuildContext context) {
    final gameViewModel = Provider.of<GameViewModel>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecciona tu carta"),
      ),
      body: gameViewModel.roundStarted ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Carta Negra:",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              gameViewModel.currentBlackCard!,  // Mostrar la carta negra actual
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            !gameViewModel.amIJudge ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Tu mano:",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: gameViewModel.hand.length,
                    itemBuilder: (context, index) {
                      final card = gameViewModel.hand[index];
                      return ListTile(
                        title: Text(card),
                        onTap: () {
                          setState(() => selectedIndex = index);
                          selectedCard = card;
                        },
                        selected: index == selectedIndex,
                        selectedColor: Colors.cyan,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                FilledButton(
                  onPressed: selectedIndex == 0 ? null : () {
                    gameViewModel.playCard(selectedCard);  // Enviar la carta jugada
                  },
                  child: const Text('Elegir carta'),
                ),
              ],
            ) : const Text('Eres el juez'),
          ],
        ),
      ) : const CircularProgressIndicator(),
    );
  }
}