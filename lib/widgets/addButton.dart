import 'package:flutter/material.dart';
class AddButton extends StatelessWidget {
  final Function onTap;
  AddButton(this.onTap);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        width: 320,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
              colors: [Color(0xffF28080), Color(0xff7D1DFA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add New Product',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
