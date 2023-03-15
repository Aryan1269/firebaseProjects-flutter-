import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:try2/ui/roundButton.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Whats on your mind',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
              title: 'Add',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });
                //to give unique id we date and time
                databaseRef
                    .child(DateTime.now().millisecondsSinceEpoch.toString()
                    //can add another child
                    ).set({
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                  'title': postController.text,
                }).then((value) {
                  //then and onError is used instead of try catch , await asycro
                  setState(() {
                    loading = false; // set loading to false on success
                  });
                  //to the textfield call clear method
                  postController.clear();
                  print("successful");
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false; // set loading to false on error
                  });
                  print("error");
                });
              },
            )
          ],
        ),
      ),
    );
  }
}


                    // after).child('comments')//like this
