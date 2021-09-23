import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final int price;
  final String image;
  final callback;

  const ProductCard(this.title, this.price, this.image,
      {Key? key, this.callback})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    checkItemInCart();
    super.initState();
  }

  int quantity = 0;

  Future addToCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(widget.title, 1);
    setState(() {
      quantity = 1;
    });
  }

  Future checkItemInCart() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var item = preferences.getInt(widget.title);
    if (item != null) {
      setState(() {
        quantity = item;
      });
    }
  }

  Future increase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      quantity += 1;
    });
    await preferences.setInt(widget.title, quantity);
    if (widget.callback != null) {
      widget.callback();
    }
  }

  Future decrease() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      quantity -= 1;
    });
    if (quantity == 0) {
      await preferences.remove(widget.title);
    } else {
      await preferences.setInt(widget.title, quantity);
    }
    if (widget.callback != null) {
      widget.callback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 6,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFFFFFF),
              border: Border.all(width: 0.3)),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 5,
                height: MediaQuery.of(context).size.height / 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  widget.image,
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 5,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                    width: MediaQuery.of(context).size.width / 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 90,
                  ),
                  Row(
                    children: [
                      Text(
                        "₹ " + widget.price.toString(),
                        style: const TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      quantity != 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    decrease();
                                  },
                                  child: const Icon(Icons.remove),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(20, 15),
                                    shape: CircleBorder(),
                                    textStyle: TextStyle(color: Colors.teal),
                                  ),
                                ),
                                Text(quantity.toString()),
                                ElevatedButton(
                                  onPressed: () {
                                    increase();
                                  },
                                  child: const Icon(Icons.add),
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(20, 15),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            )

                          : ElevatedButton(
                              onPressed: () async {
                                await addToCart();
                              },
                              child: const Icon(
                                Icons.add_shopping_cart_rounded,
                                size: 17,
                                color: Colors.black,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
