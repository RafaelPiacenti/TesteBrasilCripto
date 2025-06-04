import '../entities/crypto_entity.dart';
import '../repositories/crypto_repository.dart';

class GetCryptoByQuery {
  final CryptoRepository repository;

  GetCryptoByQuery(this.repository);

  Future<List<CryptoEntity>> call(String query) {
    return repository.searchCryptos(query);
  }
}
