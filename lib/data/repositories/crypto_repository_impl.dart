import '../../domain/entities/crypto_entity.dart';
import '../../domain/repositories/crypto_repository.dart';
import '../datasources/remote/coingecko_api.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final CoinGeckoApi api;

  CryptoRepositoryImpl(this.api);

  @override
  Future<List<CryptoEntity>> searchCryptos(String query) {
    return api.searchCryptos(query);
  }

  @override
  Future<CryptoEntity> getCryptoDetails(String id) {
    return api.getCryptoDetails(id);
  }
}
