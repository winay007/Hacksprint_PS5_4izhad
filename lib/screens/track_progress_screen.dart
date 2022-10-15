import 'package:flutter/material.dart';

class TrackProgress extends StatefulWidget {
  const TrackProgress({super.key});

  static const String routeName = '/track_progress';
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      border: Border.all(
                        width: 8,
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
          ),
          Container(
              height: 200,
              decoration: const BoxDecoration(
                border:  Border(
                  left: BorderSide(
                    color: Colors.black12,
                    width: 8,
                  ),
                ),
              ),
              child: ListView.builder(
                itemBuilder: ((context, index) {
                  return CustomWidget();
                }),
                itemCount: 10,
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
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      width: 300,
      child: Row(
        children: [
          Container(
            child: Text('12 Oct'),
          ),
          Expanded(child: Container(child: Text('Officer Inspected'),))
        ],
      ),
    );
  }
}
