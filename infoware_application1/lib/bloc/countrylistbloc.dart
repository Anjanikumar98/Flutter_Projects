import 'package:flutter_bloc/flutter_bloc.dart';

import '../ViewModel/world_sates_view_model.dart';

abstract class CountriesListEvent {}

class FetchCountriesList extends CountriesListEvent {}

abstract class CountriesListState {}

class CountriesListInitial extends CountriesListState {}

class CountriesListLoading extends CountriesListState {}

class CountriesListLoaded extends CountriesListState {
  final List<dynamic> countries;
  CountriesListLoaded(this.countries);
}

class CountriesListError extends CountriesListState {
  final String message;
  CountriesListError(this.message);
}

class CountriesListBloc extends Bloc<CountriesListEvent, CountriesListState> {
  final WorldStatesViewModel worldStatesViewModel;

  CountriesListBloc(this.worldStatesViewModel) : super(CountriesListInitial());

  @override
  Stream<CountriesListState> mapEventToState(CountriesListEvent event) async* {
    if (event is FetchCountriesList) {
      yield CountriesListLoading();
      try {
        final countries = await worldStatesViewModel.countriesListApi();
        yield CountriesListLoaded(countries);
      } catch (e) {
        yield CountriesListError('Failed to load countries');
      }
    }
  }
}
