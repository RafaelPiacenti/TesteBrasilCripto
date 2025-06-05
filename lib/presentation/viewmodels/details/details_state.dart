part of 'details_bloc.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final CryptoEntity crypto;

  DetailsLoaded(this.crypto);
}

class DetailsError extends DetailsState {
  final String message;

  DetailsError(this.message);
}
