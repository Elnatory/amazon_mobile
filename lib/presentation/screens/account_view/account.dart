import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final CloudFirestoreClass cloudFirestore = CloudFirestoreClass();

  CloudFirestoreClass getCloudFirestore() {
    return cloudFirestore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorManager.backgroundColor,
        elevation: 0,
        title: const Text(
          'Account',
          style: TextStyle(
            color: ColorManager.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
