import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodels/details/details_bloc.dart';
import '../widgets/crypto_chart.dart';

class DetailsPage extends StatelessWidget {
  final String cryptoId;

  const DetailsPage(this.cryptoId, {super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DetailsBloc>().add(LoadCryptoDetails(cryptoId));

    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da Criptomoeda")),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailsLoaded) {
            final c = state.crypto;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      '${c.name} (${c.symbol.toUpperCase()})',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text('Preço atual: \$${c.price.toStringAsFixed(2)}'),
                    Text(
                      'Variação 24h: ${c.changePercent.toStringAsFixed(2)}%',
                    ),
                    Text('Market Cap: \$${c.marketCap.toStringAsFixed(0)}'),

                    if (c.sparkline != null && c.sparkline!.isNotEmpty) ...[
                      const Text("Variação nos últimos 7 dias:"),
                      CryptoChart(prices: c.sparkline!),
                    ],
                    if (c.description != null && c.description!.isNotEmpty)
                      ExpansionTile(
                        title: const Text(
                          "Sobre o projeto:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Text(
                              c.description!,
                              style: const TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          } else if (state is DetailsError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
