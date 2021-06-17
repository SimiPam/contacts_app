import 'package:flutter/material.dart';

class SubheadingWidget extends StatelessWidget {
  const SubheadingWidget({
    @required this.kFavText,
    this.kSeeAllText,
  });

  final String kFavText;
  final String kSeeAllText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            kFavText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          GestureDetector(
            onTap: () {
              print(kSeeAllText);
            },
            child: Text(
              kSeeAllText,
              style: TextStyle(
                // color: Theme.of(context).primaryColor,
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
