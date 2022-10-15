import 'package:flutter/material.dart';

class TrackProgress extends StatefulWidget {
  TrackProgress({
    super.key,
  });

  static const String routeName = '/track_progress';
  @override
  State<TrackProgress> createState() => _TrackProgressState();
}

class _TrackProgressState extends State<TrackProgress> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
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
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              args['title'] as String,
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(args['username'] as String),
          ),
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
              children: [
                const Icon(Icons.alarm),
                Text(args['date'] as String),
                Icon(Icons.done),
              ],
            ),
          ),
          Container(
              height: 300,
              margin: const EdgeInsets.fromLTRB(30, 70, 30, 20),
              decoration: const BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: Colors.purple,
                    width: 8,
                  ),
                ),
              ),
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return CustomWidget();
                }),
                itemCount: 6,
              ))
        ],
      ),
    );
  }
}

class CustomWidget extends StatefulWidget {
  const CustomWidget({super.key});

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: Colors.black,
      ))),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      width: 300,
      child: Row(
        children: [
          Container(
            child: const Text(
              '12 Oct',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Officer Inspected'),
          ))
        ],
      ),
    );
  }
}
