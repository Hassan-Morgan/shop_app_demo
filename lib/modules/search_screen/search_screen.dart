import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/serch_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              defaultTextFormField(
                controller: searchController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please enter your search';
                  }
                  return null;
                },
                label: 'Search',
                prefixIcon: Icons.search,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20)),
                ),
                child: const Text('search'),
                onPressed: () {
                  ShopAppCubit.get(context)
                      .search(search: searchController.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              state is GetDataFromApiLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: BuildCondition(
                      condition: ShopAppCubit.get(context).searchModel != null,
                      builder: (context) => ShopAppCubit.get(context).searchModel!.data.data.isEmpty?const Center(
                        child: Text('your search don\'t match any of our data'),
                      ): ListView.separated(
                          itemBuilder: (context, index) => buildItem(
                              model: ShopAppCubit.get(context)
                                  .searchModel!
                                  .data
                                  .data[index],
                              context: context),
                          separatorBuilder: (context, index) => Container(
                            height: 1.5,
                            margin: const EdgeInsets.all(20),
                            color: Colors.black,
                          ),
                          itemCount: ShopAppCubit.get(context)
                              .searchModel!
                              .data
                              .data
                              .length),
                      fallback: (context) => const Center(
                        child: Text('tap search to view items'),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItem({required DataModel model, required context}) {
    return Row(
      children: [
        Image(
          image: NetworkImage(model.image),
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
              Text(model.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      ShopAppCubit.get(context).changeFavorites(id: model.id);
                    },
                    icon: ShopAppCubit.get(context).favorites[model.id] == true
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.favorite_border),
                  ),
                  Text('\$${model.price}'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
