import 'package:app_core/app_core.dart';
import 'package:flutter/material.dart';

class MovieDetailWishlistButton extends StatelessWidget {
  const MovieDetailWishlistButton({
    super.key,
    required this.isFavorited,
    required this.action,
  });

  final bool isFavorited;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('movieToWatchlist'),
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(
          MediaQuery.of(context).size.width,
          42.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isFavorited ? Icons.check : Icons.add,
            color: Colors.black,
          ),
          const SizedBox(width: 16.0),
          Text(
            isFavorited ? 'Remove to watchlist' : 'Add to watchlist',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
