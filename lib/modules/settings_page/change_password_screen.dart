import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/settings_page/settings_page.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var currentPasswordController = TextEditingController();

  var newPasswordController = TextEditingController();
  bool isCurrentPasswordSecure = true;
  bool isNewPasswordSecure = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
      if (state is ChangePasswordSuccessState) {
        if (ShopAppCubit.get(context).changePasswordModel!.status) {
          Navigator.pop(context);
          showToastBar(
              context: context,
              toastColor: Colors.green,
              message: ShopAppCubit.get(context).changePasswordModel!.message);
        } else {
          showToastBar(
              context: context,
              toastColor: Colors.red,
              message: ShopAppCubit.get(context).changePasswordModel!.message);
        }
        if (state is ChangePasswordErrorState) {
          showToastBar(
              context: context,
              toastColor: Colors.red,
              message: 'please check your internet connection');
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('change Password'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    state is ChangePasswordLoadingState
                        ? const LinearProgressIndicator()
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                        controller: currentPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this feild can\'t be empty';
                          }
                          return null;
                        },
                        label: " current password",
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        isSecure: isCurrentPasswordSecure,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isCurrentPasswordSecure =
                                    !isCurrentPasswordSecure;
                              });
                            },
                            icon: isCurrentPasswordSecure
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off))),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultTextFormField(
                        controller: newPasswordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field cannot be empty';
                          }
                          return null;
                        },
                        label: " new Password",
                        prefixIcon: Icons.lock,
                        keyboardType: TextInputType.visiblePassword,
                        isSecure: isNewPasswordSecure,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isNewPasswordSecure = !isNewPasswordSecure;
                              });
                            },
                            icon: isNewPasswordSecure
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off))),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        buttonName: 'Confirm',
                        onPress: () {
                          if (formKey.currentState!.validate()) {
                            ShopAppCubit.get(context).changePassword(
                                currentPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text);
                            if (ShopAppCubit.get(context)
                                .changePasswordModel!
                                .status) {
                              Navigator.pop(context);
                            }
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
