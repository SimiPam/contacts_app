import 'dart:io';
import 'dart:typed_data';
import 'package:contacts_app/constants/sizes.dart';
import 'package:contacts_app/constants/themes.dart';
import 'package:contacts_app/widgets/bottomsheet.dart';
import 'package:contacts_app/widgets/gender_widget.dart';
import 'package:contacts_app/widgets/reusable_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:html';
import '../db/db.dart';
import '../db/model.dart';
//import 'package:image_picker/image_picker.dart';

class AddEditContact extends StatefulWidget {
  const AddEditContact({this.addContact, this.contact, this.updateContact});
  final Function addContact;
  final Function updateContact;
  final Contact contact;

  @override
  _AddEditContactState createState() => _AddEditContactState();
}

class _AddEditContactState extends State<AddEditContact> {
  int _malevalue = 0;
  int _femvalue = 0;

  bool _filled = false;
  bool _selected = false;

  int radFemVal = 1;
  int radMaleVal = 2;

  String male = 'Male';
  String female = 'Female';

  // void onChanges {
  //
  // }

  // TextEditingController _firstName = TextEditingController();
  // TextEditingController _lastName = TextEditingController();
  // TextEditingController _phone = TextEditingController();
  // TextEditingController _email = TextEditingController();
  // TextEditingController _address = TextEditingController();

  // @override
  // void dispose() {
  //   DatabaseService.instance.close();
  //   super.dispose();
  // }

  File imageFile;
  final picker = ImagePicker();
  String imagePath;
  String errorMsg = "";

  removeImage() {
    setState(() {
      imageAdded = false;
      imagePath = null;
      imageFile = null;
    });
  }

  chooseImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        imagePath = pickedFile.path;
      } else {
        imagePath = null;
      }
      imageAdded = true;
    });
    // print(imageFile);
  }

  String _gender;
  String _firstName;
  String _lastName;
  String _phone;
  String _email;
  String _address;
  // String imagePath;
  bool imageAdded = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.contact != null) {
      _firstName = widget.contact.firstName ?? "";
      _lastName = widget.contact.lastName ?? "";
      _phone = widget.contact.phone ?? "";
      _email = widget.contact.email ?? "";
      _address = widget.contact.address ?? "";
      _gender = widget.contact.gender ?? "";
      imagePath = widget.contact.image ?? null;

      imagePath == null ? imageAdded = false : imageAdded = true;

      setState(() {
        if (_gender == female) {
          _femvalue = 1;
        } else if (_gender == male) {
          _malevalue = 1;
        } else {
          _malevalue = 0;
          _femvalue = 0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  splashColor: Colors.grey,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios_outlined),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Stack(
                  children: [
                    widget.contact != null
                        ? imagePath != null
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage: FileImage(File(imagePath)),
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
                              )
                        : imageFile != null
                            ? CircleAvatar(
                                radius: 80,
                                backgroundImage: FileImage(imageFile),
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
                    Positioned(
                      top: 0.0,
                      right: 0.0,
                      child: InkWell(
                        onTap: () {
                          imageAdded
                              ? removeImage()
                              : showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet(
                                        imageFunction: () {
                                          chooseImage(ImageSource.camera);
                                        },
                                        galleryFunction: () {
                                          chooseImage(ImageSource.gallery);
                                        },
                                      )),
                                );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.white, width: 3),
                            color: imageAdded ? Colors.red : Colors.teal,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              imageAdded
                                  ? Icons.remove_circle_outline
                                  : Icons.camera_alt,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GenderWidget(
                        radVal: radMaleVal,
                        value: _malevalue,
                        gender: male,
                        onChange: (value) {
                          setState(() {
                            _malevalue = value;
                            _gender = male;
                          });
                        },
                      ),
                      GenderWidget(
                        radVal: radFemVal,
                        value: _femvalue,
                        gender: female,
                        onChange: (value) {
                          setState(() {
                            _femvalue = value;
                            _gender = female;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: ReusableTextField(
                          textController: _firstName,
                          label: 'Firstname',
                          icon: Icon(
                            Icons.person,
                            color: Colors.black54,
                          ),
                          onChange: (val) {
                            if (val.isNotEmpty) {
                              setState(() {
                                _filled = true;
                                _firstName = val;
                              });
                            }
                          },
                          filled: _filled,
                        ),
                      ),
                      Flexible(
                        child: ReusableTextField(
                          textController: _lastName,
                          label: 'Lastname',
                          icon: Icon(
                            Icons.person,
                            color: Colors.black54,
                          ),
                          onChange: (val) {
                            if (val.isNotEmpty) {
                              setState(() {
                                _filled = true;
                                _lastName = val;
                              });
                            }
                          },
                          filled: _filled,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ReusableTextField(
                    textController: _phone,
                    label: 'Phone',
                    icon: Icon(
                      Icons.phone,
                      color: Colors.black54,
                    ),
                    onChange: (val) {
                      if (val.isNotEmpty) {
                        setState(() {
                          _filled = true;
                          _phone = val;
                        });
                      }
                    },
                    filled: _filled,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ReusableTextField(
                    textController: _email,
                    label: 'Email Address',
                    icon: Icon(
                      Icons.email,
                      color: Colors.black54,
                    ),
                    onChange: (val) {
                      setState(() {
                        _filled = true;
                        if (val.isNotEmpty) {
                          _email = val;
                        } else {
                          _email = "";
                        }
                      });
                    },
                    filled: _filled,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ReusableTextField(
                    textController: _address,
                    label: 'Address',
                    icon: Icon(
                      Icons.home,
                      color: Colors.black54,
                    ),
                    onChange: (val) {
                      setState(() {
                        _filled = true;
                        if (val.isNotEmpty) {
                          _address = val;
                        } else {
                          _address = "";
                        }
                      });
                    },
                    filled: _filled,
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Center(
                    child: Text(
                      errorMsg,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Sizes.dimens_16),
                      child: Material(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.all(Radius.circular(Sizes.dimens_11)),
                        elevation: Sizes.dimens_4,
                        child: MaterialButton(
                          onPressed: () async {
                            // widget.addContact(
                            //   _firstName.text,
                            //   _lastName.text,
                            //   _phone.text,
                            //   _email.text,
                            //   _address.text,
                            //   _gender,
                            // );
                            if (_firstName.isNotEmpty &&
                                _lastName.isNotEmpty &&
                                _phone.isNotEmpty &&
                                _gender.isNotEmpty) {
                              final isUpdating = widget.contact != null;
                              if (isUpdating) {
                                final updatedTask = widget.contact.copyWith(
                                  firstName: _firstName,
                                  lastName: _lastName,
                                  phone: _phone,
                                  email: _email,
                                  address: _address,
                                  image: imagePath,
                                  gender: _gender,
                                  selected: _selected,
                                );

                                widget.updateContact(
                                    updatedTask, widget.contact);

                                await DatabaseService.instance
                                    .update(updatedTask);
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => TasksScreen()),
                                // );
                              } else {
                                widget.addContact(
                                  _firstName,
                                  _lastName,
                                  _phone,
                                  _email,
                                  _address,
                                  _gender,
                                  _selected,
                                  imagePath,
                                );
                                final contact = Contact(
                                  firstName: _firstName,
                                  lastName: _lastName,
                                  phone: _phone,
                                  email: _email,
                                  address: _address,
                                  image: imagePath,
                                  gender: _gender,
                                  selected: _selected,
                                );

                                await DatabaseService.instance.insert(contact);
                              }
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                errorMsg =
                                    "All fields required EXCEPT address and email ";
                              });
                            }
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
