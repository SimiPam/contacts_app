import 'package:contacts_app/constants/sizes.dart';
import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  ReusableTextField(
      {@required this.label,
      this.icon,
      this.onChange,
      @required this.filled,
      @required this.textController});
  final label;
  final icon;
  final Function(String) onChange;
  final bool filled;
  // final TextEditingController textController;
  final String textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(
      //   left: Sizes.dimens_10,
      //   right: Sizes.dimens_10,
      //   // bottom: Sizes.dimens_10,
      // ),
      padding: EdgeInsets.only(
        left: Sizes.dimens_10,
        right: Sizes.dimens_10,
        // bottom: Sizes.dimens_10,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 60,
        ),
        child: TextFormField(
            // controller: textController,
            maxLines: null,
            initialValue: textController,
            onChanged: onChange,
            decoration: InputDecoration(
                fillColor: filled ? Colors.white60 : Colors.transparent,
                filled: true,
                prefixIcon: icon,
                focusColor: Colors.teal,
                labelText: label,
                labelStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(11.0),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.0),
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      width: 2,
                      color: Theme.of(context).accentColor,
                    )),
                contentPadding: EdgeInsets.all(10))),
      ),
    );
  }
}
