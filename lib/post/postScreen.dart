// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
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

// real time db coding starts

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPostScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
