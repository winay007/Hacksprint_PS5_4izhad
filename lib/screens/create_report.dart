import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:road_app/bottom_navigation_bar.dart';

import '../pickers/select_image.dart';
import '../widgets/custom_textfield.dart';

class CreatePost extends StatefulWidget {
  @override
  State<CreatePost> createState() => _CreatePostState();
}

enum Status { none, laoding, laoded }

class _CreatePostState extends State<CreatePost> {
  var _userImageFile;
  var isloading = false;
  String location = "Get Location ...";
  Status getLocation = Status.none;

  void _getUserLocation() async {
    getLocation = Status.laoding;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    print(position);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    setState(() {
      location =
          '${placemark.name}, ${placemark.thoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.postalCode}';
      getLocation = Status.laoded;
    });
  }

  void _submitForm(
      {required String title,
      required String description,
      required image,
      required String location,
      required String category,
      required BuildContext context}) async {
    try {
      if (title.isNotEmpty &&
          description.isNotEmpty &&
          category != ' ' &&
          location != 'Get Location ...' &&
          _userImageFile != null) {
        setState(() {
          isloading = true;
        });

        final _user = FirebaseAuth.instance.currentUser;

        final user = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user?.uid)
            .get();
        final author = user['username'];

        final ref = FirebaseStorage.instance
            .ref('report_images/${Timestamp.now().toString()}');

        await ref.putFile(image);

        final url = await ref.getDownloadURL();

        DateTime now = new DateTime.now();
        DateTime date = new DateTime(now.year, now.month, now.day);

        await FirebaseFirestore.instance.collection('reports').doc().set({
          'title': title,
          'content': description,
          'imageUrl': url,
          'publisher': author,
          'date': date.toString().substring(0, 10),
          'location': location,
          'category': category,
        });

        setState(() {
          isloading = false;
        });
        descController.text = "";
        titleController.text = "";
        location = "";
        dropDownValue = " ";
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Published successfully"),
            backgroundColor: Colors.green,
          ),
        );
        // Navigator.restorablePushReplacementNamed(
        //     context, NavigationFile.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Please fill up all the fields"),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  final titleController = TextEditingController();
  final descController = TextEditingController();
  var issues = [
    "speed breakers",
    "path hole",
    "water logging",
    "zebra crossing",
    "poor sidewalks",
    "road safety signs",
    "insufficient lighting",
    "non-availabilty of signals",
    "accident-prone areas",
    "others",
    " "
  ];
  String dropDownValue = " ";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_userImageFile != null) print('hey');
// There are no fields for Time and Author (current time will be pushed to db & current user displayname as authername)
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Report issues',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: size.height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          if (getLocation == Status.none)
                            IconButton(
                                onPressed: _getUserLocation,
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                )),
                          if (getLocation == Status.laoding)
                            const CircularProgressIndicator(),
                          if (getLocation == Status.laoded)
                            const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            width: getLocation == Status.none ||
                                    getLocation == Status.laoding
                                ? 100
                                : 280,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                child: Text(location),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Select the category",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          // width: 20,
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: DropdownButton(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                size: 20,
                              ),
                              underline: Container(
                                height: 2,
                                color: Colors.deepPurpleAccent, //<-- SEE HERE
                              ),
                              focusColor: Colors.black,
                              iconSize: 10,
                              value: dropDownValue,
                              items: issues.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                              }),
                        ),
                      ],
                    ),
                    SelectImage(
                      size: size,
                      imagePickFn: _pickedImage,
                    ),
                    SizedBox(height: size.height * 0.025),
                    const Text(
                      'Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height * 0.005),
                    CustomTextField(
                      hint: 'Enter Title',
                      controller: titleController,
                    ),
                    SizedBox(height: size.height * 0.03),
                    const Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.005),
                    CustomTextField(
                      hint: 'Enter Description',
                      controller: descController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Align(
                      child: Container(
                          width: size.width * 0.5,
                          height: size.height * 0.06,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 22, 18, 1))),
                              onPressed: () {
                                _submitForm(
                                  location: location,
                                  category: dropDownValue,
                                  title: titleController.text.trim(),
                                  description: descController.text.trim(),
                                  image: _userImageFile,
                                  context: context,
                                );
                              },
                              child: const Text('Report '))),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
