import '../entities/crypto_entity.dart';
import '../repositories/crypto_repository.dart';

class GetCryptoDetails {
  final CryptoRepository repository;

  GetCryptoDetails(this.repository);

  Future<CryptoEntity> call(String id) {
    return repository.getCryptoDetails(id);
  }
}
