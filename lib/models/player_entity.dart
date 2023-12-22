class Player {
  String name;
  int score;
  Player(this.name) : score = 0;

  void win() {
    score += 1;
  }
}
