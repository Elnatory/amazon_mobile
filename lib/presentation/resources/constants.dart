import 'package:amazon_mobile/presentation/screens/account_view/account.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart.dart';
import 'package:amazon_mobile/presentation/screens/main_view/home_screen.dart';
import 'package:amazon_mobile/presentation/screens/more_view/more.dart';
import 'package:flutter/material.dart';

const double AppBarHeight = 80;

const String amazonLogoUrl =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amazon_icon.svg/2500px-Amazon_icon.svg.png";

const String amazonLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";

final List<Widget> screens = [
  const Home(),
  const Account(),
  const Cart(),
  const More(),
];

const List<String> categoryLogos = [
  "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11CR97WoieL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11qyfRJvEbL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11BIyKooluL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
];
const List<String> categoryLogos2 = [
  "https://m.media-amazon.com/images/I/11ghJQiBgNL.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21iXZkUhaOL.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21kUMIMSA9L.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21dsJEJ7aEL.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21Lf5jjte+L.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21Db8i2tCvL.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21Kebn2pg-L.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21CGzZ49POL.SX100_SY100.png",
  "https://m.media-amazon.com/images/I/21PoCSsXK2L.SX100_SY100.png",
];

const List<String> largeAds = [
  "https://m.media-amazon.com/images/I/71c2lK80oeL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61aU1bpcm7L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61jmYNrfVoL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/711amgYyx3L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61fiSvze0eL._SX3000_.jpg",
  // "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg",
];

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];


List<String> keysOfRating = [
  "Very bad",
  "Poor",
  "Average",
  "Good",
  "Excellent"
];