import 'dart:io';
import 'dart:typed_data';

import 'package:contacts_app/constants/themes.dart';
import 'package:contacts_app/db/db.dart';
import 'package:contacts_app/widgets/subheading_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../db/model.dart';
import 'add_edit_screen.dart';

class MyDetailPage extends StatefulWidget {
  MyDetailPage({this.contacts, this.updatedContact, this.onDelete});
  final Contact contacts;
  final Function updatedContact;
  final Function onDelete;

  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  Future _makeCall(String numm) async {
    String numm = widget.contacts.phone;
    // launch(widget.contacts.phone);
    await UrlLauncher.canLaunch(numm)
        ? await UrlLauncher.launch("tel://$numm")
        : throw 'Could not launch $numm';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xFFF3F5F7),
        floatingActionButton: FloatingActionButton(
            elevation: 14,
            backgroundColor: Colors.black,
            foregroundColor: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            tooltip: 'Edit Todo',
            child: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditContact(
                    contact: widget.contacts,
                    updateContact: (newContact, delectContact) {
                      widget.updatedContact(newContact, delectContact);
                    },
                  ),
                ),
              );
            }),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    splashColor: Colors.grey,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  Align(
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 25.0,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        DatabaseService.instance.delete(widget.contacts.id);
                        widget.onDelete();
                        // widget.contact;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          // Colors.pink,
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                        child: widget.contacts.image != null
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage:
                                    FileImage(File(widget.contacts.image)),
                                backgroundColor: Theme.of(context).accentColor,
                              )
                            : CircleAvatar(
                                radius: 80,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 130,
                                ),
                                backgroundColor: Theme.of(context).accentColor,
                              ),
                      ),
                      SizedBox(height: 15),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.contacts.firstName,
                              style: heading1,
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  widget.contacts.toggleSelected();
                                });
                                Contact updatedContact =
                                    widget.contacts.copyWith();

                                await DatabaseService.instance
                                    .update(updatedContact);
                              },
                              child: Icon(
                                widget.contacts.selected
                                    ? Icons.star
                                    : Icons.star_outline,
                                // check ? Icons.star: Icons.star_outline,
                                color: Color(0XFFF7B81B),
                                size: 30,
                              ),
                            )
                          ]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              Expanded(
                child: Container(
                  // margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),

// height: 170,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    // color: Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Phone',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(widget.contacts.phone, style: heading1),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              // _makeCall(widget.contacts.phone);
                              //FOR PHONE NUMBER:
                              final Uri _phoneLaunchUri = Uri(
                                  scheme: 'tel', path: widget.contacts.phone);
                              _makeCall(_phoneLaunchUri.toString());
                            },
                            child: Icon(
                              Icons.phone,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: 260,
                            child: Text(
                              widget.contacts.email,
                              style: heading1,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.mail,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      // SizedBox(height: 15),
                      Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.contacts.gender,
                            style: heading1,
                          ),
                          Spacer(),
                          Icon(
                            Icons.person,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Address',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            width: 260,
                            child: Text(
                              widget.contacts.address,
                              style: heading1,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.location_on,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     width: 100.0,
              //     child: ElevatedButton(
              //       onPressed: () {
              //         DatabaseService.instance.delete(widget.contacts.id);
              //         widget.onDelete();
              //         // widget.contact;
              //         Navigator.pop(context);
              //       },
              //       style: ElevatedButton.styleFrom(
              //         minimumSize: const Size.fromHeight(45.0),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(15.0),
              //         ),
              //       ),
              //       child: const Text(
              //         'Delete',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 16.0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 60,
              ),
              // Spacer(),
            ],
          ),
        ),
      );
}
