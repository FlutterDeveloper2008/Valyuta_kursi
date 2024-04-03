import 'package:dollar_kursi/main.dart';
import 'package:flutter/material.dart';

// In your other stateful widget:
class MyWidget1 extends StatefulWidget {
  const MyWidget1({super.key});

  @override
  State<MyWidget1> createState() => _MyWidget1State();
}

class _MyWidget1State extends State<MyWidget1> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: mainScreen
          .map((e) => Container(
              decoration: BoxDecoration(
                  color: a,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: b.withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 5)
                  ]),
              height: 120,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    e.Ccy.toString(),
                    style: TextStyle(color: b, fontSize: 35),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            e.Rate.toString(),
                            style: TextStyle(
                                color: b,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'so`m',
                            style: TextStyle(color: b),
                          )
                        ],
                      ),
                      Text(
                        e.CcyNm_En.toString(),
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )))
          .toList(),
    );
  }
}
