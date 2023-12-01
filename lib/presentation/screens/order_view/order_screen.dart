import 'package:amazon_mobile/domain/model/order.dart';
import 'package:amazon_mobile/presentation/layout/search_layout2.dart';
import 'package:amazon_mobile/presentation/resources/cloud_firestore.dart';
import 'package:amazon_mobile/presentation/resources/color_manager.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:amazon_mobile/presentation/widgets/poroduct_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  set query(String query) {}

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      appBar: SearchBarWidget2(
        onChanged: (value) => setState(() {
          widget.query = value;
        }),
        query: '',
        isReadOnly: false,
        hasBackButton: true,
      ),
      body: FutureBuilder(
        future: CloudFirestoreClass().getUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isEmpty ||
              snapshot.data == null ||
              !snapshot.hasData) {
            return const Center(
              child: Text(
                'No Orders Yet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            padding: const EdgeInsets.all(9.0),
            itemBuilder: (context, index) {
              OrderModel order = snapshot.data![index];
              List<Product> orderProducts = order.products;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  collapsedShape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange, width: 2.3),
                  ),
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.orange, width: 2.3),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenSize.width / 4,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Center(
                            child: Image.network(
                                orderProducts[0].imageCover ?? ''),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: ProductInformationWidget(
                              productName: orderProducts[0].title ?? '',
                              cost: double.parse(order.totalPrice.toString()),
                              sellerName: orderProducts[0].brandName ?? '',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9.0),
                            child: Text(
                              'Total Price: EGP ${order.totalPrice}',
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // children: <Widget>[
                  //   ListTile(
                  //     title: Text(
                  //       'Order Staus: ${order.status}',
                  //       style: const TextStyle(fontWeight: FontWeight.w700),
                  //     ),
                  //     subtitle: Text('Payment Method: ${order.payment}',),
                  //   ),
                  // ],
                  children: order.products.length > 1
                      ? [
                          const Text(
                            'Details:',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(color: Colors.orange),
                          for (var singleProduct in order.products)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: screenSize.width / 6,
                                        child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Center(
                                            child: Image.network(
                                                singleProduct.imageCover ?? ''),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(9.0),
                                            child: ProductInformationWidget(
                                              productName:
                                                  singleProduct.title ?? '',
                                              cost: double.parse(
                                                  order.totalPrice.toString()),
                                              sellerName:
                                                  singleProduct.brandName ?? '',
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(left: 9.0),
                                          //   child: Text(
                                          //     'Total Price: EGP ${order.totalPrice}',
                                          //     style: TextStyle(fontSize: 18.0),
                                          //   ),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const Divider(color: Colors.orange)
                                ],
                              ),
                            ),
                        ]
                      : [
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PaypalCheckoutView(
                                  note:
                                      "Contact us for any questions on your order.",
                                  onSuccess: (Map params) async {
                                    print("onSuccess: $params");
                                    Navigator.pop(context);
                                  },
                                  onError: (error) {
                                    print("onError: $error");
                                    Navigator.pop(context);
                                  },
                                  onCancel: () {
                                    print('cancelled:');
                                    Navigator.pop(context);
                                  },
                                  sandboxMode: true,
                                  clientId:
                                      "AeZfRlbmQtc8Z57hOW7gb-sPUJgnhNfJd3QCnf4OpnZbpAFTCY1ceBnElh_siV0mDNn70pbAKjK2ss1T",
                                  secretKey:
                                      "EEWFtW1vuSGxrA1wgTvxTDhFW9B9oN3ZypsAMqB16tIX4wqjnKiDofVwLI6PjU4zuVYIebgjTMEKBeOg",
                                  transactions: [
                                    {
                                      "amount": {
                                        "total": order.totalPrice.toString(),
                                        "currency": "USD",
                                        "details": {
                                          "subtotal":
                                              order.totalPrice.toString(),
                                          "shipping": '0',
                                          "shipping_discount": "0"
                                        }
                                      },
                                      "description":
                                          "Payment for order ${order.id}",
                                      "item_list": {
                                        "items": order.products
                                            .map(
                                              (product) => {
                                                "name": product.title,
                                                "quantity": product.qty,
                                                "price":
                                                    product.price.toString(),
                                                "currency": "USD"
                                              },
                                            )
                                            .toList(),
                                      },
                                    }
                                  ],
                                ),
                              ));
                            },
                            child: Text('Pay with PayPal'),
                          ),
                        ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
