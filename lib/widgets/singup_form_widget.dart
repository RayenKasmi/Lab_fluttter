import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tp0/decorators/custom_input_decorator.dart';
import 'package:tp0/models/user.dart';
import 'package:tp0/screens/user_service.dart';

class SingupFormWidget extends StatefulWidget {
  final UserService userService = UserService();
  SingupFormWidget({super.key});

  @override
  State<SingupFormWidget> createState() => _SingupFormWidgetState();
}

class _SingupFormWidgetState extends State<SingupFormWidget> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String? _gender = 'Other';
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _loadUser();
  }

  @override
  void dispose() {
    User newUser = User(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      gender: _gender,
    );

    widget.userService.clearCurrentUser();
    widget.userService.saveCurrentUser(newUser);

    super.dispose();
  }

  Future<void> _loadUser() async {
    User u = await widget.userService.getCurrentUser();

    _usernameController.text = u.username ?? "";
    _emailController.text = u.email ?? "";
    _gender = u.gender ?? "Other";

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Form Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: CustomInputDecoration.defaultStyle(
                    label: "username", hint: "enter your username"),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Please enter your username' : null,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                decoration: CustomInputDecoration.defaultStyle(
                    label: "email", hint: "enter your email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Email is required";
                  if (!EmailValidator.validate(value)) return "Invalid Email";
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: CustomInputDecoration.defaultStyle(
                    label: "password",
                    hint: "at least one digit, one upper, one lower"),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a password';
                  if (!RegExp(r'^(?=.*\d)').hasMatch(value)) return 'Must contain a number';
                  if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) return 'Must contain uppercase';
                  if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) return 'Must contain lowercase';
                  if (value.length < 8) return 'Must be at least 8 characters';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                initialValue: _gender,
                decoration: CustomInputDecoration.defaultStyle(label: 'Gender'),
                items: ['Other', 'Male', 'Female']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a gender' : null,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    User newUser = User(
                      username: _usernameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      gender: _gender,
                    );

                    await widget.userService.clearCurrentUser();
                    await widget.userService.saveCurrentUser(newUser);

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Signup'),
                        content: Text(
                            'User: ${newUser.username} with gender: ${newUser.gender} saved successfully.'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"))
                        ],
                      ),
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
