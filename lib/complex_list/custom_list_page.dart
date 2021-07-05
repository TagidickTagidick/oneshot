import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'custom_list.dart';
import '../repository.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListPage extends StatelessWidget {
  const CustomListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocProvider(
            create: (_) => ComplexListCubit(
              repository: context.read<Repository>(),
            )..fetchList(),
          child: Column(
              children: [
                CustomAppBar(),
                Expanded(
                    child: ComplexListView()
                )
              ]
          )
        )
      )
    );
  }
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          SizedBox(width: 5),
          Text(
              "Меню",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              )
          ),
          Spacer(),
          GestureDetector(
              onTap: () => context.read<ComplexListCubit>().addItem(),
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  color: Color(0xff2F54EB),
                  child: Icon(
                      Icons.add,
                      color: Colors.white
                  )
              )
          ),
          SizedBox(width: 5)
        ]
    );
  }
}

class ComplexListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<ComplexListCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text('Oops something went wrong!'));
      case ListStatus.success:
        return ItemView(items: state.items);
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}

class ItemView extends StatelessWidget {
  const ItemView({Key? key, required this.items}) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? const Center(child: Text('no content'))
        : GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20
      ),
      itemBuilder: (BuildContext context, int index) {
        return ItemTile(
          item: items[index],
          onDeletePressed: (id) {
            context.read<ComplexListCubit>().deleteItem(id);
          },
        );
      },
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.item,
    required this.onDeletePressed,
  }) : super(key: key);

  final Item item;
  final ValueSetter<String> onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Center(
            child: Column(
                children: [
                  Expanded(
                    child: Image.network(
                      item.image,
                    ),
                  ),
                  Text(
                      item.value,
                      style: TextStyle(
                          color: Colors.white
                      )
                  )
                ]
            )
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () => onDeletePressed(item.id),
              child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  color: Color(0xff2F54EB),
                  child: SvgPicture.asset(
                      "assets/trash.svg"
                  )
              ),
            ),
          )
        ]
    );
  }
}