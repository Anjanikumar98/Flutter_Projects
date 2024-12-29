import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  String gender = '';
  String country = '';
  String state = '';
  String city = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty || !RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value) ? 'Please enter a valid email' : null,
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) => value!.isEmpty ? 'Please enter your gender' : null,
                onChanged: (value) => gender = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) => value!.isEmpty ? 'Please enter your country' : null,
                onChanged: (value) => country = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) => value!.isEmpty ? 'Please enter your state' : null,
                onChanged: (value) => state = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) => value!.isEmpty ? 'Please enter your city' : null,
                onChanged: (value) => city = value,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle the data submission
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
