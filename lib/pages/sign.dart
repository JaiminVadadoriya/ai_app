import 'package:ai_app/models/user.dart';

import 'login.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  static const String _title = 'Geo tag App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final _formKey = GlobalKey<FormState>();
  var _passwordVisible = false;
  var _conPasswordVisible = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User _user;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Geo-Tag',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username can't be empty";
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: numController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Mobile Number can't be empty";
                  } else if (value.length != 10) {
                    return "no number is access";
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mobile Number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: mailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email can't be empty";
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextFormField(
                obscureText: !_passwordVisible,
                controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password can't be empty";
                  } else if (value.length < 8) {
                    return "Password is too short";
                  }
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
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: TextFormField(
                obscureText: !_conPasswordVisible,
                controller: confpasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password can't be empty";
                  } else if (value != passwordController.text) {
                    return "Password is not same";
                  }
                },
                // decoration: const InputDecoration(
                //   border: OutlineInputBorder(),
                //   labelText: 'Confirm Password',
                // ),
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Enter your confirm password',
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _conPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _conPasswordVisible = !_conPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () {
                    if (numController.text.length != 10) {
                      numController.clear();
                      return;
                    }

                    if (passwordController.text !=
                        confpasswordController.text) {
                      confpasswordController.clear();
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      _user = User(
                        name: nameController.text,
                        phone: numController.text,
                        email: mailController.text,
                        password: passwordController.text,
                      );
                      print(_user);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: ((context) => Login())));
                    }
                  },
                )),
            Row(
              // ignore: sort_child_properties_last
              children: <Widget>[
                const Text('Already have account?'),
                TextButton(
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //log screen

                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Login())));
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
