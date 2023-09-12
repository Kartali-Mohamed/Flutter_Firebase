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
  void logout() {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
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
          Navigator.of(context).pushNamed("addfolder");
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 145,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            children: const [
              HomeCardFolder(title: "Company"),
              HomeCardFolder(title: "Home"),
              HomeCardFolder(title: "Company"),
              HomeCardFolder(title: "Home"),
              HomeCardFolder(title: "Company"),
              HomeCardFolder(title: "Home"),
              HomeCardFolder(title: "Company"),
              HomeCardFolder(title: "Home"),
              HomeCardFolder(title: "Company"),
              HomeCardFolder(title: "Home"),
              HomeCardFolder(title: "Company"),
              HomeCardFolder(title: "Home"),
            ]),
      ),
    );
  }
}
