import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import './sign_up.dart';

class SignIn extends StatelessWidget {
  SignIn({required this.logIn});

  final Function logIn;
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title:const Text(
          'Sign In',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //  Container(
              //       width: width,
              //       child: Image.asset(
              //         'assets/images/logo-png.png',
              //         width: width * 0.5,
              //         height: height * 0.3,
              //       )),
                Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: height * 0.01,
                ),
                CustomTextField(
                  hint: 'Enter Email',
                  controller: emailController,
                ),
                SizedBox(height: height * 0.03),
                Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: height * 0.01),
                CustomTextField(
                  hint: 'Enter Password',
                  controller: passowrdController,
                ),
                SizedBox(height: height * 0.05),
                Center(
                  child: Container(
                    width: width * 0.5,
                    height: height * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff11586b))),
                      onPressed: () {
                        logIn(
                            context: context,
                            email: emailController.text.trim(),
                            password: passowrdController.text.trim(),
                            isLogin: true);
                      },
                      child: Text("Sign-In"),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                  child: Container(
                    width: width * 0.6,
                    height: height * 0.06,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignUp())),
                      child: Row(children: [
                        Text("Don't have an account? "),
                        Text(
                          "sign up",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xff11586b),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
