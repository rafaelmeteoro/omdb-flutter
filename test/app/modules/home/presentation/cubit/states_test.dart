import 'package:flutter_test/flutter_test.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/states.dart';

void main() {
  group('HomeState', () {
    test('should be HomeInitialState', () {
      // Arrange
      final HomeState state = HomeInitialState();

      // Act
      final result = state == HomeInitialState();

      // Assert
      expect(state, isA<HomeInitialState>());
      expect(result, false);
    });

    test('should be HomeLoadingState', () {
      // Arrange
      final HomeState state = HomeLoadingState();

      // Act
      final result = state == HomeLoadingState();

      // Assert
      expect(state, isA<HomeLoadingState>());
      expect(result, false);
    });

    test('should be HomeSuccessState', () {
      // Arrange
      final HomeState state = HomeSuccessState(
        result: ResultSearch(
          search: [],
          totalResults: '',
          response: '',
        ),
      );

      // Act
      final result = state ==
          HomeSuccessState(
            result: ResultSearch(
              search: [],
              totalResults: '',
              response: '',
            ),
          );

      // Assert
      expect(state, isA<HomeSuccessState>());
      expect(result, false);
    });

    test('should be HomeErrorState', () {
      // Arrange
      final HomeState state = HomeErrorState(errorMessage: 'test');

      // Act
      final result = state == HomeErrorState(errorMessage: 'test');

      // Assert
      expect(state, isA<HomeErrorState>());
      expect(result, false);
    });

    test('should be HomeEmptyState', () {
      // Arrange
      final HomeState state = HomeEmptyState();

      // Act
      final result = state == HomeEmptyState();

      // Assert
      expect(state, isA<HomeEmptyState>());
      expect(result, false);
    });
  });
}
