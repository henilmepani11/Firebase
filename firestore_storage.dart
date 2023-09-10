import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
// import 'package:path/path.dart';
import 'package:week11/storage/new_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyScreen());
}

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: FireStoreStorage(),
    );
  }
}

class FireStoreStorage extends StatefulWidget {
  const FireStoreStorage({Key? key}) : super(key: key);

  @override
  State<FireStoreStorage> createState() => _FireStoreStorageState();
}

class _FireStoreStorageState extends State<FireStoreStorage> {
  late File file;
  File? profilePic;
  var url;

  uploadImage() async {
    XFile? imagePicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      file = File(imagePicked.path);

      var nameImage = basename(imagePicked.path);
      var refStorage = FirebaseStorage.instance.ref(nameImage);
      await refStorage.putFile(file);

      profilePic = file;
      setState(() {});
      url = await refStorage.getDownloadURL();
    } else {
      print('Please choose Image');
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firestore Storage"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  uploadImage();
                },
                child: Center(
                  child: CircleAvatar(
                    backgroundImage:
                        (profilePic != null) ? FileImage(profilePic!) : null,
                    radius: 45,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(hintText: "password"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                  onPressed: () {
                    final doc =
                        FirebaseFirestore.instance.collection("users").doc();

                    final user = StorageModel(
                      name: nameController.text,
                      id: doc.id,
                      password: passwordController.text,
                      url: url,
                      time: DateTime.now().toString(),
                    );

                    doc.set(user.toJson());
                    nameController.clear();
                    passwordController.clear();
                    profilePic = null;
                    setState(() {});
                    Get.to(() => const NewScreen());
                  },
                  child: const Text("Submit")),
            )
          ],
        ),
      ),
    );
  }
}

class StorageModel {
  String? name;
  String? password;
  String? url;
  String? id;
  String? time;

  StorageModel({this.name, this.password, this.url, this.id, this.time});

  factory StorageModel.fromJson(Map<dynamic, dynamic> json) {
    return StorageModel(
      name: json['name'],
      password: json['password'],
      url: json['url'],
      id: json['id'],
      time: json['time'],
    );
  }

  toJson() {
    return {
      "name": name,
      "password": password,
      "url": url,
      "id": id,
      "time": time,
    };
  }
}
