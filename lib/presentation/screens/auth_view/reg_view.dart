import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/widgets/main_button.dart';
import 'package:amazon_mobile/presentation/widgets/text_field_widget.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/screens/auth_view/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class Registeration extends StatefulWidget {
  const Registeration({super.key});


  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();
  var auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var Muhammad_Omar = GlobalKey<FormState>();
  bool isLoading = false;
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
                          "Sign-Up",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 33),
                        ),
                        TextFieldWidget(
                          title: "Name",
                          controller: nameController,
                          obscureText: false,
                          hintText: "Enter your name",
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
                        Align(
                          alignment: Alignment.center,
                          child: CustomMainButton(
                              color: ColorManager.yellowColor,
                              isLoading: isLoading,
                              onPressed: () async {
                                try {
                                  var user =
                                      await auth.createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text);
                                  print("reg success");
                                  await CloudFirestoreClass()
                                      .uploadNameAndEmailToDatabase(
                                    name: nameController.text,
                                    email: emailController.text,
                                  );
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const Login();
                                  }));
                                  // Get.to(Login());
                                  Get.snackbar(
                                    'You have registered',
                                    'Successfully',
                                    titleText: const Text(
                                      'You have registered',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    messageText: const Text(
                                      'You have registered',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'weak-password') {
                                    print('The password provided is too weak.');
                                  } else if (e.code == 'email-already-in-use') {
                                    print(
                                        'The account already exists for that email.');
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    letterSpacing: 0.6,
                                    color: ColorManager.primary),
                              )),
                        )
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
                          "already in amazon?",
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
                      color: Colors.grey[400]!,
                      isLoading: false,
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return const Login();
                        }));
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                          letterSpacing: 0.6,
                          color: Colors.black,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
