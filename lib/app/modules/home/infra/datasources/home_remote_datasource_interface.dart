import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';

abstract class IHomeRemoteDatasource {
  Future<ResultSearch> getResult({
    required String title,
  });
}
