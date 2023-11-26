import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_product_box.dart';
import 'package:amazon_mobile/presentation/screens/cart_view/cart_subtotal.dart';
import 'package:amazon_mobile/presentation/widgets/user_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});
  set query(String query) {}

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  ScrollController controller = ScrollController();
  double offset = 0;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget2(
          query: '',
          isReadOnly: false,
          hasBackButton: true,
          onChanged: (value) => setState(() {
            widget.query = value;
          }),
        ),
        backgroundColor: ColorManager.backgroundColor,
        body: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  UserDetailsBar(
                    offset: offset,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                      child: Subtotal()),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your order qualifies for free delivery',
                                  style: TextStyle(
                                      color: Colors.teal[900],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Choose this option at checkout.',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Handle the 'See details' button tap
                                      },
                                      child: Text(
                                        'See details',
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: MaterialButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(20.0),
                          minWidth: double.infinity,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          color: Color.fromARGB(255, 239, 199, 20),
                          child: Text(
                            'Proceed to Buy (cart items count)',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
            CartProductBox(),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(children: [
                Container(
                  width: 260,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Returns are easy',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                        SizedBox(height: 5,),
                        Text('Return items within 30 days of delivery'),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image(
                        height: 50,
                        width: 50,
                        image: NetworkImage('https://picsum.photos/200/300')),
                    ],
                  ),
                ),
              ]),
            )
          ],
        )
        );
  }
}
