import 'package:core/presentation.dart';
import 'package:flutter/widgets.dart';

abstract class SearchPageDelegate {
  Future<void> onItemSearchSelected(
    BuildContext context, {
    required String movieId,
  });
  Future<void> onActionClick(BuildContext context);
}

class SearchPageFlow implements SearchPageDelegate {
  @override
  Future<void> onItemSearchSelected(
    BuildContext context, {
    required String movieId,
  }) async {
    await context.pushNamed<void>('/movie/', arguments: movieId);
  }

  @override
  Future<void> onActionClick(BuildContext context) async {
    await context.pushNamed<void>('/board/');
  }
}
