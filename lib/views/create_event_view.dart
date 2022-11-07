import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:event_management/models/event_media_model.dart';
import 'package:event_management/utils/app_color.dart';
import 'package:event_management/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String event_type = 'Public';
  List<String> list_item = ['Public', 'Private'];
  List<EventMediaModel> media = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController maxEntries = TextEditingController();
  TextEditingController tagsController = TextEditingController();

  var selectedFrequency = -2;

  DateTime? date = DateTime.now();
  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2101),
        initialDatePickerMode: DatePickerMode.day);

    if (picked != null) {
      date = DateTime(picked.year, picked.month, picked.day, date!.hour,
          date!.minute, date!.second);
      dateController.text = '${date!.day}-${date!.month}-${date!.year}';
    }
    setState(() {});
  }

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
              ),
              media.isEmpty ? Container() : const SizedBox(height: 20),
              media.isEmpty
                  ? Container()
                  : SizedBox(
                      width: Get.width,
                      height: Get.width * 0.3,
                      child: ListView.builder(
                        itemCount: media.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return media[index].isVideo!
                              ? Container(
                                  width: Get.width * 0.3,
                                  height: Get.width * 0.3,
                                  margin: const EdgeInsets.only(
                                      right: 15, bottom: 10, top: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(
                                              media[index].thumbnail!),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Stack(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: CircleAvatar(
                                                child: IconButton(
                                                  onPressed: () {
                                                    media.removeAt(index);
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(Icons.close),
                                                ),
                                              ))
                                        ],
                                      ),
                                      const Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                              Icons.slow_motion_video_rounded,
                                              color: Colors.black,
                                              size: 40))
                                    ],
                                  ),
                                )
                              : Container(
                                  width: Get.width * 0.3,
                                  height: Get.width * 0.3,
                                  margin: const EdgeInsets.only(
                                      right: 15, bottom: 10, top: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(media[index].image!),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CircleAvatar(
                                            child: IconButton(
                                                onPressed: () {
                                                  media.removeAt(index);
                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.close)),
                                          ))
                                    ],
                                  ));
                        },
                      )),
              const SizedBox(height: 20),
              myTextField(
                  bool: false,
                  icon: 'assets/4DotIcon.png',
                  text: 'Event Name',
                  controller: titleController,
                  validator: (String input) {
                    if (input.isEmpty) {
                      Get.snackbar('Warning', "Events name is required.",
                          colorText: Colors.white,
                          backgroundColor: Colors.blue);
                      return '';
                    }
                    if (input.length < 3) {
                      Get.snackbar('Warning',
                          "Event name should be more than three characters",
                          colorText: Colors.white,
                          backgroundColor: Colors.blue);
                      return '';
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              myTextField(
                  bool: false,
                  icon: 'assets/location.png',
                  text: 'Location',
                  controller: locationController,
                  validator: (String input) {
                    if (input.isEmpty) {
                      Get.snackbar('Warning', "Location name is required.",
                          colorText: Colors.white,
                          backgroundColor: Colors.blue);
                      return '';
                    }
                    if (input.length < 3) {
                      Get.snackbar('Warning', "Location name is Invalid",
                          colorText: Colors.white,
                          backgroundColor: Colors.blue);
                      return '';
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  iconTitleContainer(
                      isReadOnly: true,
                      path: 'assets/calender1.png',
                      text: "Date",
                      controller: dateController,
                      validator: (input) {
                        if (date == null) {
                          Get.snackbar('Warning!', "Date id required!",
                              colorText: Colors.white,
                              backgroundColor: Colors.blue);
                          return '';
                        }
                        return null;
                      },
                      onPress: () {
                        selectDate(context);
                      }),
                  iconTitleContainer(
                      path: 'assets/hash.png',
                      text: 'Max Entries',
                      controller: maxEntries,
                      type: TextInputType.number,
                      onPress: () {},
                      validator: (String input) {
                        if (input.isEmpty) {
                          Get.snackbar('Warning!', "Entries is required.",
                              colorText: Colors.white,
                              backgroundColor: Colors.blue);
                          return '';
                        }
                        return null;
                      }),
                ],
              ),
              const SizedBox(height: 20),
              iconTitleContainer(
                  path: 'assets/hash.png',
                  text: 'Enter tags that will go with event.',
                  width: double.infinity,
                  controller: tagsController,
                  type: TextInputType.text,
                  onPress: () {},
                  validator: (String input) {
                    if (input.isEmpty) {
                      Get.snackbar('Warning', "Entries is required.",
                          colorText: Colors.white,
                          backgroundColor: Colors.blue);
                      return '';
                    }
                    return null;
                  }),
              const SizedBox(height: 20),
              Container(
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: AppColors.genderTextColor),
                  ),
                  child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        Get.bottomSheet(
                            StatefulBuilder(builder: (context, state) {
                          return Container(
                            width: double.infinity,
                            height: Get.width * 0.6,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    selectedFrequency == 10
                                        ? Container()
                                        : const SizedBox(
                                            width: 10,
                                          ),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        selectedFrequency = -1;
                                        state(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: selectedFrequency == -1
                                                ? Colors.blue
                                                : Colors.black.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                          child: Text(
                                            'Once',
                                            style: TextStyle(
                                                color: selectedFrequency != -1
                                                    ? Colors.black
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    )),
                                    selectedFrequency == 10
                                        ? Container()
                                        : const SizedBox(
                                            width: 5,
                                          ),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        selectedFrequency = 0;
                                        state(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: selectedFrequency == 0
                                              ? Colors.blue
                                              : Colors.black.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "Daily",
                                          style: TextStyle(
                                              color: selectedFrequency != 0
                                                  ? Colors.black
                                                  : Colors.white),
                                        )),
                                      ),
                                    )),
                                    selectedFrequency == 10
                                        ? Container()
                                        : const SizedBox(
                                            width: 5,
                                          ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          state(() {
                                            selectedFrequency = 1;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: selectedFrequency == 1  ? Colors.blue : Colors.black.withOpacity(0.1),
                                          ),
                                        child: Center(child: Text("Weekly", style: TextStyle(
                                          color: selectedFrequency != 1 ? Colors.black : Colors.white
                                        ),),),),
                                      ),
                                    ),selectedFrequency == 10
                                        ? Container()
                                        : const SizedBox(
                                            width: 10,
                                          ),
                                  ],
                                ),
                                Row(
                                  children: [],
                                )                                   //?    line : 597
                              ],
                            ),
                          );
                        }));
                      }))
            ]),
          )),
    )));
  }

  void mediaDialog(BuildContext context) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Select media type',
              style: TextStyle(color: Colors.blue[800]),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, true);
                    },
                    icon: Icon(
                      Icons.image,
                      size: 35,
                      color: Colors.blue[600],
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      imageDialog(context, false);
                    },
                    icon: Icon(
                      Icons.slow_motion_video_outlined,
                      size: 35,
                      color: Colors.blue[600],
                    ))
              ],
            ),
          );
        },
        context: context);
  }

  void imageDialog(BuildContext context, bool image) {
    showDialog(
        builder: (BuildContext context) {
          return AlertDialog(
              title: (image)
                  ? Text(
                      "Select image source",
                      style: TextStyle(color: Colors.blue[800]),
                    )
                  : Text(
                      "Select video source",
                      style: TextStyle(color: Colors.blue[800]),
                    ),
              content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (image) {
                            getImageDialog(ImageSource.gallery);
                          } else {
                            getVideoDialog(ImageSource.gallery);
                          }
                        },
                        icon: Icon(
                          Icons.image,
                          size: 35,
                          color: Colors.blue[600],
                        )),
                    IconButton(
                        onPressed: () {
                          if (image) {
                            getImageDialog(ImageSource.camera);
                          } else {
                            getVideoDialog(ImageSource.camera);
                          }
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 35,
                          color: Colors.blue[600],
                        )),
                  ]));
        },
        context: context);
  }

  getImageDialog(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      media.add(EventMediaModel(
          image: File(image.path), video: null, isVideo: false));
    }
    setState(() {});
    Navigator.pop(context);
  }

  getVideoDialog(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(
      source: source,
    );
    if (video != null) {
      Uint8List? uint8list = await VideoThumbnail.thumbnailData(
        video: video.path,
        imageFormat: ImageFormat.PNG,
        quality: 75,
      );

      media.add(EventMediaModel(
          thumbnail: uint8list!, video: File(video.path), isVideo: true));
    }
    setState(() {});
    Navigator.pop(context);
  }
}
