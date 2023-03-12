import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final loading;
  const RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.deepPurple,
        ),
        child: Center(
            child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.amber,):Text(
          title,
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
