import 'dart:io';

import 'package:contacts_app/db/db.dart';
import 'package:contacts_app/screens/contact_details.dart';
import 'package:flutter/material.dart';

import '../db/model.dart';

class ContactsWidget extends StatefulWidget {
  ContactsWidget({this.contacts, this.refresh});
  final List<Contact> contacts;
  final Function refresh;
  @override
  _ContactsWidgetState createState() => _ContactsWidgetState();
}

class _ContactsWidgetState extends State<ContactsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.refresh;
    // _getContacts();
    // widget.contacts.sort();
  }

  // List<Contact> _contacts;
  //
  // Future<void> _getContacts() async {
  //   final contacts = await DatabaseService.instance.getAllContacts();
  //   if (mounted) {
  //     setState(() => _contacts = contacts);
  //   }
  // }

  // final bool isLoading;
  @override
  Widget build(BuildContext context) {
    Widget _widget;
    widget.contacts == null
        ? _widget =
            Expanded(flex: 5, child: Center(child: CircularProgressIndicator()))
        : _widget =
            // return
            Expanded(
            flex: 5,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10, bottom: 15),
              itemCount: widget.contacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact = widget.contacts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyDetailPage(
                          contacts: contact,
                          updatedContact: (newContact, oldContact) {
                            setState(() {
                              // widget.contacts.insert(index, newContact);
                              widget.contacts.removeAt(index);
                              widget.contacts.add(newContact);
                              // widget.refresh;
                              // widget.contacts.sort();
                            });
                          },
                          onDelete: () {
                            setState(() {
                              widget.contacts.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
                        // margin: EdgeInsets.fromLTRB(20, 2, 20, 2),
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 20),

// height: 170,
                        padding:
                            EdgeInsets.symmetric(vertical: 9, horizontal: 35),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          // color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          // padding:  EdgeInsets.fromLTRB(20, 10, 20, 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      '${contact.firstName} ${contact.lastName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 9,
                        // bottom: 5,
                        left: 23,
                        // Align(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: contact.image != null
                              ? Image(
                                  height: 45,
                                  width: 45,
                                  image: FileImage(File(contact.image)),
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Theme.of(context).accentColor,
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        // alignment: Alignment.centerLeft,
                        // ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
    return _widget;
  }
}
