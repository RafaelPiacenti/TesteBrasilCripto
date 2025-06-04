import '../../domain/entities/crypto_entity.dart';

class CryptoModel extends CryptoEntity {
  CryptoModel({
    required super.id,
    required super.name,
    required super.symbol,
    required super.price,
    required super.changePercent,
    required super.marketCap,
    super.sparkline,
    super.description,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      price: (json['current_price'] as num).toDouble(),
      changePercent: (json['price_change_percentage_24h'] as num).toDouble(),
      marketCap: (json['market_cap'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'current_price': price,
      'price_change_percentage_24h': changePercent,
      'market_cap': marketCap,
    };
  }
}
