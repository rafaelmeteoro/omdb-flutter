import 'package:flutter/material.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  final HomeCubit homeCubit;

  const HomePage({
    Key? key,
    required this.homeCubit,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
