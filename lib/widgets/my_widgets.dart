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
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget iconWithTitle({text, Function? func, bool? isShow = true}) {
  return Row(children: [
    //when isShaw has false value then show Expended widget
    !isShow!
        ? Container()
        : Expanded(
            flex: 0,
            child: InkWell(
              onTap: () {
                func!();
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: Get.width * 0.02,
                    top: Get.height * 0.08,
                    bottom: Get.height * 0.02),
                width: 30,
                height: 30,
              ),
            )),
    Expanded(
      flex: 6,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: Get.height * 0.056),
        child: myText(
            text: text,
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600)),
      ),
    ),
    const Expanded(flex: 1, child: Text(''))
  ]);
}

Widget iconTitleContainer(
    {text,
    path,
    Function? onPress,
    bool isReadOnly = false,
    TextInputType type = TextInputType.text,
    TextEditingController? controller,
    Function? validator,
    double width = 150,
    double height = 40}) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.1, color: AppColors.genderTextColor)),
      width: width,
      height: height,
      child: TextFormField(
        validator: (String? input) => validator!(input!),
        controller: controller,
        keyboardType: type,
        readOnly: isReadOnly,
        onTap: () {
          onPress!();
        },
        decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 0),
            contentPadding: const EdgeInsets.only(top: 3),
            prefixIcon: Image.asset(path, cacheHeight: 18),
            hintText: text,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.genderTextColor),
            border: isReadOnly
                ? OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffA6A6A6)),
                    borderRadius: BorderRadius.circular(8),
                  )
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
      ));
}
