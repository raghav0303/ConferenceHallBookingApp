import 'package:conference_hall_booking/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:conference_hall_booking/constants.dart';
import 'package:conference_hall_booking/reusables/reusable_widgets.dart';
import 'package:conference_hall_booking/screens/reset_password_screen.dart';
import 'package:conference_hall_booking/constants.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: null),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0,
                    screenHeight * 0.07,
                    screenWidth * 0,
                    screenHeight * 0.03,
                  ),
                  child: Image.asset(
                    "assets/images/booking.png",
                    width: screenWidth * 0.7,
                  ),
                ),
                Container(
                  width: 333,
                  height: 396,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        Text(
                          'Signup',
                          style: TextStyle(
                            color: Color(0xFF726F6B),
                            fontSize: 20,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          child: reusableTextField("Enter Username",
                              Icons.person, false, _usernameTextController),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          child: reusableTextField("Enter Email Id",
                              Icons.email, false, _emailTextController),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          child: reusableTextField("Enter Password", Icons.lock,
                              true, _passwordTextController),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                          ),
                          child: reusableTextField("Confirm Password",
                              Icons.lock, true, _confirmPasswordTextController),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: screenWidth * 0.05,
                        //   ),
                        //   child: forgetPassword(context),
                        // ),

                        ElevatedButton(
                          onPressed: () {
                            // Add your login logic here
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFB500),
                            elevation: 4,
                            shadowColor: Color(0x3F000000),
                            minimumSize: Size(172, 41),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),

                        signUpOption()
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text(
            " Log In",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
