import 'package:flutter/material.dart';

class FillDetailsScreen extends StatefulWidget {
  @override
  _FillDetailsScreenState createState() => _FillDetailsScreenState();
}

class _FillDetailsScreenState extends State<FillDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fill Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                onSaved: (value) => name = value!,
                validator: (value) => value!.isEmpty ? "Please enter your name" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                onSaved: (value) => email = value!,
                validator: (value) => value!.isEmpty ? "Please enter your email" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Address"),
                onSaved: (value) => address = value!,
                validator: (value) => value!.isEmpty ? "Please enter your address" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Navigate to the order review screen
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
