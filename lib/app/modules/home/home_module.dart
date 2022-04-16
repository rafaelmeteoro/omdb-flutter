import 'package:flutter_modular/flutter_modular.dart';
import 'package:omdb_flutter/app/modules/home/presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) => const HomePage())),
      ];
}
