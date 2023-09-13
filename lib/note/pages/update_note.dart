import 'package:firebase_app/note/pages/view_note.dart';
import 'package:firebase_app/note/widgets/custom_notebutton.dart';
import 'package:firebase_app/note/widgets/custom_notetextform.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateNote extends StatefulWidget {
  final String docId;
  final String noteId;
  final String noteTitle;
  final String noteSubtitle;
  const UpdateNote(
      {Key? key,
      required this.docId,
      required this.noteId,
      required this.noteTitle,
      required this.noteSubtitle})
      : super(key: key);

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  /* ========= Business Logic ========= */
  GlobalKey<FormState> formStateKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  bool isLoading = false;

  void updateNote(String title, String subtitle) {
    if (formStateKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      CollectionReference notes = FirebaseFirestore.instance
          .collection("categories")
          .doc(widget.docId)
          .collection("notes");

      notes.doc(widget.noteId).update({
        'title': title,
        'subtitle': subtitle,
      }).then((value) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Note updated.")));
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

  @override
  void initState() {
    titleController.text = widget.noteTitle;
    subtitleController.text = widget.noteSubtitle;
    super.initState();
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
        title: const Text("Update Note"),
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
                    CustomNoteButton(
                      onPressed: () {
                        updateNote(
                            titleController.text, subtitleController.text);
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
