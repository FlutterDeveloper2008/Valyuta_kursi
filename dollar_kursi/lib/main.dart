import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glass/glass.dart';
import 'var.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'main',
    routes: {'main': (context) => MyApp1()},
  ));
}

List<qosh> mainScreen = [];

class qosh {
  String? Ccy;
  String? CcyNm_En;
  String? Rate;
  qosh({this.Ccy, this.CcyNm_En, this.Rate});
}

Color a = Color.fromARGB(255, 20, 26, 31);
Color b = Colors.white;
Map kom = {'baho': rt};
String cy = '';
String cc = '';
String rt = '';

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Onboarding Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  bool _isDarkThemeSelected = false;
  bool _showOnboarding = true;

  @override
  void initState() {
    super.initState();    _loadShowOnboardingState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }
  
  _loadShowOnboardingState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _showOnboarding = prefs.getBool('showOnboarding') ?? true;
    });
  }

  _updateShowOnboardingState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _showOnboarding = value;
    });
    await prefs.setBool('showOnboarding', value);
  }

  @override
  Widget build(BuildContext context) {
    return _showOnboarding
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Center(),
                              Column(
                                children: [
                                  Text(
                                    'Xush kelibsiz!',
                                    style: TextStyle(color: b, fontSize: 35),
                                  ),
                                  Text(
                                    'Valyuta kursi',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                              Center(
                                child: Container(
                                  height: 250,
                                  width: 250,
                                  child: Image.asset('i/inc.png'),
                                ),
                              ),
                              Center(),
                            ],
                          ),
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: a,
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    a,
                                    Color.fromARGB(255, 12, 15, 18)
                                  ])),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: a,
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    a,
                                    Color.fromARGB(255, 12, 15, 18)
                                  ])),
                          height: double.infinity,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Image.asset('i/dec.png'),
                              Text(
                                'Bu ilovada siz barcha davlatlar ',
                                style: TextStyle(color: b, fontSize: 22),
                              ),
                              Text(
                                'valyutalarining o`zbek so`midagi',
                                style: TextStyle(color: b, fontSize: 22),
                              ),
                              Text(
                                'qiymatini ko`rishingir mumkin.',
                                style: TextStyle(color: b, fontSize: 22),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 250,
                                width: 250,
                                child: Image.asset('i/convert.png'),
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Convert bo`limi orqali istalgan valyuta',
                                    style: TextStyle(color: b, fontSize: 20),
                                  ),
                                  Text(
                                    'istalgan qiymatni o`zbek so`mida qancha ',
                                    style: TextStyle(color: b, fontSize: 20),
                                  ),
                                  Text(
                                    'bo`lishini bilib olishingiz mumkin.',
                                    style: TextStyle(color: b, fontSize: 20),
                                  ),
                                ],
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: a,
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    a,
                                    Color.fromARGB(255, 12, 15, 18)
                                  ])),
                        ),
                        MyApp(),
                        Container(
                          color: a,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mavzuni tanlang',
                                style: TextStyle(
                                  color: b,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                child: Icon(Icons.format_paint_rounded),
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(colors: [a, b])),
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              RadioListTile<bool>(
                                title: Text(
                                  'Tungi',
                                  style: TextStyle(color: b),
                                ),
                                value: false,
                                groupValue: _isDarkThemeSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _isDarkThemeSelected = value!;
                                    if (!_isDarkThemeSelected) {
                                      a = Color.fromARGB(255, 20, 26, 31);
                                      b = Colors.white;
                                    }
                                  });
                                },
                                activeColor: Colors.lightBlue,
                              ),
                              RadioListTile<bool>(
                                title: Text(
                                  'Kunduzgi ',
                                  style: TextStyle(color: b),
                                ),
                                value: true,
                                groupValue: _isDarkThemeSelected,
                                onChanged: (value) {
                                  setState(() {
                                    _isDarkThemeSelected = value!;
                                    if (_isDarkThemeSelected) {
                                      a = Colors.white;
                                      b = Colors.black;
                                    }
                                  });
                                },
                                activeColor: Colors.lightBlue,
                              ),
                              SizedBox(
                                height: 100,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue),
                                  onPressed: () {                                    _updateShowOnboardingState(false);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SecondScreen(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Boshlash',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                  )),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                          height: double.infinity,
                          width: double.infinity,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 200,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < 4; i++)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 8.0),
                                width: _currentPage == i ? 20.0 : 8.0,
                                height: 8.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == i
                                      ? Colors.lightBlue
                                      : Colors.grey.shade400,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentPage != 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _pageController.previousPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: SizedBox(
                                    height: 70,
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: b,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (_currentPage != 4)
                            TextButton(
                              onPressed: () {
                                _pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: Text(
                                'Keyingi',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 76, 170, 247),
                                    fontSize: 22),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : SecondScreen();
  }
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
        appBar: AppBar(
          flexibleSpace: Container(
            color: a.withOpacity(0.6),
          ).asGlass(),
          backgroundColor: Colors.transparent,
          title: Text(
            'O`zingizga keragini tanlang',
            style: TextStyle(color: b),
          ),
        ),
        extendBodyBehindAppBar: true,
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
                                      'Tanlang',
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
                      initiallyExpanded: true,
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
