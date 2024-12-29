import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../models/item_model.dart';
import '../repositories/item_repository.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc(this.itemRepository) : super(ItemInitial());

  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is FetchItems) {
      yield ItemLoading();
      try {
        final List<ItemModel> items = await itemRepository.fetchItems();
        yield ItemLoaded(items);
      } catch (e) {
        yield ItemError("Failed to fetch items");
      }
    }
  }
}
