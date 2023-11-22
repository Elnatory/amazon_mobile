import 'package:amazon_mobile/presentation/screens/account_view/account.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart.dart';
import 'package:amazon_mobile/presentation/screens/main_view/home_screen.dart';
import 'package:amazon_mobile/presentation/screens/more_view/more.dart';
import 'package:flutter/material.dart';

const String amazonLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";

const List<Widget> screens = [
  Home(),
  Account(),
  Cart(),
  More(),
];