import 'package:ai_app/pages/mobileForOtp.dart';
import 'package:ai_app/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class ForOtp extends StatelessWidget {
  static const String _title = 'Geo tag App';
  final FirebaseAuth auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var code = "";
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text(_title),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/OTP.png',
                width: 250,
              ),
              // ImageFrameBuilder(),
              SizedBox(
                height: 30,
              ),
              Pinput(
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                // validator: (s) {
                //   return s == '2222' ? null : 'Pin is incorrect';
                // },
                // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                length: 6,
                showCursor: true,
                onChanged: (value) => {
                  code = value,
                },
                // onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Verify Phone Number'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
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
                    try {
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: MobileForOtp.verify,
                              smsCode: code);

                      // Sign the user in (or link) with the credential

                      await auth.signInWithCredential(credential);

                      Navigator.pushNamedAndRemoveUntil(
                          context, MyRoutes.signRoute, ((route) => false));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Wrong otp')),
                      );
                      // print("Wrong otp");
                      // print(e);
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => MobileForOtp())));
                  },
                ),
              ),
              Row(
                children: [
                  TextButton(
                      // onPressed: (){Navigator.popAndPushNamed(context, 'Mobile',)},
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black54),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
