import 'package:contacts_app/constants/String.dart';
import 'package:contacts_app/db/model.dart';
import 'package:contacts_app/screens/contact_details.dart';
import 'package:contacts_app/widgets/subheading_widget.dart';
import 'package:flutter/material.dart';

class FavouritesCarousel extends StatelessWidget {
  FavouritesCarousel({this.contacts});
  final List<Contact> contacts;
  @override
  Widget build(BuildContext context) {
    Widget _widget;
    contacts == null
        ? _widget = Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SubheadingWidget(
                    kFavText: kFavText, kSeeAllText: kSeeAllText),
              ),
              // SizedBox(height: 5),
              Container(
                  height: 97,
                  // color: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    color: Colors.white60,
                    margin:
                        EdgeInsets.only(left: 0, right: 7, top: 10, bottom: 10),
                    width: 65,
                    // color: Colors.white,
                    child: Center(
                      child: Text("No favourite"),
                    ),
                  )),
            ],
          )
        : _widget = Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SubheadingWidget(
                    kFavText: kFavText, kSeeAllText: kSeeAllText),
              ),
              // SizedBox(height: 5),
              Container(
                height: 97,
                // color: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    Contact contact = contacts[index];
                    String firstNameInitial = contact.firstName.substring(0, 1);
                    String lastNameInitial = contact.lastName.substring(0, 1);

                    Widget _isFav;
                    contact.selected
                        ? _isFav = GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyDetailPage()),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: 0, right: 7, top: 10, bottom: 10),
                              width: 65,
                              // color: Colors.white,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                    bottom: 2,
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0,
                                            right: 10,
                                            top: 10,
                                            bottom: 3),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 60,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "$firstNameInitial . $lastNameInitial",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  letterSpacing: 1.2,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black54,
                                          offset: Offset(0, 2),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: Image(
                                            height: 55,
                                            width: 52,
                                            image: AssetImage(
                                                'assets/images/murano.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : _isFav = Container();
                    return _isFav;
                  },
                ),
              ),
            ],
          );
    return _widget;
  }
}
