import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  void updateTokenFromFirebase() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({'notificationToken': token});
    }
  }

  @override
  void initState() {
    super.initState();
    CloudFirestoreClass().getNameAndEmail();
    updateTokenFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<UserDetailsProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: ColorManager.text,
            border: Border(
              top: BorderSide(color: Colors.grey[400]!, width: 1),
            ),
          ),
          child: TabBar(
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(color: ColorManager.activeCyanColor, width: 4),
              ),
            ),
            onTap: changePage,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              Tab(
                child: Icon(
                  Icons.home_outlined,
                  color: currentPage == 0
                      ? ColorManager.activeCyanColor
                      : ColorManager.primary,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.account_circle_outlined,
                  color: currentPage == 1
                      ? ColorManager.activeCyanColor
                      : ColorManager.primary,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: currentPage == 2
                      ? ColorManager.activeCyanColor
                      : ColorManager.primary,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.menu,
                  color: currentPage == 3
                      ? ColorManager.activeCyanColor
                      : ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
