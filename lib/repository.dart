import 'dart:async';
import 'dart:math';
import 'complex_list/custom_list.dart';

List<Item> items = [
  Item(
    id: "",
    image: "https://www.pngpix.com/wp-content/uploads/2016/10/PNGPIX-COM-Pepsi-PNG-Image.png",
    value: "Pepsi"
  ),
  Item(
      id: "",
      image: "https://freepngimg.com/download/sprite/3-sprite-png-bottle-image.png",
      value: "Sprite"
  ),
  Item(
      id: "",
      image: "https://pluspng.com/img-png/fanta-png-fanta-orange-24x33cl-936.png",
      value: "Fanta"
  ),
  Item(
      id: "",
      image: "https://emporter.pizzapai.fr/media/catalog/product/cache/1/image/1000x/9df78eab33525d08d6e5fb8d27136e95/l/i/lipton.png",
      value: "Lipton"
  )
];

class Repository {
  final _random = Random();

  int _randomRange(int min, int max) => min + _random.nextInt(max - min);

  Future<List<Item>> fetchItems() async {
    await Future<void>.delayed(Duration(seconds: 1));
    return List.of(_generateItemsList(10));
  }

  List<Item> _generateItemsList(int length) {
    return List.generate(
      length,
          (index) {
        Item item = items[_randomRange(0, 4)];
        return Item(id: '$index', value: item.value, image: item.image);
          },
    );
  }

  Future<void> addItem() async {
    await Future<void>.delayed(Duration(seconds: 1));
  }

  Future<void> deleteItem(String id) async {
    await Future<void>.delayed(Duration(seconds: 1));
  }
}