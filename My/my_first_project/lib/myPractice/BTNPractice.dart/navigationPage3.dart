import 'package:flutter/material.dart';

class Navigationpage3 extends StatelessWidget {
  const Navigationpage3({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img7.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset("assets/img10.jpeg", fit: BoxFit.cover),
            ),
            SizedBox(height: 15),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img5.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center, // image কে center করল
              child: ClipOval(
                child: Container(
                  height: 100,
                  width: 100,
                  child: Image.asset("assets/img8.jpeg", fit: BoxFit.cover),
                ),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img7.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center, // image কে center করল
              child: ClipOval(
                child: Container(
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/img3.jpeg", fit: BoxFit.cover),
                ),
              ),
            ),

            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/img10.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              alignment: Alignment.center, // image কে center করল
              child: ClipOval(
                child: Container(
                  height: 70,
                  width: 70,
                  child: Image.asset("assets/img5.jpeg", fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
