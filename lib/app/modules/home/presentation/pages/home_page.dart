import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/events.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/states.dart';
import 'package:omdb_flutter/app/modules/home/presentation/widgets/item_card_list.dart';
import 'package:omdb_flutter/app/modules/home/presentation/widgets/search_text_field.dart';

class HomePage extends StatefulWidget {
  final HomeCubit homeCubit;

  const HomePage({
    Key? key,
    required this.homeCubit,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                widget.homeCubit.add(SearchMoviesEvent(searchText: query));
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: widget.homeCubit,
              builder: (context, state) {
                if (state is HomeSuccessState) {
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
            BlocBuilder<HomeCubit, HomeState>(
              bloc: widget.homeCubit,
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                } else if (state is HomeErrorState) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (state is HomeEmptyState) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Nenhum resultado econtrado. Faça outra pesquisa.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (state is HomeSuccessState) {
                  final result = state.result.search;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return ItemCard(movie: movie);
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
