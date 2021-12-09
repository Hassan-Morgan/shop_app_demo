import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login_page/login.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'change_password_screen.dart';
import 'edit_profile_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
          body: BuildCondition(
        condition: ShopAppCubit.get(context).userModel == null,
        builder: (context) => const Center(child: CircularProgressIndicator()),
        fallback: (context) => Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        ShopAppCubit.get(context).userModel!.data.image),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ShopAppCubit.get(context).userModel!.data.name,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ShopAppCubit.get(context).userModel!.data.email,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          ShopAppCubit.get(context).userModel!.data.phone,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('update profile '),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Change password '),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  CashHelper.removeData(key: 'token');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LogInPage()),
                      (route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Logout '),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
