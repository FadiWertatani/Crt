import 'package:crt_stand/modules/home_page.dart';
import 'package:crt_stand/modules/register.dart';
import 'package:crt_stand/sevices/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthServices _authServices = AuthServices();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        if (_emailController.text.trim().isEmpty ||
                            _passwordController.text.isEmpty) {
                          const snackbar = SnackBar(
                              content: Text(
                                  "Email/Password cannot be empty!"));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(snackbar);
                        } else {
                          dynamic creds = await _authServices.loginUser(
                              _emailController.text,
                              _passwordController.text);
                          if (creds == null) {
                            const snackbar = SnackBar(
                                content: Text("Email/Password invalid!"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackbar);
                          } else {
                            Navigator.pushReplacement(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        }
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(onPressed: (){
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => RegistrationScreen(),
              ),
            );
          }, child: Text(
            'Dont have an account?',
          ),)
        ],
      ),
    );
  }
}
