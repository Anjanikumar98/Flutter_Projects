import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:anjanikumar1/round_button.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  final picker = ImagePicker();

  // Firebase Storage instance
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  /// Pick an image from the gallery
  Future<void> getImageGallery() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No image selected!'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
        ),
      );
    }
  }

  /// Upload image to Firebase Storage
  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      // Folder name in Firebase Storage
      String folderName = 'user_images';

      // Create a unique file name inside the folder
      String fileName =
          '$folderName/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Reference to Firebase Storage
      firebase_storage.Reference ref = storage.ref().child(fileName);

      // Upload file
      firebase_storage.UploadTask uploadTask = ref.putFile(_image!);

      // Wait for the upload to complete
      await uploadTask;

      // Get the download URL of the uploaded file
      String downloadUrl = await ref.getDownloadURL();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image uploaded successfully! URL: $downloadUrl'),
        ),
      );
    } catch (e) {
      debugPrint('Error uploading image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading image: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Image'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: getImageGallery,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          RoundButton(
            title: 'Upload',
            onTap: () {
              if (_image != null) {
                _uploadImage();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select an image first!'),
                  ),
                );
              }
            },
            loading: false,
          ),
        ],
      ),
    );
  }
}
