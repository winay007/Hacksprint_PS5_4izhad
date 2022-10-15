import 'package:flutter/material.dart';

class TrackProgress extends StatefulWidget {
  const TrackProgress({super.key});

  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Track reported progress',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              height: 200, child: Image.asset("assets/images/authority.png")),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            width: 500,
            child: Row(
              children: [
                Container(
                  height: 10,
                  width: 100,
                  margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                    border: Border.all(
                        width: 8,
                        color: const Color.fromARGB(255, 99, 11, 242)),
                    color: const Color.fromARGB(255, 99, 11, 242),
                  ),
                ),
                const CircleAvatar(
                  child: Icon(Icons.check),
                ),
                Expanded(
                  child: Container(
                    height: 10,
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(
                        width: 5,
                        color: const Color.fromARGB(255, 158, 120, 218),
                      ),
                      color: Colors.grey,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.alarm),
                Icon(Icons.done),
              ],
            ),
          )
        ],
      ),
    );
  }
}
