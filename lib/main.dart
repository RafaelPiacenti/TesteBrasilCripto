import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'data/datasources/remote/coingecko_api.dart';
import 'data/repositories/crypto_repository_impl.dart';
import 'domain/usecases/get_crypto_by_query.dart';
import 'domain/usecases/get_crypto_details.dart';
import 'presentation/viewmodels/home/home_bloc.dart';
import 'presentation/viewmodels/favorites/favorites_bloc.dart';
import 'presentation/viewmodels/details/details_bloc.dart';
import 'services/local_storage_service.dart';

void main() {
  final api = CoinGeckoApi();
  final repository = CryptoRepositoryImpl(api);
  final localStorage = LocalStorageService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(GetCryptoByQuery(repository)),
        ),
        BlocProvider<FavoritesBloc>(
          create: (_) => FavoritesBloc(localStorage)..add(LoadFavorites()),
        ),
        BlocProvider<DetailsBloc>(
          create: (_) => DetailsBloc(GetCryptoDetails(repository)),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
