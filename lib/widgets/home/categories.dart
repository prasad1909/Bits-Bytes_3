import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'category_card.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    readJson();
    super.initState();
  }

  List covid = [];
  List devices = [];
  List nutriton = [];
  List personal = [];
  List daily = [];

  Future<void> readJson() async {
    var a = [];
    var b = [];
    var c = [];
    var d = [];
    var e = [];
    final String response =
        await rootBundle.loadString('assets/data/FinalData.json');
    final data = await json.decode(response);
    for (var i = 0; i < data.length; i++) {
      if (data[i]['Category'] == 'Covid Essentials') {
        a.add(data[i]);
      } else if (data[i]['Category'] == 'Personal Care') {
        b.add(data[i]);
      } else if (data[i]['Category'] == 'General Medication') {
        c.add(data[i]);
      } else if (data[i]['Category'] == 'Nutrition & Fitness Suppliments') {
        d.add(data[i]);
      } else {
        e.add(data[i]);
      }
    }
    setState(() {
      covid = a;
      personal = b;
      daily = c;
      nutriton = d;
      devices = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          CategoryCard(
            title: 'Covid Essentials',
            imgUrl:
                "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
            productsList: covid,
          ),
          const SizedBox(
            width: 20,
          ),
          CategoryCard(
            title: 'Medical Devices',
            imgUrl:
                "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
            productsList: devices,
          ),
          const SizedBox(
            width: 20,
          ),
          CategoryCard(
            title: 'Nutrition & Fitness Suppliments',
            imgUrl:
                "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
            productsList: nutriton,
          ),
          const SizedBox(
            width: 20,
          ),
          CategoryCard(
            title: 'Personal Care',
            imgUrl:
                "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
            productsList: personal,
          ),
          const SizedBox(
            width: 20,
          ),
          CategoryCard(
            title: 'General Medication',
            imgUrl:
                "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
            productsList: daily,
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
