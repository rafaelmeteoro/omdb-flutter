import 'package:favorites/favorites.dart';
import 'package:flutter/material.dart';
import 'package:words/words.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<BoardPage> createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: _BoardBody(selectedBody: _selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onSelectedItem,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label),
            label: 'Words',
          ),
        ],
      ),
    );
  }

  void _onSelectedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class _BoardBody extends StatelessWidget {
  const _BoardBody({
    required this.selectedBody,
  });

  final int selectedBody;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: selectedBody,
      children: [
        FavoritesWidgetModule(),
        WordsWidgetModule(),
      ],
    );
  }
}
