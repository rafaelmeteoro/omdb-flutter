import 'package:flutter/material.dart';

class MovieDetailWishlistButton extends StatelessWidget {
  const MovieDetailWishlistButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('movieToWatchlist'),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: Size(
          MediaQuery.of(context).size.width,
          42.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.add, color: Colors.black),
          SizedBox(width: 16.0),
          Text(
            'Add to watchlist',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
