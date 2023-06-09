import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/board_type_entity.dart';
import 'board_page_delegate.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({
    super.key,
    required this.delegate,
  });

  final BoardPageDelegate delegate;

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  int _selectedIndex = 0;
  final List<BoardTypeEntity> _menus = [
    BoardTypeEntity.favorites,
    BoardTypeEntity.words,
  ];
  BoardPageDelegate get _delegate => widget.delegate;

  @override
  void initState() {
    super.initState();
    _onSelectedItem(_selectedIndex);
  }

  void _onSelectedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _delegate.navigateToRoute(route: _menus[index].route);
  }

  List<BottomNavigationBarItem> _itemsMenu() {
    return _menus.map((menu) {
      switch (menu) {
        case BoardTypeEntity.favorites:
          return const BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'List');
        case BoardTypeEntity.words:
          return const BottomNavigationBarItem(icon: Icon(Icons.label), label: 'Words');
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const RouterOutlet(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onSelectedItem,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        items: _itemsMenu(),
      ),
    );
  }
}
