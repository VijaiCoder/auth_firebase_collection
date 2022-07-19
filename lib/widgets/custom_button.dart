import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback ontap;
  final String text;
  const CustomButton({Key? key, required this.ontap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.indigo,
            // border: Border.all(width: 3.0),
            borderRadius: BorderRadius.all(
                Radius.circular(5.0) //                 <--- border radius here
                ),
          ),
          height: 50,
          width: 150,
          child: Center(
              child: Text(
            text,
            style:const  TextStyle(color: Colors.white, fontSize: 25),
          )),
        ));
  }
}
