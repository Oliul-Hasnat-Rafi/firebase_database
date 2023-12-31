import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_flutter/login.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final postController = TextEditingController();
  final topicController = TextEditingController();
  final updatepostController = TextEditingController();
  final updatetopicController = TextEditingController();
  final storage = FirebaseStorage.instance;
  final databaseref = FirebaseDatabase.instance.ref('Posts');
  File? _path;
  final picker = ImagePicker();
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  bool validateInput() {
    if (postController.text.isEmpty || topicController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Future getImageGallery() async {
    final imagepath = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (imagepath != null) {
        _path = File(imagepath.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Database'),
        actions: [
          GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyLogin())));
              },
              child: Icon(Icons.logout_rounded))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bottomsheet(context);
        },
        child: Icon(Icons.add_box_outlined),
        backgroundColor: Colors.greenAccent.shade400,
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Text('Loading'),
              query: databaseref,
              itemBuilder:
                  (context, snapshot, Animation<double> animation, int index) {
                final itemKey = snapshot.key;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(snapshot.child('topic').value.toString()),
                      subtitle: Text(snapshot.child('title').value.toString()),
                      trailing: Container(
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                updatedata(context, snapshot, itemKey!);
                              },
                              child: Icon(Icons.edit_document),
                            ),
                            GestureDetector(
                              onTap: () {
                                databaseref
                                    .child(itemKey.toString())
                                    .remove()
                                    .then((value) => print('Deleted'))
                                    .catchError(
                                        (error) => print(error.toString()));
                              },
                              child: Icon(Icons.delete_forever_sharp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _bottomsheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 150,
                  width: 150,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: _path != null
                      ? Image.file(_path!.absolute)
                      : Center(child: Icon(Icons.image)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: topicController,
                  decoration: InputDecoration(
                      hintText: 'Topic?', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 4,
                  controller: postController,
                  decoration: InputDecoration(
                      hintText: "What's on your mind?",
                      border: OutlineInputBorder()),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (validateInput()) {
                      pushtofirebase();
                    } else {
                      print("somethink want wrong");
                    }
                    SnackBar(content: Text('Upload to firebase'));
                  },
                  child: Text('Save'))
            ],
          ),
        );
      },
    );
  }

  void pushtofirebase() async {
    Reference reference = storage
        .ref('/rafi/' + DateTime.now().microsecondsSinceEpoch.toString());

    final TaskSnapshot snapshot = await reference.putFile(_path!.absolute);

    Future.value(snapshot).then((value) async {
      var downloadUrl = await snapshot.ref.getDownloadURL();
      print("image: " + downloadUrl);
      databaseref.child(id).set({
        'topic': topicController.text.toString(),
        'title': postController.text.toString(),
        'url': downloadUrl.toString(),
      });
    });

    topicController.clear;
    postController.clear;
    Navigator.pop(context);
  }

  void updatedata(
      BuildContext context, DataSnapshot snapshot, String itemKey) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: updatetopicController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: updatepostController,
                  decoration: const InputDecoration(),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      databaseref.child(itemKey).update({
                        'topic': updatetopicController.text.toString(),
                        'title': updatepostController.text.toString(),
                      });

                      Navigator.pop(context);
                    },
                    child: const Text("Update")),
              ],
            ),
          );
        });
  }
}
