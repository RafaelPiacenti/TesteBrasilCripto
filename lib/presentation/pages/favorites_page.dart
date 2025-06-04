import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/crypto_model.dart';
import '../viewmodels/favorites/favorites_bloc.dart';
import 'details_page.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  void _confirmRemoval(BuildContext context, CryptoModel crypto) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Remover Favorito"),
        content: Text("Deseja remover ${crypto.name} dos favoritos?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              context.read<FavoritesBloc>().add(RemoveFavorite(crypto));
              Navigator.pop(context);
            },
            child: const Text("Remover"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favoritos")),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return const Center(child: Text("Nenhuma criptomoeda favorita"));
            }

            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final crypto = state.favorites[index];
                return ListTile(
                  title: Text(
                    '${crypto.name} (${crypto.symbol.toUpperCase()})',
                  ),
                  subtitle: Text('Preço: \$${crypto.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _confirmRemoval(context, crypto),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailsPage(crypto.id)),
                    );
                  },
                );
              },
            );
          } else if (state is FavoritesError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
