// State
abstract class DataState {}

class DataLoadingState extends DataState {}
class DataLoadedState extends DataState {
  final List<dynamic> data;
  DataLoadedState(this.data);
}
class DataErrorState extends DataState {}