import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Center(
        child: Text("Account"),
      ),
    );
  }
}