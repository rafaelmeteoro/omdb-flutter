import 'package:flutter/material.dart';

import '../../../list/presentation/pages/movie_list_page.dart';
import '../../../words/presentation/pages/words_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: _FavoritesBoardBody(selectedBody: _selectedIndex),
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

class _FavoritesBoardBody extends StatelessWidget {
  const _FavoritesBoardBody({
    required this.selectedBody,
  });

  final int selectedBody;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: selectedBody,
      children: const [
        MovieListPage(),
        WordsPage(),
      ],
    );
  }
}
