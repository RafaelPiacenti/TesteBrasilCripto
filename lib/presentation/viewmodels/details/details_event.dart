part of 'details_bloc.dart';

abstract class DetailsEvent {}

class LoadCryptoDetails extends DetailsEvent {
  final String id;

  LoadCryptoDetails(this.id);
}
