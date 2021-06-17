import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final String img;
  final String overlayText;

  const SliderWidget({@required this.img, @required this.overlayText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 7, right: 7),
      width: double.infinity,
      // height: double.infinity,
      // height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: AssetImage(img),
                  height: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 10,
              child: Text(
                overlayText,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
