enum BoardTypeEntity {
  favorites('/board/favorites/'),
  words('/board/words/');

  const BoardTypeEntity(this.route);

  final String route;
}
