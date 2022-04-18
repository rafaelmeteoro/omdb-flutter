import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final Function(String) _onQueryChanged;

  const SearchTextField({
    Key? key,
    required Function(String) onQueryChanged,
  })  : _onQueryChanged = onQueryChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (query) {
        _onQueryChanged(query);
      },
      decoration: InputDecoration(
        hintText: 'Search Movies',
        prefixIcon: const Icon(
          Icons.search,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      textInputAction: TextInputAction.search,
    );
  }
}
