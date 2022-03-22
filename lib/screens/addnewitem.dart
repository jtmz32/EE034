

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ee034/model/user.dart';
import 'package:ee034/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem>{

  TextEditingController nameController = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController description = TextEditingController();
  



  final  database = FirebaseDatabase(databaseURL: "https://ee034-f79b9-default-rtdb.asia-southeast1.firebasedatabase.app/").reference();

  @override
  Widget build(BuildContext context){
    
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Add New Listing'),
            actions: const <Widget>[
            
           ]),
      body:Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: number,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Contact Details',
            ),
          ),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
            controller: description,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Description',
              contentPadding: EdgeInsets.only(bottom: 100.0),
            ),
          ),


          ElevatedButton(
            child: const Text('Upload'),
            onPressed: () async  {
              //await location.set({'Product Name': tutorsController.text});
              final tutors = database.child('Tutors').child(nameController.text);
              await tutors.set({'Contact Number': number.text,'Description': description.text,'Name':(nameController.text) });
            },
          ),
        ],
      ),
    );
  }
 
}


