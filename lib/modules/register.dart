import 'package:crt_stand/models/endUser.dart';
import 'package:crt_stand/modules/Login.dart';
import 'package:crt_stand/modules/home_page.dart';
import 'package:crt_stand/sevices/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AuthServices _authServices = AuthServices();

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  var _formRegisterKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var _nameController = TextEditingController();

  _submit() {
    if (_formRegisterKey.currentState!.validate()) {
      _formRegisterKey.currentState!.save();
      // Perform authentication or data storage logic here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formRegisterKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
              TextFormField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
              ),
              SizedBox(height: 40.0,),
              Container(
                width: double.infinity,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    EndUser newUser = EndUser(
                      uId: 'uid',
                      name: _nameController.text.trim(),
                      phoneNumber: _phoneNumberController.text.trim(),
                      email: _emailController.text.trim(),
                    );

                    if (_emailController.text.trim().contains('@') &&
                        _nameController.text.trim().isNotEmpty &&
                        _emailController.text.trim().isNotEmpty &&
                        _phoneNumberController.text
                            .trim()
                            .isNotEmpty &&
                        _passwordController.text.trim().isNotEmpty &&
                        _passwordController.text ==
                            _confirmPasswordController.text) {
                      dynamic creds =
                      await _authServices.registerUser(
                        newUser,
                        _passwordController.text.trim(),
                      );
                      if (creds == null) {
                        const snackbar = SnackBar(
                            content: Text("Email/Password invalid!"));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackbar);
                      } else {
                        Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                                builder: (context) =>
                                const HomeScreen(),),);
                      }
                    }
                  },
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Log In',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
