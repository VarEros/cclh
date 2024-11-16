class SelectedCard {
  final String playerId;
  final String card;
  bool isWinner;

  SelectedCard({
    required this.playerId,
    required this.card,
    this.isWinner = false
  });
}