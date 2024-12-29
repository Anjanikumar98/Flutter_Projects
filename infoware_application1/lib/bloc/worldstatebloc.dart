import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_application1/Model/world_states.dart';
import 'package:infoware_application1/ViewModel/world_sates_view_model.dart';

abstract class WorldStatesEvent {}

class FetchWorldStates extends WorldStatesEvent {}

abstract class WorldStatesState {}

class WorldStatesInitial extends WorldStatesState {}

class WorldStatesLoading extends WorldStatesState {}

class WorldStatesLoaded extends WorldStatesState {
  final WorldStatesModel worldStates;
  WorldStatesLoaded(this.worldStates);
}

class WorldStatesError extends WorldStatesState {
  final String message;
  WorldStatesError(this.message);
}

class WorldStatesBloc extends Bloc<WorldStatesEvent, WorldStatesState> {
  final WorldStatesViewModel worldStatesViewModel;

  WorldStatesBloc(this.worldStatesViewModel) : super(WorldStatesInitial());

  @override
  Stream<WorldStatesState> mapEventToState(WorldStatesEvent event) async* {
    if (event is FetchWorldStates) {
      yield WorldStatesLoading();
      try {
        final worldStates = await worldStatesViewModel.fetchWorldRecords();
        yield WorldStatesLoaded(worldStates);
      } catch (e) {
        yield WorldStatesError('Failed to load world states');
      }
    }
  }
}
