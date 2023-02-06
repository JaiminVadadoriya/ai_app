import 'package:ai_app/widgets/user_map.dart';
import 'package:ai_app/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static const String _title = 'Geo tag App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(_title)),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController mailController = TextEditingController();

  var _passwordVisible = false;
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  // _checkIn() {
  //   // print(nameController.text);
  //   // print(passwordController.text);
  //   if (_formKey.currentState!.validate()) {
  //     Navigator.push(
  //         context, MaterialPageRoute(builder: ((context) => MyMap())));
  //   }
  //   if (mailController.text.length != 10) {
  //     mailController.clear();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: ListView(
          children: <Widget>[
            // Container(
            //   alignment: Alignment.center,
            //   padding: const EdgeInsets.all(10),
            //   child: const Text(
            //     'Geo-Tag',
            //     style: TextStyle(
            //         color: Colors.blue,
            //         fontWeight: FontWeight.w500,
            //         fontSize: 30),
            //   ),
            // ),
            Image.asset(
              'assets/images/login.png',
              width: 200,
              // height: double.infinity,
              // width: double.infinity * .5,
            ),
            const Text(
              'Log in',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: mailController,
              decoration: InputDecoration(
                labelText: 'E-mail',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email can't be empty";
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
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
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text(
                    'Forgot Password ?',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  //  print(nameController.text);
                  // print(passwordController.text);
                  if (_formKey.currentState!.validate()) {
                    try {
                      //loading circle
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );

                      // checking Email AND Password
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: mailController.text,
                              password: passwordController.text);

                      //pop the loading
                      Navigator.of(context).pop();

                      // send to new page
                      Navigator.pushNamedAndRemoveUntil(
                          context, MyRoutes.homeRoute, ((route) => false));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No user found for that email.'),
                          ),
                        );
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Wrong password provided for that user.'),
                          ),
                        );
                      }
                    }
                  }
                },
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //signup screen

                    Navigator.pushNamed(context, MyRoutes.mobileRoute);
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
