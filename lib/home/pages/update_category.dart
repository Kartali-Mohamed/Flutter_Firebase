import 'package:firebase_app/home/widgets/custom_addbuttoncategory.dart';
import 'package:firebase_app/home/widgets/custom_addtextform.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCategory extends StatefulWidget {
  final String id;
  final String name;
  const UpdateCategory({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  /* ========= Business Logic ========= */
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  void updateCategory(String name) {
    if (formStateKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      categories.doc(widget.id).update({
        'name': name,
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Category updated.")));
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }).catchError((error) {
        isLoading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update user: $error")));
      });
    }
  }

  @override
  void initState() {
    nameController.text = widget.name;
    super.initState();
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Category"),
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
                        updateCategory(nameController.text);
                      },
                      type: 'Update',
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
