import 'package:amazon_mobile/presentation/layout/screen_layout.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({super.key});

  @override
  _PhoneNumberFormState createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final TextEditingController phoneNumberController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.text,
      appBar: AppBar(
        title: const Text('Phone Number Verification',
            style: TextStyle(color: Colors.amber)),
        backgroundColor: ColorManager.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String phoneNumber = '+${phoneNumberController.text.trim()}';
                phone(phoneNumber);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
              ),
              child: const Text(
                'Verify Phone Number',
                style: TextStyle(color: ColorManager.text),
              ),
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
      backgroundColor: ColorManager.text,
      appBar: AppBar(
        title: const Text('Enter Verification Code', style: TextStyle(color: Colors.amber),),
        backgroundColor: ColorManager.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Verification Code',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String verificationCode = codeController.text.trim();
                verifyCode(verificationCode);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
              ),
              child: const Text('Verify Code')
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
            color: Colors.white,
          ),
        ),
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const ScreenLayout();
      }));
      // Get.off(() => MainNav());
    } catch (e) {
      print('Verification failed: $e');
    }
  }
}
