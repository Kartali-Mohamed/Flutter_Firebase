import 'dart:io';
import 'package:firebase_app/note/pages/view_note.dart';
import 'package:firebase_app/note/widgets/custom_notebutton.dart';
import 'package:firebase_app/note/widgets/custom_noteimagebutton.dart';
import 'package:firebase_app/note/widgets/custom_notetextform.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  final String docId;
  const AddNote({Key? key, required this.docId}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  /* ========= Business Logic ========= */
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  bool isLoading = false;
  File? file;
  String? url;

  void addNote(String title, String subtitle, BuildContext context) {
    if (formStateKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      CollectionReference notes = FirebaseFirestore.instance
          .collection("categories")
          .doc(widget.docId)
          .collection("notes");

      notes.add({
        'title': title,
        'subtitle': subtitle,
        'url': url ?? "none",
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Note added.")));
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ViewNote(docId: widget.docId)));
      }).catchError((error) {
        isLoading = false;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to add user: $error")));
      });
    }
  }

  void addImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.camera);

    if (imagePicked != null) {
      file = File(imagePicked.path);
      var imageName = basename(imagePicked.path);
      var refStorge = FirebaseStorage.instance.ref("images").child(imageName);
      await refStorge.putFile(file!);
      url = await refStorge.getDownloadURL();
    }

    setState(() {});
  }

  @override
  void dispose() {
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
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
                    CustomNoteTextForm(
                        hinttext: "Enter title",
                        mycontroller: titleController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your title";
                          }
                          return null;
                        }),
                    const SizedBox(height: 10),
                    CustomNoteTextForm(
                        hinttext: "Enter subtitle",
                        mycontroller: subtitleController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "please enter your subtitle";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    CustomNoteImageButton(
                        onPressed: () {
                          addImage();
                        },
                        isSelected: url == null ? false : true),
                    const SizedBox(height: 10),
                    CustomNoteButton(
                      onPressed: () {
                        addNote(titleController.text, subtitleController.text,
                            context);
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
