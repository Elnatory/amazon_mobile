import 'package:amazon_mobile/presentation/layout/search_layout.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
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
        appBar: SearchBarWidget(
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
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Subtotal EGP prdPrice',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
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
                                  'Your order is eligible for free delivery',
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
          ],
        ));
  }
}
