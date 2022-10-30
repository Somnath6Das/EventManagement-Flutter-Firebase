import 'package:dotted_border/dotted_border.dart';
import 'package:event_management/utils/app_color.dart';
import 'package:event_management/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String event_type = 'Public';
  List<String> list_item = ['Public', 'Private'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(children: [
              iconWithTitle(text: 'Create Event', func: () {}),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: 90,
                    height: 33,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.black.withOpacity(0.6),
                                width: 0.6))),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: Container(),
                      icon: Image.asset(
                        'assets/down-arrow.png',
                        width: 17,
                      ),
                      elevation: 16,
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: AppColors.black),
                      value: event_type,
                      onChanged: (String? newValue) {
                        setState(() {
                          event_type = newValue!;
                        });
                      },
                      items: list_item
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.03),
              Container(
                height: Get.width * 0.6,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                    color: AppColors.border.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: DottedBorder(
                  color: AppColors.border,
                  strokeWidth: 1.5,
                  dashPattern: const [6, 6],
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Get.height * 0.03),
                        SizedBox(
                          width: 76,
                          height: 59,
                          child: Image.asset('assets/cloud-storage.png'),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        myText(
                            text: 'Tab and upload image/video',
                            style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 19,
                                fontWeight: FontWeight.w400)),
                        SizedBox(height: Get.height * 0.02),
                        elevatedButton(
                            onPress: () async {
                              mediaDialog(context);
                            },
                            text: 'Upload')
                      ],
                    ),
                  ),
                ),
              )
            ]),
          )),
    )));
  }

  void mediaDialog(BuildContext context) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select media type', style: TextStyle(color: Colors.blue[800]),),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, true);
                    },
                    icon: Icon(Icons.image, size: 35, color: Colors.blue[600],)),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, false);
                    },
                    icon: Icon(Icons.slow_motion_video_outlined, size: 35, color: Colors.blue[600],))
              ],
            ),
          );
        },
        context: context);
  }

  void imageDialog(BuildContext context, bool image) {}
}
