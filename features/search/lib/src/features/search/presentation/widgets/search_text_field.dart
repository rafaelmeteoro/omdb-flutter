import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required Function(String query) onQueryChanged,
  }) : _onQueryChanged = onQueryChanged;

  final Function(String query) _onQueryChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('enterMovieQuery'),
      onChanged: _onQueryChanged,
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
