import 'package:event_management/controllers/data_controller.dart';
import 'package:event_management/views/community_screen.dart';
import 'package:event_management/views/create_event_view.dart';
import 'package:event_management/views/home_screen.dart';
import 'package:event_management/views/message_screen.dart';
import 'package:event_management/views/profile_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> widgetOption = [
    HomeScreen(),
    CommunityScreen(),
    CreateEventView(),
    MessageScreen(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    Get.put(DataController(), permanent: true);
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      //  Local notification service
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOption[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          selectedItemColor: Colors.black,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 0
                        ? 'assets/home_hover.png'
                        : 'assets/home.png',
                    width: 28,
                    height: 28,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 1
                        ? 'assets/clock_hover.png'
                        : 'assets/clock.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 2
                        ? 'assets/plus_hover.png'
                        : 'assets/plus.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 3
                        ? 'assets/comment_hover.png'
                        : 'assets/comment.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    currentIndex == 4
                        ? 'assets/user_hover.png'
                        : 'assets/user.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                label: ''),
          ]),
    );
  }
}
