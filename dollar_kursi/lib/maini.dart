import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Switch Demo',
      home: ColorSwitchScreen(),
    );
  }
}

class ColorSwitchScreen extends StatefulWidget {
  @override
  _ColorSwitchScreenState createState() => _ColorSwitchScreenState();
}

class _ColorSwitchScreenState extends State<ColorSwitchScreen> {
  Color _backgroundColor = Colors.black; // Default color
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadBackgroundColor();
  }

  void _loadBackgroundColor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitched = prefs.getBool('isSwitched') ?? false;
      if (_isSwitched) {
        _backgroundColor = Colors.white;
      }
    });
  }

  void _saveBackgroundColor(bool isSwitched) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSwitched', isSwitched);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Switch Demo'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Background Color',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              Switch(
                value: _isSwitched,
                onChanged: (value) {
                  setState(() {
                    _isSwitched = value;
                    if (_isSwitched) {
                      _backgroundColor = Colors.white;
                    } else {
                      _backgroundColor = Colors.black;
                    }
                    _saveBackgroundColor(_isSwitched);
                  });
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
