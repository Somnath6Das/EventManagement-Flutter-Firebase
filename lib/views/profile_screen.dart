import 'package:event_management/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isNotEditable = true;
  String image = '';
  int? followers = 0, following = 0;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Stack(children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 100,
              margin:
                  EdgeInsets.only(left: Get.width * 0.75, top: 20, right: 20),
              alignment: Alignment.topRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Image(
                      image: AssetImage('assets/sms.png'),
                      width: 28,
                      height: 25,
                    ),
                  ),
                  const Image(
                      image: AssetImage('assets/list.png'),
                      width: 28,
                      height: 25)
                ],
              ),
            ),
          ),
          Align(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 90, horizontal: 20),
              width: Get.width,
              height: isNotEditable ? 240 : 310,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 0),
                    )
                  ]),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                InkWell(
                  onTap: () {},
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
                          Color(0xffF95549)
                        ])),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(70),
                          ),
                          child: image.isEmpty
                              ? const CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      AssetImage('assets/profile.png'),
                                )
                              : CircleAvatar(
                                  radius: 56,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(image),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                isNotEditable
                    ? Text(
                        "${firstNameController.text} ${lastNameController.text}",
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      )
                    : SizedBox(
                        width: Get.width * 0.6,
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: firstNameController,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                              ),
                            )),
                            const SizedBox(width: 10),
                            Expanded(
                                child: TextField(
                              controller: lastNameController,
                              textAlign: TextAlign.center,
                              decoration:
                                  const InputDecoration(hintText: 'Last Name'),
                            ))
                          ],
                        ),
                      ),
                isNotEditable
                    ? Text(locationController.text,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff918F8F),
                        ))
                    : SizedBox(
                        width: Get.width * 0.6,
                        child: TextField(
                            controller: locationController,
                            textAlign: TextAlign.center,
                            decoration:
                                const InputDecoration(hintText: 'Location'))),
                const SizedBox(
                  height: 15,
                ),
                isNotEditable
                    ? SizedBox(
                        width: 270,
                        child: Text(
                          descriptionController.text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              letterSpacing: -0.3,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      )
                    : SizedBox(
                        width: Get.width * 0.6,
                        child: TextField(
                          controller: descriptionController,
                          textAlign: TextAlign.center,
                          decoration:
                              const InputDecoration(hintText: 'Description'),
                        ),
                      ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            "$followers",
                            style:  TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.3
                            ),
                          ),
                          Text(
                            "Followers", style: TextStyle(
                              fontSize: 13
                              , letterSpacing: -0.3,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grey
                            ),
                          )
                        ],
                      ),
                       Container(width: 1, height: 35,
                      color: const Color(0xff918F8F).withOpacity(0.5)),
                      Column(
                        children: [
                          Text("$following",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3
                          ),
                          ),
                          Text("Following",
                          style: TextStyle(
                            fontSize: 13,
                            letterSpacing: -0.3,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grey
                          ),
                          )
                        ],
                      ),
                      SizedBox(height: 40,
                      width: screenWidth * 0.25,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape:const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                       backgroundColor: AppColors.blue
                        ),
                        onPressed: (){} ,
                        child: Text('Follow',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                        )),
                      )
                        //365
                    ],
                  ),
                ),

                //389

                
              ],
            ),
          )
        ]),
      )),
    );
  }
}
