import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Omdb Flutter App',
      theme: ThemeData.dark().copyWith(
        primaryColor: kRichBlack,
        scaffoldBackgroundColor: kRichBlack,
        textTheme: kTextTheme,
        colorScheme: kColorScheme.copyWith(
          secondary: Colors.redAccent,
        ),
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
