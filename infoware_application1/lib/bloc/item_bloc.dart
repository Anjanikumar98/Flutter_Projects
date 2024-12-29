import 'package:flutter_bloc/flutter_bloc.dart';
import '../ViewModel/world_sates_view_model.dart';
import 'item_event.dart';
import 'item_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final WorldStatesViewModel worldStatesViewModel;

  DataBloc(this.worldStatesViewModel) : super(DataLoadingState());

  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is FetchDataEvent) {
      yield DataLoadingState();
      try {
        final data = await worldStatesViewModel.countriesListApi();
        yield DataLoadedState(data);
      } catch (e) {
        yield DataErrorState();
      }
    }
  }
}
