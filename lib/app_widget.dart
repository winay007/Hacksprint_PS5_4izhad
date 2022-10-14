
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/sign_up.dart';

class AppWidget extends StatelessWidget {
  final navigatorkey = GlobalKey<NavigatorState>();
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorkey,
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong!'),
              );
            } else if (snapshot.hasData) {
              return HomePage();
            } else {
              return SignUp();
            }
          }),
    );
  }
}
