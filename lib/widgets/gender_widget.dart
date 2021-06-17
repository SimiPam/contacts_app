import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    Key key,
    @required this.radVal,
    @required int value,
    @required this.gender,
    this.onChange,
  })  : _value = value,
        super(key: key);

  final int radVal;
  final int _value;
  final String gender;
  final Function(int) onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(width: 1, color: Colors.grey),
        ),
        child: Row(
          children: [
            Radio(
              splashRadius: 3.0,
              activeColor: Colors.teal,
              value: radVal,
              groupValue: _value,
              onChanged: onChange,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              gender,
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
