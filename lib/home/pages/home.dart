import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/home/pages/update_category.dart';
import 'package:firebase_app/home/widgets/custom_alertdialog.dart';
import 'package:firebase_app/home/widgets/custom_homecardfolder.dart';
import 'package:firebase_app/note/pages/view_note.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* ========= Business Logic ========= */
  List<QueryDocumentSnapshot> listCategories = [];
  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");
  bool isLoading = true;

  void getCategories() async {
    try {
      listCategories.clear();
      QuerySnapshot querySnapshot = await categories
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      listCategories.addAll(querySnapshot.docs);
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void deleteCategoryById(String categoryId) async {
    try {
      isLoading = true;
      setState(() {});

      await categories.doc(categoryId).delete();

      getCategories();
    } catch (e) {
      isLoading = false;
      setState(() {});

      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void logout() {
    isLoading = true;
    setState(() {});

    // GoogleSignIn googleSignIn = GoogleSignIn();
    // googleSignIn.disconnect();

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
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          isLoading = true;
          setState(() {});

          getCategories();
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.orange,
                  ),
                )
              : listCategories.isEmpty
                  ? const Center(child: Text("No Categories"))
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 145,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5),
                      itemCount: listCategories.length,
                      itemBuilder: (context, index) {
                        return HomeCardFolder(
                          title: listCategories[index]['name'],
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ViewNote(docId: listCategories[index].id),
                            ));
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => CustomAlertDialog(
                                onDelete: () {
                                  Navigator.of(context).pop();
                                  deleteCategoryById(listCategories[index].id);
                                },
                                onUpdate: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UpdateCategory(
                                        id: listCategories[index].id,
                                        name: listCategories[index]['name']),
                                  ));
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
