part of 'custom_list_cubit.dart';

enum ListStatus { loading, success, failure }

class CustomListState extends Equatable {
  const CustomListState._({
    this.status = ListStatus.loading,
    this.items = const <Item>[],
  });

  const CustomListState.loading() : this._();

  const CustomListState.success(List<Item> items)
      : this._(status: ListStatus.success, items: items);

  const CustomListState.failure() : this._(status: ListStatus.failure);

  final ListStatus status;
  final List<Item> items;

  @override
  List<Object> get props => [status, items];
}