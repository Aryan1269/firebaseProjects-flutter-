// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:try2/firebase_services/delete%20User.dart';
import 'package:try2/post/add_posts.dart';
import 'package:try2/ui/loginPage.dart';
import 'package:try2/ui/signUp.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();

  Firebase_deleteUser accountDelete = Firebase_deleteUser();
  //for delete user
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()),
                );
              },
              icon: Icon(Icons.logout_rounded)),
          //second button
          IconButton(
              onPressed: () {
                accountDelete.deleteUser(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignUp()),
                  );
                });
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'search',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // ListBuilder(),
            Expanded(
              child: FirebaseAnimatedList(
                  //inbuilt function hai
                  query: ref,
                  defaultChild: Text('Loading'),
                  itemBuilder: (context, snapshot, animation, index) {
                    final title =
                        Text(snapshot.child('title').value.toString());

                    if (searchFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      );
                    } else if (title.data!
                        .toLowerCase()
                        .contains(searchFilter.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      );
                    }else {
                      return Container();
                    }
                  }),
            ),
            StreamBuilders(),
          ],
        ),
      ),
// real time db coding starts

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Expanded StreamBuilders() {
    return Expanded(
        child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                Map<dynamic, dynamic>? map =
                    snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;
                if (map == null) {
                  return const Text('No data available');
                } else {
                  List<dynamic> lists = map.values.toList();

                  return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(lists[index]['title'] ?? ''),
                        subtitle: Text(lists[index]['id'] ?? ''),
                      );
                    },
                  );
                }
              }
            }));
  }

  Expanded ListBuilder() {
    return Expanded(
      child: FirebaseAnimatedList(
          //inbuilt function hai
          query: ref,
          defaultChild: Text('Loading'),
          itemBuilder: (context, snapshot, animation, index) {
            final title = Text(snapshot.child('title').value.toString());
            if (searchFilter.text.isEmpty) {
              return ListTile(
                title: Text(snapshot.child('title').value.toString()),
                subtitle: Text(snapshot.child('id').value.toString()),
              );
            } else {
              return ListTile(
                title: Text(snapshot.child('title').value.toString()),
                subtitle: Text(snapshot.child('id').value.toString()),
              );
            }
          }),
    );
  }
}


// title: Text(snapshot.child('comments/title').value.toString()),