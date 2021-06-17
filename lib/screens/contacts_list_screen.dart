import 'package:contacts_app/widgets/contacts_widget.dart';
import 'package:contacts_app/widgets/favourites_carousel.dart';
import 'package:contacts_app/widgets/search_widget.dart';
import 'package:contacts_app/widgets/subheading_widget.dart';
import 'package:flutter/material.dart';

import '../constants/String.dart';
import '../db/db.dart';
import '../db/model.dart';
import 'add_edit_screen.dart';

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  TextEditingController searchController = new TextEditingController();
  List<Contact> _contacts;

  Future<void> _getContacts() async {
    final contacts = await DatabaseService.instance.getAllContacts();
    if (mounted) {
      setState(() => _contacts = contacts);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(
          Icons.person_add_outlined,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditContact(
                addContact: (addFirstName, addLastName, addPhone, addEmail,
                    addAddress, addGender, addSelected, imagePath) async {
                  // final contact = Contact(
                  //   firstName: addFirstName,
                  //   lastName: addLastName,
                  //   phone: addPhone,
                  //   email: addEmail,
                  //   address: addAddress,
                  //   gender: addGender,
                  //   selected: addSelected,
                  // );
                  // await DatabaseService.instance.insert(contact);

                  setState(() {
                    _contacts.add(
                      Contact(
                          firstName: addFirstName,
                          lastName: addLastName,
                          phone: addPhone,
                          email: addEmail,
                          address: addAddress,
                          gender: addGender,
                          selected: addSelected,
                          image: imagePath),
                    );
                  });
                },
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Contacts",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            // SearchWidget(searchController: searchController),
            // SizedBox(height: 10),
            // FavouritesCarousel(
            //   contacts: _contacts,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   child: SubheadingWidget(kFavText: kContactText, kSeeAllText: ""),
            // ),
            ContactsWidget(
              contacts: _contacts,
              refresh: () async {
                await _getContacts();
              },
              // isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
