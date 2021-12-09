import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_page_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        if(state is ChangeFavoritesSuccessState){
          if(!state.changeFavoritesModel!.status){
            showToastBar(
                context: context,
                toastColor: Colors.red,
                message: state.changeFavoritesModel!.message);
          }
        }
        if(state is ChangeFavoritesErrorState){
          showToastBar(
              context: context,
              toastColor: Colors.red,
              message: 'network error please check your internet connection');
        }
      },
      builder: (context, state) {
        return BuildCondition(
          condition: state is GetDataFromApiLoadingState &&
              (ShopAppCubit.get(context).homePageModel == null ||
              ShopAppCubit.get(context).categoriesModel == null),
          builder: (context) => const Center(
            child: CircularProgressIndicator(),),
          fallback: (context) => BuildCondition(
            condition:state is GetDataFromApiErrorState &&
                (ShopAppCubit.get(context).homePageModel == null ||
                    ShopAppCubit.get(context).categoriesModel == null),
            builder: (context)=>const Center(child: Text('network error'),),
            fallback:(context)=> ShopAppCubit.get(context).homePageModel == null?
            const Center(child: CircularProgressIndicator(),):
                _buildHomePage(
              model: ShopAppCubit.get(context).homePageModel,
              categories: ShopAppCubit.get(context).categoriesModel,
            ),
          ),
        );
      },
    );
  }

  Widget _buildHomePage({
    required HomePageModel? model,
    required CategoriesModel? categories,
  }) => SingleChildScrollView(
        child: Container(
          color: Colors.grey[300],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                child: CarouselSlider(
                  items: model!.data.banners
                      .map((e) => Image(
                            image: NetworkImage(e.image),
                            width: double.infinity,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.easeInOutCirc,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 0.82,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    'products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.55,
                  ),
                  itemBuilder: (context, index) =>
                      _buildItemViewer(product: model.data.products[index],context: context),
                  itemCount: model.data.products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildItemViewer({
    required ProductModel product,
    required context,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(6),
              child: Stack(
                children: [
                  Image(
                    image: NetworkImage(product.image),
                    width: double.infinity,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.4),
                        ),
                        child: IconButton(
                          onPressed: () {
                            ShopAppCubit.get(context).changeFavorites(id: product.id);
                          },
                          icon: ShopAppCubit.get(context).favorites[product.id]==true?
                          const Icon(Icons.favorite,color: Colors.blue,):
                          const Icon(Icons.favorite_border),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.red,
                        child:product.discount==0? const SizedBox(): Text(
                          '${product.discount} %',
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 1.5,
            color: Colors.black,
            margin: const EdgeInsets.symmetric(horizontal: 30),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: Text(
                    product.name,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '\$${product.price}',
                      style: TextStyle(color: defaultAppColor),
                    ),
                    const Spacer(),
                    Text(
                      '\$${product.oldPrice}',
                      style: const TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
