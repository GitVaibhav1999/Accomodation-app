import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui/utils.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:typemyletter/Widgets/store.dart';


class ProfileEditScreen extends StatefulWidget {
  final FirebaseUser user;

  ProfileEditScreen({this.user});

  @override
  ProfileEditScreenState createState() => ProfileEditScreenState();
}

class ProfileEditScreenState extends State<ProfileEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Map<String, String> _bioData = {
    'uid': '',
    'name': '',
    'email': '',
    'gender': '',
    'selection':'',
    'purpose Of Visit': '',
    'fromTime': 'hello',
    'toTime': '',
  };

  final _purposeOfVisitController = TextEditingController();
  final _fromTimeController = TextEditingController();
  final _toTimeController = TextEditingController();

  bool genderMale = false;
  bool genderFemale = false;
  bool genderOthers = false;
  
  bool _autoValidate = false;

  bool berth_u = false;
  bool berth_l = false;
  bool berth_m = false;

  String gender;
  String selection;

  void dispose() {
    _fromTimeController.dispose();
    _toTimeController.dispose();
    _purposeOfVisitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('Enter Details'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          FlatButton(
            child: Text("Logout"),
            textColor: Colors.white,
            onPressed: signOutProviders,
          )
        ],
      ),
      body: new SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 150,
                  color: Theme.of(context).accentColor.withOpacity(0.6),
                ),
                new Container(
                  margin: new EdgeInsets.all(15.0),
                  child: new Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: formUI(),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 80,
              left: (MediaQuery.of(context).size.width - 150) * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image.network(
                    widget.user.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Here is our Form UI
  Widget formUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 75),
      child: new Column(
        children: <Widget>[
          new TextFormField(
            initialValue: widget.user.displayName,
            decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                )),
            keyboardType: TextInputType.text,
            validator: validateName,
            onSaved: (String val) {
              _bioData['name'] = val;
            },
          ),
          SizedBox(
            height: 20,
          ),
          new TextFormField(
            initialValue: widget.user.email,
            decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                )),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            onSaved: (String val) {
              _bioData['email'] = val;
            },
          ),
          SizedBox(height: 25),
          Column(
            children: <Widget>[
           
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('male'),
                  Checkbox(
                    value: genderMale,
                    onChanged: (newVal) {
                      setState(() {
                        genderMale = newVal;
                        genderFemale = false;
                        genderOthers = false;
                        gender = newVal ? 'male' : null;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('female'),
                  Checkbox(
                    value: genderFemale,
                    onChanged: (newVal) {
                      setState(() {
                        genderMale = false;
                        genderFemale = newVal;
                        genderOthers = false;
                        gender = newVal ? 'female' : null;
                        // print(gender);
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('others'),
                  Checkbox(
                    value: genderOthers,
                    onChanged: (newVal) {
                      setState(() {
                        genderOthers = newVal;
                        genderFemale = false;
                        genderMale = false;
                        gender = newVal ? 'others' : null;
                        print(gender);
                      });
                    },
                  ),
                ],
              ),
            ],
          )
            ],
          ),
          
          
          new SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: FormBuilderDateTimePicker(
              controller: _fromTimeController,
              initialValue: DateTime.now(),
              attribute: 'FromTime',
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.arrow_downward),
                labelText: 'Want to Accomodate from',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: FormBuilderDateTimePicker(
              controller: _toTimeController,
              initialValue: DateTime.now(),
              attribute: 'ToTime',
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.arrow_downward),
                labelText: 'Want to Accomodate till',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 30),
            child: TextFormField(
              controller: _purposeOfVisitController,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) => value.length < 10 ? 'Bio too short.' : null,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              maxLines: 2,
              autocorrect: true,
              decoration: InputDecoration(
                hintText: 'Why do you want an accomodation',
                alignLabelWithHint: false,
                labelText: 'Purpose Of Visit And berth Selection',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Upper'),
                  Checkbox(
                    value: berth_u,
                    onChanged: (newVal) {
                      setState(() {
                        berth_u = newVal;
                        berth_l = false;
                        berth_m = false;
                        selection  = newVal ? 'berth_u' : null;
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Middle'),
                  Checkbox(
                    value: berth_m,
                    onChanged: (newVal) {
                      setState(() {
                          berth_u = false;
                        berth_l = false;
                        berth_m = newVal;
                        selection = newVal ? 'berth_m' : null;
                         print(selection);
                      });
                    },
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Lower'),
                  Checkbox(
                    value: berth_l,
                    onChanged: (newVal) {
                      setState(() {
                        berth_u = false;
                        berth_l = newVal;
                        berth_m = false;
                        selection = newVal ? 'berth_l' : null;
                        print(selection);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Storage(
              user: widget.user,
              cxt: context,
              toTime: _toTimeController.text,
              bioData: _bioData,
              formKey: _formKey,
              frmTime: _fromTimeController.text,
              purpose: _purposeOfVisitController.text,
              gender: gender,
              selection: selection,
              validate: () {
                  setState(() {
                    _autoValidate = true;
                  });
                }),
        ],
      ),
    );
  }

  String validateName(String value) {
    if (value.length < 3)
      return 'Name must be more than 2 charater';
    else
      return null;
  }

  String validateMobile(String value) {
    // Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  autoValid() {}
}
