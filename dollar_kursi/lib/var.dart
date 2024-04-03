import 'package:dollar_kursi/main.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:glass/glass.dart';
import 'class.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool _isDarkMode = true;
  Color c = Colors.blue;
  List<Widget> body = [
    MyWidget1(),
    MyApp(),
    MyApp(),
    Text('home'),
    Text('homekg'),
  ];
  int myindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: a,
        appBar: AppBar(
          flexibleSpace: Container(
            color: Colors.black.withOpacity(0.4),
          ).asGlass(),
          backgroundColor: Colors.transparent,
          leading: DrawerButton(
            style: ButtonStyle(
                iconColor: MaterialStateColor.resolveWith((states) => b)),
          ),
          title: Text(
            'Valyuta kursi',
            style: TextStyle(color: b),
          ),
        ),
        body: Center(
          child: body[myindex],
        ),
        bottomNavigationBar: GNav(
          onTabChange: (index) {
            setState(() {
              myindex = index;
            });
          },
          padding: EdgeInsets.all(16),

          duration: Duration(milliseconds: 500),
          gap: 15,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.list,
              text: 'List',
            ),
            GButton(
              icon: Icons.currency_exchange,
              text: 'Convert',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
          color: b,
          activeColor: c,
          // tab button ripple color when pressed
          hoverColor: Colors.grey, // tab button hover color
          haptic: true, // haptic feedback
          tabBackgroundColor: Colors.grey.withOpacity(0.5),
        ),
        drawer: Drawer(
            backgroundColor: a,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Switch(
                          trackOutlineColor:
                              MaterialStateColor.resolveWith((states) => b),
                          hoverColor: c,
                          overlayColor:
                              MaterialStateColor.resolveWith((states) => b),
                          activeTrackColor: Colors.green,
                          thumbColor:
                              MaterialStateColor.resolveWith((states) => c),
                          trackColor:
                              MaterialStateColor.resolveWith((states) => a),
                          activeColor: Colors.black,
                          value: _isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              _isDarkMode = value;
                              if (_isDarkMode) {
                                mainScreen;
                                CurrencyData;
                                a = Color.fromARGB(255, 20, 26, 31);
                                b = Colors.white;
                              } else {
                                mainScreen;
                                CurrencyData;
                                a = Colors.white;
                                b = Colors.black;
                              }
                            });
                          },
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          'Tungi rejim',
                          style: TextStyle(color: b, fontSize: 21),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
// l
// l
// l

// l
class CurrencyData {
  final String currencyCode;
  final String currencyName;
  final double rate;

  CurrencyData({
    required this.currencyCode,
    required this.currencyName,
    required this.rate,
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<CurrencyData> currencyDataList = [];

  Future<void> fetchCurrencyData() async {
    final response = await http
        .get(Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        currencyDataList = responseData.map((data) {
          return CurrencyData(
            currencyCode: data['Ccy'],
            currencyName: data['CcyNm_UZ'],
            rate: double.parse(data['Rate']),
          );
        }).toList();
      });
    } else {
      throw Exception('Failed to load currency data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCurrencyData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: a,
        body: ListView.builder(
          itemCount: currencyDataList.length,
          itemBuilder: (context, index) {
            final currencyData = currencyDataList[index];
            return Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Container(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [a, b.withOpacity(0.01)]),
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ExpansionTile(
                      title: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  currencyData.currencyName,
                                  style: TextStyle(color: b, fontSize: 19),
                                ),
                                Text(
                                  currencyData.currencyCode,
                                  style: TextStyle(color: b, fontSize: 20),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [],
                            )
                          ],
                        ),
                      ),
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  currencyData.rate.toString(),
                                  style: TextStyle(color: b, fontSize: 25),
                                ),
                                Text(
                                  "so'm",
                                  style: TextStyle(color: b),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: FittedBox(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    onPressed: () {
                                      setState(() {
                                        mainScreen.add(qosh(
                                            Ccy: currencyData.currencyCode
                                                .toString(),
                                            Rate: currencyData.rate.toString(),
                                            CcyNm_En: currencyData.currencyName
                                                .toString()));
                                        cc = currencyData.currencyCode;
                                        rt = currencyData.rate.toString();

                                        cc = currencyData.currencyName;
                                      });
                                    },
                                    child: Text(
                                      'Asosiylarga qo`shish',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
