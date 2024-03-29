import 'dart:async';

import 'package:flutter/material.dart';

import '../controller/search_page_controller.dart';
import '../controller/search_page_state.dart';
import '../widgets/item_card_list.dart';
import '../widgets/search_text_field.dart';
import 'search_page_delegate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.controller,
    required this.navigate,
  });

  final SearchPageController controller;
  final SearchPageDelegate navigate;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchPageController get _controller => widget.controller;
  SearchPageDelegate get _navigate => widget.navigate;

  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              key: const Key('favorite_icon'),
              onPressed: () {
                _navigate.onActionClick();
              },
              icon: const Icon(Icons.favorite),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextField(
              key: const Key('search_text_field'),
              onQueryChanged: (query) {
                if (_debounce?.isActive ?? false) {
                  _debounce?.cancel();
                }
                _debounce = Timer(const Duration(milliseconds: 700), () {
                  _controller.searchMovie(query: query);
                });
              },
            ),
            ValueListenableBuilder<SearchPageState>(
              valueListenable: _controller,
              builder: (context, state, _) {
                return switch (state) {
                  final SearchPageStateSuccess _ => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Search Result',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  SearchPageStateEmpty _ ||
                  SearchPageStateLoading _ ||
                  SearchPageStateError _ =>
                    const SizedBox(),
                };
              },
            ),
            ValueListenableBuilder<SearchPageState>(
              valueListenable: _controller,
              builder: (context, state, _) {
                return Expanded(
                  child: switch (state) {
                    SearchPageStateEmpty _ => const Center(
                        child: Text(
                          'Nenhum resultado encontrado. Faça uma pesquisa.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SearchPageStateLoading _ => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    final SearchPageStateError state => Center(
                        child: Text(state.message),
                      ),
                    final SearchPageStateSuccess state => ListView.builder(
                        itemCount: state.result.search.length,
                        itemBuilder: (context, index) {
                          final movie = state.result.search[index];
                          return ItemCard(
                            movie: movie,
                            onPressed: (movie) {
                              _navigate.onItemSearchSelected(
                                movieId: movie.imdbId,
                              );
                            },
                          );
                        },
                      ),
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
