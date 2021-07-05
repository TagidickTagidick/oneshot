import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../custom_list.dart';
import '../../repository.dart';
import 'dart:math';

part 'custom_list_state.dart';

class ComplexListCubit extends Cubit<CustomListState> {
  ComplexListCubit({required this.repository})
      : super(const CustomListState.loading());

  final _random = Random();

  int _randomRange(int min, int max) => min + _random.nextInt(max - min);

  final Repository repository;

  Future<void> fetchList() async {
    try {
      final items = await repository.fetchItems();
      emit(CustomListState.success(items));
    } on Exception {
      emit(const CustomListState.failure());
    }
  }

  Future<void> addItem() async {
    Item item = items[_randomRange(0, 4)];
    final addSuccess = List.of(state.items)
      ..add(Item(id: state.items.length.toString(), value: item.value, image: item.image));
    emit(CustomListState.success(addSuccess));
  }

  Future<void> deleteItem(String id) async {
    final deleteInProgress = state.items.map((item) {
      return item.id == id ? item.copyWith(isDeleting: true) : item;
    }).toList();
    emit(CustomListState.success(deleteInProgress));

    final deleteSuccess = List.of(state.items)
      ..removeWhere((element) => element.id == id);
    emit(CustomListState.success(deleteSuccess));
  }
}