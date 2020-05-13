import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'app.dart';
import 'bloc/simple_bloc_delegate.dart';
import 'repository/rates_api_client.dart';
import 'repository/rates_repository.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final repository = RatesRepository(
    apiClient: RatesApiClient(httpClient: http.Client()),
  );

  runApp(App(repository: repository));
}
