import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ee034/model/user.dart';
import 'package:ee034/screens/addnewitem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ee034/screens/login_screen.dart';

var lists = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final database = FirebaseDatabase(
          databaseURL:
              "https://ee034-f79b9-default-rtdb.asia-southeast1.firebasedatabase.app/")
      .reference()
      .child('Tutors');
  UserModel loggedInUser = UserModel();


  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Modules Listings"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(children: [
              Container(
                  height: 500,
                  decoration: BoxDecoration(
                      border: Border.all(
                       // color: Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: StreamBuilder(
              stream: database.onValue,
              builder: (context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData && !snapshot.hasError &&
                    snapshot.data!.snapshot.value != null) {
                  print("Error on the way");
                  lists.clear();
                  DataSnapshot dataValues = snapshot.data!.snapshot;
                  Map<dynamic, dynamic> values = dataValues.value;
                  values.forEach((key, values) {
                    lists.add(values);
                  });
                  return  ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                             Text("Name: " + lists[index]["Name"].toString()),
                            Text("Contact number: " + lists[index]["Contact Number"].toString()),
                            Text("Description: " + lists[index]["Description"].toString()),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Container(child: Text("Add Items"));
              },
            ),),
              Container(
                height: 100,
                child: ElevatedButton(
                  child: const Text(
                    'Add Listing',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const AddItem()),
                          ),
              
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(100, 150),
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              )
            ])));
  }

  Widget box(String name, Color backgroundcolor) {
    return Container(
        margin: EdgeInsets.all(3),
        width: 330,
        color: Colors.blueGrey,
        child: Column(children: [
          ElevatedButton(child: Text(name), onPressed: () {}),
        ]));
  }
}
