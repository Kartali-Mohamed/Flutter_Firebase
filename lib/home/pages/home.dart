import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/home/widgets/custom_homecardfolder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* ========= Business Logic ========= */
  List<QueryDocumentSnapshot> listCategories = [];

  void getCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    listCategories.addAll(querySnapshot.docs);
    setState(() {});
  }

  void logout() {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                logout();
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.orange,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addcategory");
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 145,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
          itemCount: listCategories.length,
          itemBuilder: (context, index) {
            return HomeCardFolder(title: listCategories[index]['name']);
          },
        ),
      ),
    );
  }
}
