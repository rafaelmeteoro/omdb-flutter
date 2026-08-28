import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/board_type_entity.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  final GlobalKey<RouterOutletState> _outlet = GlobalKey<RouterOutletState>();

  static const List<String> _tabs = [
    '/board/favorites',
    '/board/words',
  ];

  final List<BoardTypeEntity> _menus = [
    BoardTypeEntity.favorites,
    BoardTypeEntity.words,
  ];

  void _onSelectedItem(int index) {
    _outlet.currentState?.navigate(_tabs[index]);
  }

  List<BottomNavigationBarItem> _itemsMenu() {
    return _menus.map((menu) {
      switch (menu) {
        case BoardTypeEntity.favorites:
          return const BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'List',
          );
        case BoardTypeEntity.words:
          return const BottomNavigationBarItem(
            icon: Icon(Icons.label),
            label: 'Words',
          );
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final path = context.routeState().uri.path;
    final selected = _tabs.lastIndexWhere(
      (tab) => path == tab || path.startsWith('$tab/'),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: RouterOutlet(key: _outlet),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onSelectedItem,
        currentIndex: selected < 0 ? 0 : selected,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        items: _itemsMenu(),
      ),
    );
  }
}
