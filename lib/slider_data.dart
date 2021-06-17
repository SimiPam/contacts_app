import 'package:flutter/material.dart';

class SliderData {
  final String title;
  final String imageUrl;

  const SliderData({
    @required this.title,
    @required this.imageUrl,
  });
}

const List sliders = [
  SliderData(title: "Create", imageUrl: "assets/images/create.png"),
  SliderData(title: "Edit", imageUrl: "assets/images/edit.png"),
  SliderData(title: "View", imageUrl: "assets/images/view.png"),
];
