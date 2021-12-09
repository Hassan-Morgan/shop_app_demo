import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/favorite_page/favorite_page.dart';
import 'package:shop_app/modules/home_page/home_page.dart';
import 'package:shop_app/modules/search_screen/search_screen.dart';
import 'package:shop_app/modules/settings_page/settings_page.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ShopLayOut extends StatelessWidget {
  ShopLayOut({Key? key}) : super(key: key);

  List<Widget>screens =[
    HomePage(),
    SearchScreen(),
    FavoritePage(),
    SettingsPage(),
  ];
  List<String>screensTitles =[
    'ShopHome',
    'Search',
    'Favorites',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = ShopAppCubit.get(context);
          return  Scaffold(
              appBar: AppBar(
                title: Text(screensTitles[cubit.navBarCurrentIndex]),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.navBarCurrentIndex,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.search),label: 'SEARCH'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'FAVORITE'),
                  BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'SETTINGS'),
                ],
                onTap: (index){
                  cubit.changeNavBarIndex(index: index);
                },
              ),
              body: screens[cubit.navBarCurrentIndex],
          );
        },
    );
  }
}
