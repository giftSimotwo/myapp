import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/crud.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  final TextEditingController textcontroller = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();


  void openNoteBox({ String? docID }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textcontroller,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {

              if(docID == null) {
                firestoreService.addNote(textcontroller.text);  
              }
              else {
                firestoreService.updateNote(docID, textcontroller.text);
              }

              textcontroller.clear();
              Navigator.pop(context);
              
            },
            child: Text("Add", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15.0),),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: Text("Here are your notes"),
        centerTitle: true,
        backgroundColor: Colors.black87,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List noteslist = snapshot.data!.docs;
            return ListView.builder(
              itemCount: noteslist.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = noteslist[index];
                String docID = document.id;

                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                String notetext = data["note"];
                String notetext1 = data["timestamp"].toDate().toString();

                return ListTile(
                  title: Text(notetext, style: TextStyle(color: Colors.blueAccent, fontSize: 20.0),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                      onPressed: () => openNoteBox(docID: docID),
                      icon: Icon(Icons.settings, color: Colors.white,),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deleteNote(docID),
                        icon: Icon(Icons.delete, color: Colors.white,),
                      )
                    ],
                  ),
                  leading: Text(notetext1),
                );
              },
            );
          }
          else {
            return Text("There are no notes at the moment");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        hoverColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}