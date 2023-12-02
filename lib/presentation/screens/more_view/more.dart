import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/screens/account_view/account.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart.dart';
import 'package:amazon_mobile/presentation/screens/checkout_view/checkout_screen.dart';
import 'package:amazon_mobile/presentation/screens/favourite_view/fav.dart';
import 'package:amazon_mobile/presentation/screens/order_view/order_screen.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({Key? key}) : super(key: key);

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: SearchBarWidget(
        hasBackButton: false,
        isReadOnly: true,
        onChanged: (String value) {},
        query: '',
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: lightBackgroundaGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'More Page',
                style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return MoreBox(index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MoreBox extends StatelessWidget {
  final int index;

  MoreBox({required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavScreen()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderScreen()));
            break;
          case 3:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
            break;
          case 4:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Checkout()));
            break;
          case 5:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart())); // Duplicate case
            break;
          case 6:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Cart())); // Duplicate case
            break;
          // Add more cases for other boxes
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(getBackgroundImage(index)),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              getTitle(index),
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getTitle(int index) {
    switch (index) {
      case 0:
        return 'Wishlist';
      case 1:
        return '';
      case 2:
        return 'Orders';
      case 3:
        return '';
      case 4:
        return '';
      case 5:
        return ''; 
      case 6:
        return 'Screen 6';
      default:
        return 'Box';
    }
  }




  String getBackgroundImage(int index) {
    // Provide the image path based on the index or use a default image
    switch (index) {
      case 0:
        return 'https://th.bing.com/th/id/R.ee1c102376ae44f667ac2d0b5abd2766?rik=VKY702tPviE45w&riu=http%3a%2f%2fpic.downcc.com%2fupload%2f2017-1%2f20171111513321252.png&ehk=3uO6oolAZYUe8KbrjPq3yehJUm4iM4CN21oRH7Zk0jE%3d&risl=&pid=ImgRaw&r=0';
      case 1:
        return 'https://th.bing.com/th/id/OIP.Vpf8MQSq8-YJtStw-06VcgHaHa?w=197&h=197&c=7&r=0&o=5&dpr=1.3&pid=1.7';
      case 2:
        return 'https://www.retailgazette.co.uk/wp-content/uploads/Amazons-Q3-results-prompts-fall-in-shares.jpeg';
      case 3:
        return 'https://ycent.in/wp-content/uploads/2020/04/1.png';
      case 4:
        return 'https://www.polariceservice.com/wp-content/uploads/2022/02/AmazonPay.jpg';
      case 5:
        return 'https://th.bing.com/th/id/R.efa5a14aced8b116e4de71fabf1941a9?rik=tzMSnsxREGFQow&pid=ImgRaw&r=0';
      case 6:
        return 'assets/screen6_background.jpg';
      default:
        return 'assets/default_background.jpg';
    }
  }
}
