import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/CreateAccount.dart';
import 'package:ekonomi_new/screens/home_screen.dart';
import 'package:ekonomi_new/widgets/general/Onboard_Btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Registeration extends StatelessWidget {
  const Registeration({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),

                          child: Icon(
                            Icons.currency_rupee,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          "EKONOMI",
                        ),
                        Text(
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          "Your Finance Simplified!",
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      OnboardBtn(
                        func: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => Createaccount(),
                            ),
                          );
                        },
                        caption: "Create Account",
                        bgColor: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: 10),
                      OnboardBtn(
                        func: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => Homescreen(),
                            ),
                          );
                        },
                        caption: "Login",
                        bgColor: Colors.blueGrey,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
