part of 'home_bloc.dart';

abstract class HomeEvent {}

class SearchCryptos extends HomeEvent {
  final String query;

  SearchCryptos(this.query);
}
