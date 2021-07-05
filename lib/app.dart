import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'complex_list/custom_list.dart';
import 'repository.dart';

class App extends MaterialApp {
  App({required Repository repository})
      : super(
    home: RepositoryProvider.value(
      value: repository,
      child: const CustomListPage(),
    ),
  );
}