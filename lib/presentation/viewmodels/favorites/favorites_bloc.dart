import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/crypto_model.dart';
import '../../../services/local_storage_service.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final LocalStorageService storage;

  FavoritesBloc(this.storage) : super(FavoritesInitial()) {
    on<LoadFavorites>(_onLoad);
    on<AddFavorite>(_onAdd);
    on<RemoveFavorite>(_onRemove);
  }

  List<CryptoModel> _favorites = [];

  Future<void> _onLoad(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(FavoritesLoading());
    try {
      _favorites = await storage.loadFavorites();
      emit(FavoritesLoaded(List.from(_favorites)));
    } catch (_) {
      emit(FavoritesError("Erro ao carregar favoritos"));
    }
  }

  Future<void> _onAdd(AddFavorite event, Emitter<FavoritesState> emit) async {
    if (!_favorites.any((c) => c.id == event.crypto.id)) {
      _favorites.add(event.crypto);
      await storage.saveFavorites(_favorites);
      emit(FavoritesLoaded(List.from(_favorites)));
    }
  }

  Future<void> _onRemove(
    RemoveFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    _favorites.removeWhere((c) => c.id == event.crypto.id);
    await storage.saveFavorites(_favorites);
    emit(FavoritesLoaded(List.from(_favorites)));
  }
}
