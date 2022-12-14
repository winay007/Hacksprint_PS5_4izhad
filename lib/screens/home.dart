import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:road_app/screens/track_progress_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Road app',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("reports").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> allData = snapshot.data!.docs;

              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final data = allData[index];
                  return CustomWidget(
                      imageurl: data['imageUrl'],
                      content: data['content'],
                      title: data['title'],
                      username: data['publisher'],
                      date: data['date']);
                },
                itemCount: allData.length,
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class CustomWidget extends StatelessWidget {
  CustomWidget({
    super.key,
    required this.content,
    required this.imageurl,
    required this.title,
    required this.username,
    required this.date,
  });
  String imageurl;
  String title;
  String content;
  String username;
  String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: Container(
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 30,
            top: 20,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, TrackProgress.routeName,
                          arguments: {
                            'username': username,
                            'title': title,
                            'date': date,
                          });
                    },
                    child: Container(
                      color: Colors.red,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Opacity(
                        opacity: 0.9,
                        child: Image.network(
                          imageurl,
                          fit: BoxFit.contain,
                          height: 290,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: 250,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.7),
                            spreadRadius: 8,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Opacity(
                          opacity: 1,
                          child: Text(
                            content,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                            textAlign: TextAlign.center,
                          )),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 30,
                      child: Opacity(
                        opacity: 1,
                        child: Image.asset(
                          "assets/images/green_tick.png",
                          fit: BoxFit.contain,
                          height: 100,
                        ),
                      ))
                ],
              )
            ],
          )),
    );
  }
}
