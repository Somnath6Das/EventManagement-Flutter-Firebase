import 'dart:async';

import 'package:event_management/views/bottom_bar_view.dart';
import 'package:event_management/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    (FirebaseAuth.instance.currentUser != null)
                        ? const BottomBarView()
                        : const LoginView())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              const Text(
                "Welcome to EMS!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Text(
                "Event Management System",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Flexible(
                child: Image.asset(
                  "assets/front.png",
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Expanded(
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            topLeft: Radius.circular(16))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.03),
                          child: const Text(
                            'The sociol media platform designed to get you offline',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.01),
                          child: const Text(
                            'The sociol media platform designed to get you offline',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Flexible(
                          child: MaterialButton(
                              height: MediaQuery.of(context).size.height * 0.06,
                              minWidth: double.infinity,
                              color: Colors.white,
                              elevation: 4,
                              onPressed: () {
                                Get.to(() => const LoginView());
                              },
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff274560),
                                    fontWeight: FontWeight.w800),
                              )),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
