import 'package:flutter/material.dart';
import 'package:tp0/decorators/custom_input_decorator.dart';

class SingupFormWidget extends StatefulWidget {
  const SingupFormWidget({super.key});

  @override
  State<SingupFormWidget> createState() => _SingupFormWidgetState();
}

class _SingupFormWidgetState extends State<SingupFormWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _username;
  String? _password;
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Form Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // key to track form state
          child: Column(
            children: [
              TextFormField(
                decoration: CustomInputDecoration.defaultStyle(label: "username", hint: "enter your username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
                onSaved: (value) => _username = value,
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.defaultStyle(label: "password", hint: "has to have atleast a digit and upper and lowercase"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (!RegExp(r'^(?=.*\d).+$').hasMatch(value)) {
                    return 'Must contain at least one number';
                  }

                  if (!RegExp(r'^(?=.*[A-Z]).+$').hasMatch(value)) {
                    return 'Must contain at least one uppercase letter';
                  }

                  if (!RegExp(r'^(?=.*[a-z]).+$').hasMatch(value)) {
                    return 'Must contain at least one lowercase letter';
                  }

                  if(value.length < 8){
                    return 'Must be atleast 8 carachters long';
                  }
                  return null;
                },
                onSaved: (value) => _password = value,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: 'Other',
                decoration: CustomInputDecoration.defaultStyle(label: 'Gender'),
                items: ['Other','Male', 'Female'].map((color) {
                  return DropdownMenuItem(value: color, child: Text(color));
                }).toList(),
                onChanged: (value) => _gender = value,
                validator: (value) => value == null ? 'Please select a gender' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Signup'),
                          content: Text('user: $_username with gender: $_gender Successfully added!!!'),
                          actions: [ 
                            TextButton(onPressed: ()
                            {
                              Navigator.pop(context);
                            }, child: const Text("OK")) 
                          ], 
                        );
                      }
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}