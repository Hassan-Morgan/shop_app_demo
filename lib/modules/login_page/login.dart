import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_home_layout.dart';
import 'package:shop_app/modules/signup_page/signup.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isSecure = true;

  Icon passwordSuffixIcon = const Icon(Icons.visibility);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: BlocConsumer<LogInCubit, LogInStates>(
        listener: (context, state) {
          if (state is LogInSuccessState) {
            if (state.logInModel.status == true) {
              CashHelper.saveData(
                      key: 'token', value: state.logInModel.data!.token)
                  .then((value) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopLayOut(),
                    ),
                    (route) => false);
              });
            } else {
              showToastBar(
                context: context,
                message: '${state.logInModel.message}',
                toastColor: Colors.red,
              );
            }
          } else if (state is LogInErrorState) {
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
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'LogIn now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(
                        height: 30,
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
                            if (isSecure == true){
                              setState(() {
                                passwordSuffixIcon =const Icon(Icons.visibility_off);
                                isSecure = false;
                              });
                            }else{
                              setState(() {
                                passwordSuffixIcon =const Icon(Icons.visibility);
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
                      BuildCondition(
                        condition: state is LogInLoadingState,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        fallback: (context) => defaultButton(
                          buttonName: 'login',
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              LogInCubit.get(context).postLogInData(
                                language: 'en',
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
                            'don\'t have an account ? ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          defaultTextButton(
                              buttonName: 'SignUp',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()),
                                );
                              })
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
