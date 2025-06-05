import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/crypto_model.dart';

class CoinGeckoApi {
  static const _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<CryptoModel>> searchCryptos(String query) async {
    final uri = Uri.parse(
      '$_baseUrl/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false',
    );

    final response = await http.get(
      uri,
      headers: {'User-Agent': 'BrasilCripto/1.0'},
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);

      final results = data.where((item) {
        final name = (item['name'] as String).toLowerCase();
        final symbol = (item['symbol'] as String).toLowerCase();
        return name.contains(query.toLowerCase()) ||
            symbol.contains(query.toLowerCase());
      }).toList();

      return results.map((e) => CryptoModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar criptomoedas');
    }
  }

  Future<CryptoModel> getCryptoDetails(String id) async {
    final uri = Uri.parse(
      '$_baseUrl/coins/$id?localization=true&sparkline=true',
    );

    final response = await http.get(
      uri,
      headers: {'User-Agent': 'BrasilCriptoApp/1.0'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return CryptoModel(
        id: data['id'],
        name: data['name'],
        symbol: data['symbol'],
        price: (data['market_data']['current_price']['usd'] as num).toDouble(),
        changePercent:
            (data['market_data']['price_change_percentage_24h'] as num)
                .toDouble(),
        marketCap: (data['market_data']['market_cap']['usd'] as num).toDouble(),
        sparkline: (data['market_data']['sparkline_7d']['price'] as List)
            .map((e) => (e as num).toDouble())
            .toList(),
        description: (data['description']['pt']?.trim().isNotEmpty ?? false)
            ? data['description']['pt']
            : data['description']['en'],
      );
    } else {
      throw Exception('Erro ao buscar detalhes da criptomoeda');
    }
  }
}
