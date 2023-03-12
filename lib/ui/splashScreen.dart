import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../firebase_services/isLogin.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {

  firebase_login FireLogin = firebase_login();
  @override
  void initState() {
    // TODO: implement initState
    FireLogin.isLogin(context);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Firebase")),
    );
    
  }
}