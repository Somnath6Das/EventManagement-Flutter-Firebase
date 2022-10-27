import 'dart:ui';
import 'package:event_management/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget myText({text, style, textAlign}) {
  return Text(
    text,
    style: style,
    textAlign: textAlign,
    overflow: TextOverflow.ellipsis,
  );
}

Widget textField(
    {text,
    TextEditingController? controller,
    Function? validator,
    TextInputType inputType = TextInputType.text}) {
  return Container(
    height: 48,
    margin: EdgeInsets.only(bottom: Get.height * 0.02),
    child: TextFormField(
      keyboardType: inputType,
      controller: controller,
      validator: (input) => validator!(input),
      decoration: InputDecoration(
          hintText: text,
          errorStyle: const TextStyle(fontSize: 0),
          contentPadding: const EdgeInsets.only(top: 10, left: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
    ),
  );
}

Widget myTextField({
  text,
  String? icon,
  bool,
  TextEditingController? controller,
  Function? validator,
}) {
  return SizedBox(
    height: 45,
    child: TextFormField(
      validator: (input) => validator!(input),
      obscureText: bool,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 5),
          errorStyle: const TextStyle(fontSize: 0),
          hintStyle: TextStyle(color: AppColors.genderTextColor),
          hintText: text,
          prefixIcon: Image.asset(icon!, cacheHeight: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
    ),
  );
}

Widget socialAppsIcons({text, Function? onPressed}) {
  return InkWell(
    onTap: () => onPressed!(),
    child: Container(
      margin: EdgeInsets.all(10),
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(text),
        ),
      ),
    ),
  );
}

Widget elevatedButton({text, Function? onPress}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(AppColors.blue),
    ),
    onPressed: () {
      onPress!();
    },
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
