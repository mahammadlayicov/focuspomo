import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pomodoro_app/provider/category_provider.dart';
import 'package:pomodoro_app/view/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../models/category_model.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.45,
      decoration: BoxDecoration(
        color: HexColor("153448"),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              height: 10,
              width: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Select Tag",
              style: GoogleFonts.sora()
                  .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: GridView.builder(
              itemCount: CategoryModel.aa.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  mainAxisExtent: 90),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Build1(categoryModel: CategoryModel.aa[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Build1 extends StatelessWidget {
  final CategoryModel categoryModel;

  Build1({required this.categoryModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<CategoryProvider>(context, listen: false)
            .selectCategory(categoryModel);
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Provider.of<CategoryProvider>(context, listen: false).title ==
                  categoryModel.title
              ? Colors.red
              : Color.fromRGBO(58, 68, 77, 0.49),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              maxRadius: 10,
              backgroundColor: categoryModel.color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              categoryModel.title ?? "",
              style: GoogleFonts.sora()
                  .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
