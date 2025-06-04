import '../entities/crypto_entity.dart';

abstract class CryptoRepository {
  Future<List<CryptoEntity>> searchCryptos(String query);
  Future<CryptoEntity> getCryptoDetails(String id);
}
