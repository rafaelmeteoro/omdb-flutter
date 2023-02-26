import 'dart:async';

import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../controller/search_page_controller.dart';
import '../controller/search_page_state.dart';
import '../widgets/item_card_list.dart';
import '../widgets/search_text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SearchPageController controller;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchPageController get _controller => widget.controller;

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchTextField(
              key: const Key('search_text_field'),
              onQueryChanged: (query) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 700), () {
                  _controller.searchMovie(query: query);
                });
              },
            ),
            ValueListenableBuilder<SearchPageState>(
              valueListenable: _controller,
              builder: (context, state, _) {
                return state.maybeWhen(
                  success: (result) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Search Result',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  orElse: () => const SizedBox(),
                );
              },
            ),
            ValueListenableBuilder<SearchPageState>(
              valueListenable: _controller,
              builder: (context, state, _) {
                return state.when(
                  empty: () => const Expanded(
                    child: Center(
                      child: Text(
                        'Nenhum resultado encontrado. Faça uma pesquisa.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  loading: () => const Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                  error: (message) => Expanded(
                    child: Center(
                      child: Text(message),
                    ),
                  ),
                  success: (result) => Expanded(
                    child: ListView.builder(
                      itemCount: result.search.length,
                      itemBuilder: (context, index) {
                        final movie = result.search[index];
                        return ItemCard(
                          movie: movie,
                          onPressed: (movie) {
                            Modular.to.pushNamed(
                              '/movie',
                              arguments: movie.imdbId,
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
