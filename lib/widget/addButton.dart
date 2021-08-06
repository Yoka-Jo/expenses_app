import 'package:flutter/material.dart';
import 'dart:ui' as ui;
class AddButton extends StatelessWidget {
  final Function onTap;
  AddButton(this.onTap);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Container(
          height: 58,
          width: 320,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
              gradient: LinearGradient(
                colors: [Color(0xffF28080), Color(0xff7D1DFA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Add New Product',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 50,),
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff37779A), Color(0xff46DFC9)]),
                    shape: BoxShape.circle),
                height: 45,
                width: 45,
                child: FittedBox(
                  child: FloatingActionButton(
                    child: ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return ui.Gradient.linear(
                          Offset(10, 24.0),
                          Offset(28.0, 4.0),
                          [
                            Color(0xffF28080), Color(0xff7D1DFA)
                          ].map((e) => e.withOpacity(1)).toList(),
                        );
                      },
                      child: Icon(
                        Icons.add,
                        size: 35,
                      ),
                    ),
                    onPressed: () {},
                    backgroundColor: Color(0xff7D1DFA),
                  ),
                ),
              ),
              SizedBox(width: 8,),
            ],
          ),
        ),
      ),
    );
  }
}
