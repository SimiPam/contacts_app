import 'package:contacts_app/constants/sizes.dart';
import 'package:flutter/material.dart';

TextStyle heading1 = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);

Padding buttonWidget(
    {@required VoidCallback buttonAction,
    @required Color buttonColor,
    @required String buttonText}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: Sizes.dimens_16),
    child: Material(
      color: buttonColor,
      borderRadius: BorderRadius.all(Radius.circular(Sizes.dimens_11)),
      elevation: Sizes.dimens_4,
      child: MaterialButton(
        onPressed: buttonAction,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

final kTitleStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  height: 1.2,
);
