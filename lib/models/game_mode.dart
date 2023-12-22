enum GameMode {
  normal('Easy'),
  hard('Try win'),

  withOther('With Friend');

  const GameMode(this.title);

  final String title;
}
