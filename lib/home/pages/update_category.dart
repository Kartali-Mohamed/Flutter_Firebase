import 'package:firebase_app/home/widgets/custom_addbuttoncategory.dart';
import 'package:firebase_app/home/widgets/custom_addtextform.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateCategory extends StatefulWidget {
  final String id;
  final String name;
  const UpdateCategory({super.key, required this.id, required this.name});

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  /* ========= Business Logic ========= */
  late GlobalKey<FormState> formStateKey;
  late TextEditingController nameController;
  bool isLoading = false;
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  @override
  void initState() {
    formStateKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    nameController.text = widget.name;
    super.initState();
  }

  void updateCategory(String name) {
    if (formStateKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});

      categories.doc(widget.id).update({
        'name': name,
      }).then((value) {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Category updated.")));

        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      }).catchError((error) {
        isLoading = false;
        setState(() {});

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to update user: $error")));
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
        title: const Text("Update Category"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.orange,
              ),
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
                    CustomButtonCategory(
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
