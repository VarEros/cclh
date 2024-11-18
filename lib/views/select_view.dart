import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/game_viewmodel.dart';

class SelectView extends StatefulWidget {
  const SelectView({super.key});

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  int selectedIndex = -1;
  String selectedCard = '';

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final gameViewModel = Provider.of<GameViewModel>(context);
    
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Tu mazo",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>  Divider(height: 10, color: colorScheme.surfaceContainerLow),
                  itemCount: gameViewModel.hand.length,
                  itemBuilder: (context, index) {
                    final card = gameViewModel.hand[index];
                    return ListTile(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      tileColor: gameViewModel.playedCard && selectedIndex == index ? colorScheme.surfaceContainerHigh : colorScheme.surfaceContainerLow,
                      title: Text(card, textScaler: const TextScaler.linear(1.3)),
                      onTap: gameViewModel.playedCard ? null : () {
                        setState(() => selectedIndex = index);
                        selectedCard = card;
                      },
                      selected: index == selectedIndex,
                      selectedColor: colorScheme.primary,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FilledButton(
            onPressed: selectedIndex == -1 || gameViewModel.playedCard ? null : () {
              gameViewModel.playCard(selectedCard);  // Enviar la carta jugada
            },
            child: const Text('Elegir carta'),
          ),
        ],
      ),
    );
  }
}