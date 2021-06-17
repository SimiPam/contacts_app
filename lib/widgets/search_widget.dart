import 'package:flutter/material.dart';

import '../constants/sizes.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key key,
    @required this.searchController,
  }) : super(key: key);

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: Sizes.dimens_20,
        right: Sizes.dimens_20,
        // bottom: Sizes.dimens_10,
      ),
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        // color: AppColors.descriptionColor,
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: new BorderRadius.circular(18.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 40,
        ),
        child: TextFormField(
          // controller: descController,
          // onChanged: (desc) {},

          cursorColor: Theme.of(context).primaryColor,
          maxLines: null,

          decoration: InputDecoration(
            fillColor: Colors.white70,
            filled: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: Sizes.dimens_10, horizontal: Sizes.dimens_20),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).scaffoldBackgroundColor,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimens_11)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1,
                  color: Theme.of(context).primaryColor.withOpacity(0.2)),
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimens_11)),
            ),
            hintText: 'Search',
            prefixIcon: Icon(
              Icons.search,
            ),
          ),
        ),
      ),
    );
    // );
  }
}
