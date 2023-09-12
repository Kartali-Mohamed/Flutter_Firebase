import 'package:firebase_app/home/widgets/custom_addbuttonfolder.dart';
import 'package:firebase_app/home/widgets/custom_addtextform.dart';
import 'package:flutter/material.dart';

class AddFolder extends StatefulWidget {
  const AddFolder({Key? key}) : super(key: key);

  @override
  State<AddFolder> createState() => _AddFolderState();
}

class _AddFolderState extends State<AddFolder> {
  /* ========= Business Logic ========= */
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Folder"),
      ),
      body: Form(
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
              CustomAddButtonFolder(onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
