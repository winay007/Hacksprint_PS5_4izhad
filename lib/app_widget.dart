import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:road_app/bottom_navigation_bar.dart';
import 'package:road_app/screens/track_progress_screen.dart';
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong!'),
            );
          } else if (snapshot.hasData) {
            return NavigationFile();
          } else {
            return SignUp();
          }
        },
      ),
      routes: {
        TrackProgress.routeName :(context) => TrackProgress()
      },
    );
  }
}
