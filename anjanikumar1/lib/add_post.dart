import 'package:anjanikumar1/round_button.dart';
import 'package:anjanikumar1/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,),

            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "What is in your mind?"
              ),
            ),
            SizedBox(
              height: 30,),

            RoundButton(
                title: 'Add',
                onTap: (){
                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                databaseRef.child(id).set({
                  'title' : postController.text.toString(),
                  'id' : id
                }).then((value){
                  Utils().toastMessage('Post added');
                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace){
                  Utils().toastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });
            },
                loading: loading)
          ],
        ),
      ),
    );
  }


}
