import 'package:amazon_mobile/presentation/screens/main_view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class PhoneNumberForm extends StatefulWidget {
  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Number Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String phoneNumber = '+${phoneNumberController.text.trim()}';
                phone(phoneNumber);
              },
              child: Text('Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }

  void phone(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        print("Verification completed with credential: $credential");
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        print("Verification code sent to $phoneNumber");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EnterCodeScreen(
              phoneNumber: phoneNumber,
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Verification code auto-retrieval timed out");
      },
    );
  }
}

class EnterCodeScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const EnterCodeScreen({
    required this.phoneNumber,
    required this.verificationId,
    Key? key,
  }) : super(key: key);

  @override
  _EnterCodeScreenState createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Verification Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String verificationCode = codeController.text.trim();
                verifyCode(verificationCode);
              },
              child: Text('Verify Code'),
            ),
          ],
        ),
      ),
    );
  }

  void verifyCode(String verificationCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: verificationCode,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      print('Verification successful');

      Get.snackbar(
        'Welcome',
        'Muhammad Omar',
        titleText: const Text(
          'Welcome',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        messageText: const Text(
          'Muhammad Omar',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const Home();
      }));
      // Get.off(() => MainNav());
    } catch (e) {
      print('Verification failed: $e');
    }
  }
}
