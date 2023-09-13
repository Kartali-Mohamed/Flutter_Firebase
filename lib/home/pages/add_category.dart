import 'package:firebase_app/home/widgets/custom_addbuttoncategory.dart';
import 'package:firebase_app/home/widgets/custom_addtextform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  /* ========= Business Logic ========= */
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  void addCategory(String name) {
    if (formStateKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      categories.add({
        'id': FirebaseAuth.instance.currentUser!.uid,
        'name': name,
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Category added.")));
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }).catchError((error) {
        isLoading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to add user: $error")));
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formStateKey,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomAddTextForm(
                        hinttext: "Enter name",
                        mycontroller: nameController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your email";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    CustomAddButtonCategory(
                      onPressed: () {
                        addCategory(nameController.text);
                      },
                      type: 'Add',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
