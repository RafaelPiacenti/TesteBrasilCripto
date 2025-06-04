import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_crypto_details.dart';
import '../../../domain/entities/crypto_entity.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetCryptoDetails getCryptoDetails;

  DetailsBloc(this.getCryptoDetails) : super(DetailsInitial()) {
    on<LoadCryptoDetails>(_onLoad);
  }

  Future<void> _onLoad(
    LoadCryptoDetails event,
    Emitter<DetailsState> emit,
  ) async {
    emit(DetailsLoading());

    try {
      final crypto = await getCryptoDetails(event.id);
      emit(DetailsLoaded(crypto));
    } catch (_) {
      emit(DetailsError("Erro ao carregar detalhes da criptomoeda"));
    }
  }
}
