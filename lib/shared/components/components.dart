import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton({
  required String buttonName,
  required onPress,
  controller,
}){
  return Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
        color: defaultAppColor,
        borderRadius: BorderRadius.circular(20),
    ),
    child: MaterialButton(
      onPressed: onPress,
      child:  Text(
         buttonName,
        style:
        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),
      ),
    ),
  );
}

Widget defaultTextFormField({
  required TextEditingController controller,
  required validator,
  required String label,
  required IconData prefixIcon,
  Widget? suffixIcon,
  required TextInputType keyboardType,
  bool isSecure = false,
}){
  return TextFormField(
    obscureText: isSecure ,
    controller: controller,
    validator:validator ,
    keyboardType:keyboardType ,
    decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      labelText: label,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon,
    ),
  );
}

Widget defaultTextButton({
  required String buttonName,
  required onPressed,
}){
  return TextButton(
      onPressed: onPressed,
      child: Text(buttonName),
  );
}

ToastFuture showToastBar({
  required context,
  required Color toastColor,
  required String message,
}){
  return showToastWidget(
    Container(
      margin:const EdgeInsets.all(20) ,
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
        color: toastColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
    context: context,
    duration: const Duration(seconds: 2),
    position: StyledToastPosition.bottom,
    isHideKeyboard: true,
    animation: StyledToastAnimation.scale,
    animDuration: const Duration(milliseconds: 300),
  );
}