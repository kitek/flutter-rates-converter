import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/rates_bloc.dart';
import 'bloc/rates_event.dart';
import 'page/rates_page.dart';
import 'repository/rates_repository.dart';

/// Top level widget.
class App extends StatelessWidget {
  final RatesRepository _repository;

  /// Creates component. Requires [repository].
  const App({Key key, @required RatesRepository repository})
      : assert(null != repository),
        _repository = repository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rates converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<RatesBloc>(
        create: (context) =>
            RatesBloc(repository: _repository)..add(RatesReload()),
        child: RatesPage(),
      ),
    );
  }
}
