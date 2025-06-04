part of 'favorites_bloc.dart';

abstract class FavoritesEvent {}

class LoadFavorites extends FavoritesEvent {}

class AddFavorite extends FavoritesEvent {
  final CryptoModel crypto;

  AddFavorite(this.crypto);
}

class RemoveFavorite extends FavoritesEvent {
  final CryptoModel crypto;

  RemoveFavorite(this.crypto);
}
