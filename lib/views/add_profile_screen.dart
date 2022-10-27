import 'dart:io';
import 'package:event_management/controllers/auth_controller.dart';
import 'package:event_management/utils/app_color.dart';
import 'package:event_management/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));

    if (picked != null) {
      dobController.text = '${picked.day}-${picked.month}-${picked.year}';
    }
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  imagePickDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choose Image Source'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.camera);

                    if (image != null) {
                      CroppedFile? croppedImage = await ImageCropper()
                          .cropImage(
                              sourcePath: image.path, compressQuality: 20);

                      profileImage = File(croppedImage!.path);
                      setState(() {});
                      Navigator.pop(context);
                    }
                  },
                  child: Image.asset(
                    'assets/camera.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        CroppedFile? croppedImage = await ImageCropper()
                          .cropImage(
                              sourcePath: image.path, compressQuality: 20);

                        profileImage = File(croppedImage!.path);
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    child: Image.asset(
                      'assets/gallery.png',
                      width: 25,
                      height: 25,
                    ))
              ],
            ),
          );
        });
  }

  File? profileImage;

  void setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  int selectedRadio = 0;

  AuthController? authController;

  @override
  void initState() {
    super.initState();
    authController = Get.find<AuthController>();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    mobileNumberController.dispose();
    dobController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: SingleChildScrollView(
                  child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.width * 0.1,
                    ),
                    InkWell(
                      onTap: () {
                        imagePickDialog();
                      },
                      child: Container(
                        width: 120,
                        height: 120,
                        margin: const EdgeInsets.only(top: 35),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(70),
                            gradient: const LinearGradient(colors: [
                              Color(0xff7DDCFB),
                              Color(0xffBC67F2),
                              Color(0xffACF6AF),
                              Color(0xffF95549),
                            ])),
                        child: Column(children: [
                          Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: profileImage == null
                                  ? const CircleAvatar(
                                      radius: 56,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.blue,
                                        size: 50,
                                      ))
                                  : CircleAvatar(
                                      radius: 56,
                                      backgroundColor: Colors.white,
                                      backgroundImage: FileImage(profileImage!),
                                    )),
                        ]),
                      ),
                    ),
                    SizedBox(height: Get.width * 0.1),
                    textField(
                        text: 'First Name',
                        controller: firstNameController,
                        validator: (String input) {
                          if (firstNameController.text.isEmpty) {
                            Get.snackbar('Warning', 'First Name is required.',
                                colorText: Colors.white,
                                backgroundColor: Colors.blue);
                            return '';
                          }
                        }),
                    textField(
                        text: 'Last Name',
                        controller: lastNameController,
                        validator: (String input) {
                          if (lastNameController.text.isEmpty) {
                            Get.snackbar('Warning', 'Last Name is required.',
                                colorText: Colors.white,
                                backgroundColor: Colors.blue);
                            return '';
                          }
                        }),
                    textField(
                        text: 'Mobile Number',
                        inputType: TextInputType.phone,
                        controller: mobileNumberController,
                        validator: (String input) {
                          if (mobileNumberController.text.isEmpty) {
                            Get.snackbar(
                                'Warning', 'Mobile Number is required.',
                                colorText: Colors.white,
                                backgroundColor: Colors.blue);
                            return '';
                          }
                          if (mobileNumberController.text.length < 10) {
                            Get.snackbar('Warning', 'Enter valid phone number',
                                colorText: Colors.white,
                                backgroundColor: Colors.blue);
                            return '';
                          }
                        }),
                    SizedBox(
                      height: 48,
                      child: TextField(
                        controller: dobController,
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _selectDate(context);
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.only(top: 10, left: 10),
                            suffixIcon: Image.asset(
                              'assets/calender.png',
                              cacheHeight: 20,
                            ),
                            hintText: 'Date of Birth',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0))),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: RadioListTile(
                          title: Text('Male',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.genderTextColor)),
                          value: 0,
                          groupValue: selectedRadio,
                          onChanged: (int? val) {
                            setSelectedRadio(val!);
                          },
                        )),
                        Expanded(
                            child: RadioListTile(
                          title: Text('Female',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.genderTextColor)),
                          value: 1,
                          groupValue: selectedRadio,
                          onChanged: (int? val) {
                            setSelectedRadio(val!);
                          },
                        )),
                      ],
                    ),
                    Obx(() => authController!.isProfileInformationLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            height: 50,
                            margin: EdgeInsets.only(top: Get.height * 0.02),
                            width: Get.width,
                            child: elevatedButton(
                                text: 'Save',
                                onPress: () async {
                                  if (dobController.text.isEmpty) {
                                    Get.snackbar(
                                        'Warning', 'Date of birth is required',
                                        colorText: Colors.white,
                                        backgroundColor: Colors.blue);
                                    return '';
                                  }
                                  if (!formKey.currentState!.validate()) {
                                    return null;
                                  }
                                  if (profileImage == null) {
                                    Get.snackbar('Warning', 'Image is required',
                                        colorText: Colors.white,
                                        backgroundColor: Colors.blue);
                                    return null;
                                  }
                                  authController!
                                      .isProfileInformationLoading(true);
                                  String imageUrl = await authController!
                                      .uploadImageToFirebaseStorage(
                                          profileImage!);
                                  authController!.uploadProfileData(
                                      imageUrl,
                                      firstNameController.text.trim(),
                                      lastNameController.text.trim(),
                                      mobileNumberController.text.trim(),
                                      dobController.text.trim(),
                                      selectedRadio == 0 ? 'Male' : 'Female');
                                }))),
                    SizedBox(height: Get.height * 0.03),
                    SizedBox(
                        width: Get.width * 0.8,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: 'By signing up, you agree our',
                                  style: TextStyle(
                                      color: Color(0xff262628), fontSize: 12)),
                              TextSpan(
                                  text: 'terms, Data policy and cookies policy',
                                  style: TextStyle(
                                      color: Color(0xff262628),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold))
                            ])))
                  ],
                ),
              )))),
    );
  }
}
