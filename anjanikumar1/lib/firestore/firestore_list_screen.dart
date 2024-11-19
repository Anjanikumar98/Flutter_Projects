import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../login_screen.dart';
import '../utils.dart';
import 'add_firestore_data.dart';

class FirestoreListScreen extends StatefulWidget {
  const FirestoreListScreen({super.key});

  @override
  State<FirestoreListScreen> createState() => _FirestoreListScreenState();
}

class _FirestoreListScreenState extends State<FirestoreListScreen> {
  final auth = FirebaseAuth.instance;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('Users').snapshots();

  CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('Users');

  @override
  void dispose() {
    // Clean up controllers
    searchFilter.dispose();
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Firestore'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data found'));
                }

                final filteredDocs = snapshot.data!.docs.where((doc) {
                  final title = doc['title'].toString().toLowerCase();
                  final searchQuery = searchFilter.text.toLowerCase();
                  return title.contains(searchQuery);
                }).toList();

                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    final doc = filteredDocs[index];
                    return ListTile(
                      onTap: () {
                        _showDeleteDialog(doc.id);
                      },
                      title: Text(doc['title'] ?? 'Untitled'),
                      subtitle: Text(doc.id),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(doc['title'], doc.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddFirestoreData()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Show a confirmation dialog before deleting a document
  Future<void> _showDeleteDialog(String docId) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Document'),
          content: const Text('Are you sure you want to delete this document?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteDocument(docId);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  /// Delete a document from Firestore
  void _deleteDocument(String docId) {
    usersCollection.doc(docId).delete().then((value) {
      Utils().toastMessage('Document deleted');
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  /// Show an edit dialog for updating the document
  Future<void> _showEditDialog(String title, String docId) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Document'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Enter new title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _updateDocument(docId);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  /// Update a document in Firestore
  void _updateDocument(String docId) {
    usersCollection.doc(docId).update({
      'title': editController.text,
    }).then((value) {
      Utils().toastMessage('Document updated');
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }
}
