import 'package:flutter/material.dart';

class CustomRowWidget extends StatefulWidget {
  final String img;
  final String dsc;
  final String titl;

  const CustomRowWidget({
    Key? key,
    required this.img,
    required this.dsc,
    required this.titl,
  }) : super(key: key);

  @override
  State<CustomRowWidget> createState() => _CustomRowWidgetState();
}

class _CustomRowWidgetState extends State<CustomRowWidget> {
  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.height / 1000;
    var wdt = MediaQuery.of(context).size.width / 1000;
    return Row(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 10 * wdt, vertical: 10 * ht),
          child: Container(
            height: 50 * ht,
            width: 50 * ht,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                image:
                    NetworkImage(widget.img), // Use the provided img variable
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.titl, // Use the provided titl variable
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3 * ht,
            ),
            Text(
              widget.dsc, // Use the provided dsc variable
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
