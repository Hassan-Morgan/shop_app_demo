import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopAppCubit.get(context);
          return Scaffold(
            body: ShopAppCubit.get(context).favoritesModel == null?
                const Center(child: CircularProgressIndicator(),)
            :ListView.separated(
              itemBuilder: (context, index) => buildItem(
                  model: cubit.favoritesModel!.data.data[index],
                  context: context),
              separatorBuilder: (context, index) => Container(
                height: 1.5,
                margin: const EdgeInsets.all(20),
                color: Colors.black,
              ),
              itemCount: cubit.favoritesModel!.data.data.length,
            ),
          );
        });
  }

  Widget buildItem({required DataModel model, required context}) {
    return Row(
      children: [
        Image(
          image: NetworkImage(model.product.image),
          width: 100,
          height: 100,
        ),
        Container(
          width: 1.5,
          height: 80,
          margin: const EdgeInsets.all(10),
          color: Colors.black,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.product.name),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: Colors.red,
                child: model.product.discount == 0
                    ? const SizedBox()
                    : Text(
                        '${model.product.discount} %',
                        style: const TextStyle(color: Colors.white),
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context)
                          .changeFavorites(id: model.product.id);
                    },
                    icon:
                        ShopAppCubit.get(context).favorites[model.product.id] ==
                                true
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.blue,
                              )
                            : const Icon(Icons.favorite_border),
                  ),
                  Text('\$${model.product.price}'),
                  Text(
                    '\$${model.product.oldPrice}',
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
