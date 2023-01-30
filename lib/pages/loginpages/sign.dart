// import 'package:ai_app/models/user.dart';
import 'package:ai_app/utils/routes.dart';
import 'package:ai_app/widgets/textFieldform.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/users.dart';
import 'login.dart';
import 'package:flutter/material.dart';

import 'mobileForOtp.dart';

class Signup extends StatefulWidget {
  static const String _title = 'Geo tag App';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  var _passwordVisible = false;
  var _conPasswordVisible = false;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /////////////////////////////////////////////////////////////////////////////
    Users _user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(Signup._title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                // Container(
                //   alignment: Alignment.center,
                //   padding: const EdgeInsets.all(10),
                //   child: const Text(
                //     'Geo-Tag',
                //     style: TextStyle(
                //       color: Colors.blue,
                //       // color: Theme.of(context).colorScheme.primary,
                //       fontWeight: FontWeight.w500,
                //       fontSize: 30,
                //     ),
                //   ),
                // ),
                Image.asset(
                  'assets/images/Sign_up.png',
                  width: 300,
                  // height: double.infinity,
                  // width: double.infinity * .5,
                ),
                const Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFiledform(
                  controller: nameController,
                  labelText: 'User Name',
                  hintText: "",
                  keyType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username can't be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFiledform(
                  controller: mailController,
                  labelText: 'E-mail',
                  hintText: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email can't be empty";
                    }
                    return null;
                  },
                  keyType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: !_passwordVisible,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password can't be empty";
                    } else if (value.length < 8) {
                      return "Password is too short";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    // Here is key idea
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),

                  // decoration: const InputDecoration(
                  //   border: OutlineInputBorder(),
                  //   labelText: 'Password',
                  // ),
                ),
                SizedBox(
                  height: 20,
                ),
                // TextFormField(
                //   obscureText: !_conPasswordVisible,
                //   controller: confpasswordController,
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Password can't be empty";
                //     } else if (value != passwordController.text) {
                //       return "Password is not same";
                //     }
                //     return null;
                //   },
                //   // decoration: const InputDecoration(
                //   //   border: OutlineInputBorder(),
                //   //   labelText: 'Confirm Password',
                //   // ),
                //   decoration: InputDecoration(
                //     labelText: 'Confirm Password',
                //     hintText: 'Enter your confirm password',
                //     // Here is key idea
                //     suffixIcon: IconButton(
                //       icon: Icon(
                //         // Based on passwordVisible state choose the icon
                //         _conPasswordVisible
                //             ? Icons.visibility
                //             : Icons.visibility_off,
                //       ),
                //       onPressed: () {
                //         // Update the state i.e. toogle the state of passwordVisible variable
                //         setState(() {
                //           _conPasswordVisible = !_conPasswordVisible;
                //         });
                //       },
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Register'),
                    onPressed: () async {
                      if (passwordController.text !=
                          confpasswordController.text) {
                        confpasswordController.clear();
                        // return;
                      }

                      if (_formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: mailController.text,
                            password: passwordController.text,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'The password provided is too weak.')),
                            );
                            // print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'The account already exists for that email.')),
                            );
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }

                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        /////////////////////////////////////////////////////////////////////////////////////////
                        _user = Users(
                          name: nameController.text,
                          phone: MobileForOtp.mobileNo,
                          email: mailController.text,
                          password: passwordController.text,
                        );
                        // print(_user);

                        /////////////////////////
                        ///add to fire base
                        /////////////////////////
                        final docRef = db
                            .collection("users")
                            .withConverter(
                              fromFirestore: Users.fromFirestore,
                              toFirestore: (Users city, options) =>
                                  city.toFirestore(),
                            )
                            .doc();
                        await docRef.set(_user);

                        /////////////////////////
                        ///Loading ui
                        /////////////////////////

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                        /////////////////////////
                        ///navigate new page
                        /////////////////////////

                        Navigator.pushNamed(context, MyRoutes.loginRoute);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
