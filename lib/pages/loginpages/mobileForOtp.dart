import 'package:ai_app/utils/routes.dart';
import 'package:ai_app/widgets/textFieldform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileForOtp extends StatefulWidget {
  MobileForOtp({super.key});

  static const String _title = 'Geo tag App';
  static String verify = "";
  static String mobileNo = "";

  @override
  State<MobileForOtp> createState() => _MobileForOtpState();
}

class _MobileForOtpState extends State<MobileForOtp> {
  TextEditingController numController = TextEditingController();

  TextEditingController countryCode = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MobileForOtp._title),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/OTP.png',
                  width: 250,
                  // height: double.infinity,
                  // width: double.infinity * .5,
                ),
                // ImageFrameBuilder(),
                const Text(
                  "Phone verification",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "We need to register your phone before getting started !",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryCode,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: numController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Mobile Number can't be empty";
                            } else if (value.length != 10) {
                              return "no number is access";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Phone"),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('Get your OTP'),
                    onPressed: () async {
                      if (numController.text.length != 10) {
                        numController.clear();
                      }

                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        /////////////////////////////////////////////////////////////////////////////////////////
                        // _user = User(
                        //   name: nameController.text,
                        //   phone: numController.text,
                        //   email: mailController.text,
                        //   password: passwordController.text,
                        // );
                        // print(_user);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, MyRoutes.otpRoute, (route) => false);
                        // Navigator.pushNamed(context, MyRoutes.otpRoute);
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber:
                              '${countryCode.text + numController.text}',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {
                            print(e);
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            MobileForOtp.mobileNo =
                                '${countryCode.text + numController.text}';
                            MobileForOtp.verify = verificationId;
                            Navigator.pushNamed(context, MyRoutes.otpRoute);
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => MobileForOtp())));
                      }
                    },
                  ),
                ),
                Row(
                  // ignore: sort_child_properties_last
                  children: <Widget>[
                    const Text('Already have account?'),
                    TextButton(
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.loginRoute);
                        })
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
