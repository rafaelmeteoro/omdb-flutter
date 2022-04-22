import 'package:movie/src/domain/entities/rating.dart';

class RatingAdapter {
  static Rating fromJson(Map<String, dynamic> json) => Rating(
        source: json['Source'],
        value: json['Value'],
      );
}
