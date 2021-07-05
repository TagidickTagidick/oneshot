import 'package:equatable/equatable.dart';

class Item extends Equatable {
  const Item({
    required this.id,
    required this.value,
    required this.image,
    this.isDeleting = false,
  });

  final String id;
  final String value;
  final String image;
  final bool isDeleting;

  Item copyWith({String? id, String? value, String? image, bool? isDeleting}) {
    return Item(
      id: id ?? this.id,
      value: value ?? this.value,
      image: image ?? this.image,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object> get props => [id, value, isDeleting];
}