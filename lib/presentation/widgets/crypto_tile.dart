import 'package:flutter/material.dart';
import '../../../domain/entities/crypto_entity.dart';

class CryptoTile extends StatelessWidget {
  final CryptoEntity crypto;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final bool isFavorite;

  const CryptoTile({
    super.key,
    required this.crypto,
    required this.onTap,
    required this.onFavoriteTap,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ListTile(
          onTap: onTap,
          title: Text('${crypto.name} (${crypto.symbol.toUpperCase()})'),
          subtitle: Text('Preço: \$${crypto.price.toStringAsFixed(2)}'),

          leading: IconButton(
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Colors.amber : null,
            ),
            onPressed: onFavoriteTap,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
