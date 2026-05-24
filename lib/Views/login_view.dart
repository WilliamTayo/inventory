import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email here',
                    ),
                  ),

                  TextField(
                    controller: _password,
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password here',
                    ),
                  ),

                  Center(
                    child: TextButton(
                      onPressed: () async {
                        final email = _email.text.trim();
                        final password = _password.text;

                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'invalid-credential') {
                            print('Invalid email or password');
                          } else if (e.code == 'invalid-email') {
                            print('Please enter a valid email');
                          } else if (e.code == 'user-disabled') {
                            print('This account has been disabled');
                          } else if (e.code == 'too-many-requests') {
                            print('Too many attempts. Try again later');
                          } else {
                            print('Login failed: ${e.code}');
                          }
                        }
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              );
            default:
              return const Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}
