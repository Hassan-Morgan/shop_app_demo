import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings_page/settings_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  var userController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
      if (state is GetDataFromApiSuccessState &&
          ShopAppCubit.get(context).updateProfileModel!.status) {
        Navigator.pop(
            context);
        showToastBar(
            context: context,
            toastColor: Colors.green,
            message: ShopAppCubit.get(context).updateProfileModel!.message);
      }
      if (state is ChangeUserDataSuccessState &&
          ShopAppCubit.get(context).updateProfileModel!.status == false) {
        showToastBar(
            context: context,
            toastColor: Colors.red,
            message: ShopAppCubit.get(context).updateProfileModel!.message);
      }
      if (state is ChangeUserDataErrorState) {
        showToastBar(
            context: context,
            toastColor: Colors.red,
            message: 'please check your internet connection');
      }
    }, builder: (context, state) {
      userController.text = ShopAppCubit.get(context).userModel!.data.name;
      emailController.text = ShopAppCubit.get(context).userModel!.data.email;
      phoneController.text = ShopAppCubit.get(context).userModel!.data.phone;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Update profile'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    state is ChangeUserDataLoadingState ||
                            state is GetDataFromApiLoadingState
                        ? const LinearProgressIndicator()
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                      controller: userController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'user name cannot be empty';
                        }
                        return null;
                      },
                      label: " user name",
                      prefixIcon: Icons.person,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'email cannot be empty';
                        }
                        return null;
                      },
                      label: " email",
                      prefixIcon: Icons.mail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'phone cannot be empty';
                        }
                        return null;
                      },
                      label: " phone",
                      prefixIcon: Icons.phone_android,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        buttonName: 'UPDATE',
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            ShopAppCubit.get(context).updateUserData(
                                newName: userController.text,
                                newEmail: emailController.text,
                                newPhone: phoneController.text);
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        buttonName: 'CANCEL',
                        onPress: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
