import 'package:amazon_mobile/presentation/screens/auth_view/phone.dart';
import 'package:amazon_mobile/presentation/widgets/main_button.dart';
import 'package:amazon_mobile/presentation/widgets/text_field_widget.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/screens/main_view/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:amazon_mobile/presentation/screens/auth_view/reg_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var auth = FirebaseAuth.instance;
  // final box = GetStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var Muhammad_Omar = GlobalKey<FormState>();
  // AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isLoading = false;
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool _validateForm() {
    if (Muhammad_Omar.currentState!.validate()) {
      return true;
    } else {
      setState(() {});
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      key: Muhammad_Omar,
      backgroundColor: ColorManager.text,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.10,
                  ),
                  Container(
                    height: screenSize.height * 0.6,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign-In",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 33),
                        ),
                        TextFieldWidget(
                          title: "Email",
                          controller: emailController,
                          obscureText: false,
                          hintText: "Enter your email",
                        ),
                        TextFieldWidget(
                          title: "Password",
                          controller: passwordController,
                          obscureText: true,
                          hintText: "Enter your password",
                        ),
                        // =========================Start SignIn with Email and Password=================
                        Align(
                          alignment: Alignment.center,
                          child: CustomMainButton(
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  letterSpacing: 0.6,
                                  color: ColorManager.primary),
                            ),
                            color: ColorManager.yellowColor,
                            isLoading: isLoading,
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwordController.text);
                                if (auth.currentUser!.uid != null) {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Main();
                                  }));
                                  // box.write('uid', auth.currentUser!.uid);
                                  // Get.snackbar(
                                  //   'Welcome',
                                  //   'Muhammad Omar',
                                  //   titleText: const Text(
                                  //     'Welcome',
                                  //     style: TextStyle(
                                  //       fontSize: 20,
                                  //       fontWeight: FontWeight.bold,
                                  //       color: Colors.white,
                                  //     ),
                                  //   ),
                                  //   messageText: const Text(
                                  //     'Muhammad Omar',
                                  //     style: TextStyle(
                                  //       fontSize: 18,
                                  //       color: Colors.black,
                                  //     ),
                                  //   ),
                                  // );
                                  // Get.to(MainNav());
                                  print(auth.currentUser!.uid);
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            },
                          ),
                        ),
                        // =========================End SignIn with Email and Password=======================
                        // =========================Start SignIn with Google=======================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () async {
                                try {
                                  GoogleAuthProvider _google =
                                      GoogleAuthProvider();
                                  await auth.signInWithProvider(_google);

                                  if (auth.currentUser != null) {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const Main();
                                    }));
                                    // box.write('uid', auth.currentUser!.uid);

                                    // Get.snackbar(
                                    //   'Welcome',
                                    //   'Muhammad Omar',
                                    //   titleText: const Text(
                                    //     'Welcome',
                                    //     style: TextStyle(
                                    //       fontSize: 20,
                                    //       fontWeight: FontWeight.bold,
                                    //       color: Colors.white,
                                    //     ),
                                    //   ),
                                    //   messageText: const Text(
                                    //     'Muhammad Omar',
                                    //     style: TextStyle(
                                    //       fontSize: 18,
                                    //       color: Colors.black,
                                    //     ),
                                    //   ),
                                    // );

                                    // Get.to(const MainNav());
                                    print(auth.currentUser!.uid);
                                  }
                                } catch (e) {
                                  print('Error during sign-in: $e');
                                }
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                onSurface: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Image.network(
                                      'https://th.bing.com/th/id/R.0dd54f853a1bffb0e9979f8146268af3?rik=qTQlRtQRV5AliQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2fgoogle-logo-png-google-logo-icon-png-transparent-background-1000.png&ehk=VlcCHZ7jyV%2fCI7dZfbUl8Qb9%2f7uibkF6I6MBoqTtpRU%3d&risl=&pid=ImgRaw&r=0',
                                      height: 40,
                                      width: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // =========================End SignIn with Google=======================
                            // =========================Start SignIn with Phone=======================
                            TextButton(
                              onPressed: () {
                                // Get.to(PhoneNumberForm());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhoneNumberForm()),
                                );
                              },
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                onSurface: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Image.network(
                                      'https://www.logolynx.com/images/logolynx/a4/a4e27546bcb59c94da3f86d3b96ed515.png',
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // =========================End SignIn with Phone=======================
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "new to amazon?",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CustomMainButton(
                      child: const Text(
                        "Create an Amazon Account",
                        style: TextStyle(
                          letterSpacing: 0.6,
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.grey[400]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const Registeration();
                        }));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
