import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/get_crypto_by_query.dart';
import '../../../../domain/entities/crypto_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCryptoByQuery getCryptoByQuery;

  HomeBloc(this.getCryptoByQuery) : super(HomeInitial()) {
    on<SearchCryptos>(_onSearch);
  }

  Future<void> _onSearch(SearchCryptos event, Emitter<HomeState> emit) async {
    //Evita execuções sequenciais desnecessárias do evento de busca
    if (state is HomeLoading) return;

    emit(HomeLoading());

    try {
      final results = await getCryptoByQuery(event.query);
      if (results.isEmpty) {
        emit(HomeEmpty());
      } else {
        emit(HomeLoaded(results));
      }
    } catch (_) {
      emit(HomeError("Erro ao buscar criptomoedas"));
    }
  }
}
