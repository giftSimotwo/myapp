import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

class FirestoreService {

  final CollectionReference notes = FirebaseFirestore.instance.collection("Notes");

  Future<void> addNote(String note) {
    return notes.add({
      "note": note,
      "timestamp": Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotes() {
     final notesstream = notes.orderBy("timestamp", descending: true).snapshots();
     return notesstream;
  }

  Future<void> updateNote(String docID, String newnote) {
    return notes.doc(docID).update({
      "note": newnote,
      "timestamp": Timestamp.now(),
    });
  }

  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }

}