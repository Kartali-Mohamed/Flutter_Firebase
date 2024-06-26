import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/note/pages/add_note.dart';
import 'package:firebase_app/note/pages/update_note.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  final String docId;
  const ViewNote({Key? key, required this.docId}) : super(key: key);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  /* ========= Business Logic ========= */
  List<QueryDocumentSnapshot> listNotes = [];
  bool isLoading = true;

  void getNotes() async {
    CollectionReference notes = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.docId)
        .collection("notes");

    QuerySnapshot querySnapshot = await notes.get();
    listNotes.addAll(querySnapshot.docs);
    isLoading = false;
    setState(() {});
  }

  void deleteNoteById(String id, bool checkImage, String url) async {
    isLoading = true;
    setState(() {});

    CollectionReference notes = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.docId)
        .collection("notes");
    await notes.doc(id).delete();

    if (checkImage) {
      await FirebaseStorage.instance.refFromURL(url).delete();
    }

    if (!mounted) return;
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => ViewNote(docId: widget.docId)));
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  /* ========= Presentation ========= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNote(docId: widget.docId),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading == true
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: ListView.builder(
                itemCount: listNotes.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UpdateNote(
                            docId: widget.docId,
                            noteId: listNotes[index].id,
                            noteTitle: listNotes[index]["title"],
                            noteSubtitle: listNotes[index]["subtitle"]),
                      ),
                    );
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Delete Note"),
                              content: const Text("Are you sure?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    bool checkImage =
                                        listNotes[index]["url"] != "none"
                                            ? true
                                            : false;
                                    deleteNoteById(listNotes[index].id,
                                        checkImage, listNotes[index]["url"]);
                                  },
                                  child: const Text('Yes'),
                                )
                              ],
                            ));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ListTile(
                              title: Text(listNotes[index]["title"]),
                              subtitle: Text(listNotes[index]["subtitle"]),
                            ),
                          ),
                          if (listNotes[index]["url"] != "none")
                            Expanded(
                              flex: 1,
                              child: Image.network(
                                listNotes[index]["url"],
                                fit: BoxFit.cover,
                                height: 70,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
