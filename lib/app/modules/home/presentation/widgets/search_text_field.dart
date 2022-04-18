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
      key: const Key("enterMovieQuery"),
      onChanged: (query) {
        _onQueryChanged(query);
      },
      decoration: InputDecoration(
        hintText: 'Search Movies',
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white70,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      textInputAction: TextInputAction.search,
      cursorColor: Colors.white,
    );
  }
}
