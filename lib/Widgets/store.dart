import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../Screens/welcome_screen.dart';

class Storage extends StatelessWidget {
  final FirebaseUser user;
  final String purpose;
  final String frmTime;
  final String toTime;
  final GlobalKey<FormState> formKey;
  final BuildContext cxt;
  final String gender;
  final String selection;
  final Function validate;
  Map<String,String> bioData;

  Storage({
    this.user,
    this.formKey,
    this.cxt,
    this.frmTime,
    this.toTime,
    this.purpose,
    this.gender,
    this.validate,
    this.selection,
    this.bioData
  });



  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: _finaliseSignUp,
      child: new Text('Next'),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
    );
  }

  void _finaliseSignUp() {
    if (formKey.currentState.validate() && gender != null) {
      print('\n\n\n\n...in progress...');
      bioData['gender'] = gender;
      bioData['selection'] = selection;
      bioData['fromTime'] = frmTime;
      bioData['toTime'] = toTime;
      bioData['purpose Of Visit'] = purpose;
      bioData['uid'] = user.uid.toString();
      print(bioData);
      formKey.currentState.save();
      createRecord();
      Navigator.of(cxt).pushNamed(WelcomeScreen.routeName, arguments: bioData);
    } else {
      if (gender == null && formKey.currentState.validate()) {
        Toast.show("Please mark your gender", cxt,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    }
  }

  void createRecord() {
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child('/Bookings/${user.uid}').set(bioData);
  }
}
