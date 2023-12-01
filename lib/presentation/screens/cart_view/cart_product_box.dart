import 'package:amazon_mobile/domain/model/products.dart';
import 'package:flutter/material.dart';

class CartProductBox extends StatefulWidget {
  final Product singleProduct;
  // final int index;
  const CartProductBox({
    super.key, required this.singleProduct,
  });

  @override
  State<CartProductBox> createState() => _CartProductBoxState();
}

class _CartProductBoxState extends State<CartProductBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'Deselect all items',
                        style: TextStyle(color: Colors.blue[900]),
                      )),
                ],
              ),
              Container(
                child:
                    const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Image(
                      height: 100,
                      width: 100,
                      image: NetworkImage('https://picsum.photos/200/300')),
                  Column(
                    children: [
                      Text('Product name'),
                      Text('Product price'),
                      Text('Product quantity'),
                      Text('Product total'),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.3, color: Colors.grey),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete_outline),
                                ),
                              ),
                              SizedBox(
                                width: 90,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    'Items count',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ),
                                ),
                              ),
                              Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3, color: Colors.grey),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Text(
                                'Delete',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey),
                              ),
                              child: Text(
                                'Save for later',
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
