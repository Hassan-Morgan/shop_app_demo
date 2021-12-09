import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_home_layout.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'cubit/signup_cubit.dart';
import 'cubit/signup_states.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var userNameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var phoneController = TextEditingController();

  bool isSecure = true;

  var formKey = GlobalKey<FormState>();

  Icon passwordSuffixIcon = const Icon(Icons.visibility);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            if (SignUpCubit.get(context).signUpModel!.status == true) {
              CashHelper.saveData(
                      key: 'token',
                      value: SignUpCubit.get(context).signUpModel!.data!.token)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopLayOut(),
                    ),
                    (route) => false);
              });
            }else{
              showToastBar(
                context: context,
                message: '${SignUpCubit.get(context).signUpModel!.message}',
                toastColor: Colors.red,
              );
            }
          }
          if (state is SignUpErrorState) {
            showToastBar(
              context: context,
              message: 'Network error , Please check you internet connection',
              toastColor: Colors.red,
            );
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'signup now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultTextFormField(
                        keyboardType: TextInputType.name,
                        controller: userNameController,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'user name can\'t be empty';
                          }
                          return null;
                        },
                        prefixIcon: Icons.person,
                        label: 'user name',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'E-Mail can\'t be empty';
                          }
                          return null;
                        },
                        prefixIcon: Icons.email,
                        label: 'E-Mail',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'Password can\'t be empty';
                          }
                          return null;
                        },
                        prefixIcon: Icons.lock,
                        label: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (isSecure == true) {
                              setState(() {
                                passwordSuffixIcon =
                                    const Icon(Icons.visibility_off);
                                isSecure = false;
                              });
                            } else {
                              setState(() {
                                passwordSuffixIcon =
                                    const Icon(Icons.visibility);
                                isSecure = true;
                              });
                            }
                          },
                          icon: passwordSuffixIcon,
                        ),
                        isSecure: isSecure,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        validator: (input) {
                          if (input.isEmpty) {
                            return 'phone number can\'t be empty';
                          }
                          return null;
                        },
                        prefixIcon: Icons.phone_android,
                        label: 'phone number',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BuildCondition(
                        condition: state is SignUpLoadingState,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        fallback: (context) => defaultButton(
                          buttonName: 'SignUp',
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              SignUpCubit.get(context).postSignUpData(
                                phone: phoneController.text,
                                userName: userNameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'already have an account ? ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          defaultTextButton(
                              buttonName: 'login',
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
