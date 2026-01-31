import 'package:flutter/material.dart';

class Navigationpage2 extends StatelessWidget {
  const Navigationpage2({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 5,
      mainAxisSpacing: 2,
      scrollDirection: Axis.vertical,
      children: [
        Container(
          // height: 100,
          // width: 100,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/img4.jpeg", fit: BoxFit.cover),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset("assets/img5.jpeg", fit: BoxFit.cover),
        ),
        ClipOval(
          child: Image.network(
            "https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L3BmMzkta2Fyb2xpbmEtZ3JhYm93c2thLWthYm9vbXBpY3MtNjg3NC5qcGc.jpg",
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset("assets/img8.jpeg", fit: BoxFit.cover),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img9.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipOval(
            child: Image.asset("assets/img10.jpeg", fit: BoxFit.cover),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img9.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipOval(
            child: Image.asset("assets/img5.jpeg", fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
