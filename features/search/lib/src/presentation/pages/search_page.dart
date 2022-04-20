import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:search/src/presentation/bloc/search_bloc.dart';
import 'package:search/src/presentation/bloc/search_event.dart';
import 'package:search/src/presentation/bloc/search_state.dart';
import 'package:search/src/presentation/widgets/item_card_list.dart';
import 'package:search/src/presentation/widgets/search_text_field.dart';

class SearchPage extends StatefulWidget {
  final SearchBloc searchBloc;

  const SearchPage({
    Key? key,
    required this.searchBloc,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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
              onQueryChanged: (query) {
                widget.searchBloc.add(OnQueryChanged(query: query));
              },
            ),
            BlocBuilder<SearchBloc, SearchState>(
              bloc: widget.searchBloc,
              builder: (context, state) {
                if (state is SearchSuccessState) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Search result',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            BlocBuilder<SearchBloc, SearchState>(
              bloc: widget.searchBloc,
              builder: (context, state) {
                if (state is SearchLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                } else if (state is SearchErrorState) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (state is SearchEmptyState) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Nenhum resultado encontrado. Faça uma pesquisa.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (state is SearchSuccessState) {
                  final result = state.result.search;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return ItemCard(
                          movie: movie,
                          onPressed: (movie) {
                            Modular.to.pushNamed('/movie');
                          },
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
