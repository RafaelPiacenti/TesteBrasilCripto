class CryptoEntity {
  final String id;
  final String name;
  final String symbol;
  final double price;
  final double changePercent;
  final double marketCap;
  final List<double>? sparkline;
  final String? description;

  CryptoEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.price,
    required this.changePercent,
    required this.marketCap,
    this.sparkline,
    this.description,
  });
}
