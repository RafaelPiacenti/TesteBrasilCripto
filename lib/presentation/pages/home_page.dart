import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodels/home/home_bloc.dart';
import '../viewmodels/favorites/favorites_bloc.dart';
import '../../data/models/crypto_model.dart';
import '../widgets/crypto_tile.dart';
import '../widgets/search_bar.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<HomeBloc>().add(SearchCryptos(query));
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BrasilCripto")),
      body: Column(
        children: [
          SearchBarWidget(controller: _searchController, onSearch: _onSearch),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return BlocBuilder<FavoritesBloc, FavoritesState>(
                    builder: (context, favState) {
                      final favorites = favState is FavoritesLoaded
                          ? favState.favorites
                          : [];

                      return ListView.builder(
                        itemCount: state.cryptos.length,
                        itemBuilder: (context, index) {
                          final crypto = state.cryptos[index];
                          final isFav = favorites.any((c) => c.id == crypto.id);

                          return CryptoTile(
                            crypto: crypto,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailsPage(crypto.id),
                              ),
                            ),
                            onFavoriteTap: () {
                              if (isFav) {
                                context.read<FavoritesBloc>().add(
                                  RemoveFavorite(crypto as CryptoModel),
                                );
                              } else {
                                context.read<FavoritesBloc>().add(
                                  AddFavorite(crypto as CryptoModel),
                                );
                              }
                            },
                            isFavorite: isFav,
                          );
                        },
                      );
                    },
                  );
                } else if (state is HomeEmpty) {
                  return const Center(
                    child: Text("Nenhuma criptomoeda encontrada"),
                  );
                } else if (state is HomeError) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text("Busque uma criptomoeda"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
