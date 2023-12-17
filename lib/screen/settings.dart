import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences prefs;
  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';
  late int workTime;
  late int shortBreak;
  late int longBreak;
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(WORKTIME) ?? 30;
    shortBreak = prefs.getInt(SHORTBREAK) ?? 5;
    longBreak = prefs.getInt(LONGBREAK) ?? 15;
    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  @override
  void dispose() {
    txtWork.dispose();
    txtShort.dispose();
    txtLong.dispose();
    saveSetting();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 3,
        scrollDirection: Axis.vertical,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Text('Kerja'),
          Text(''),
          Text(''),
          MaterialButton(
            color: Color(0xff455A64),
            onPressed: () => updateSettings(WORKTIME, -1),
            child: Text(
              '-',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextField(
            controller: txtWork,
          ),
          MaterialButton(
            color: Color(0xff009688),
            onPressed: () => updateSettings(WORKTIME, 1),
            child: Text(
              '+',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text('Short Break'),
          Text(''),
          Text(''),
          MaterialButton(
            color: Color(0xff455A64),
            onPressed: () => updateSettings(SHORTBREAK, -1),
            child: Text(
              '-',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextField(
            controller: txtShort,
          ),
          MaterialButton(
            color: Color(0xff009688),
            onPressed: () => updateSettings(SHORTBREAK, 1),
            child: Text(
              '+',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text('Long Break'),
          Text(''),
          Text(''),
          MaterialButton(
            color: Color(0xff455A64),
            onPressed: () => updateSettings(LONGBREAK, -1),
            child: Text(
              '-',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextField(
            controller: txtLong,
          ),
          MaterialButton(
            color: Color(0xff009688),
            onPressed: () => updateSettings(LONGBREAK, 1),
            child: Column(
              children: [
                MaterialButton(
                  color: Color(0xff009688),
                  onPressed: () => updateSettings(LONGBREAK, 1),
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8), // Add some spacing between the buttons
          Text(
            'Dikerjakan oleh Rofi Ainur Ridho, 21201101',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          workTime = prefs.getInt(WORKTIME)!;
          workTime = workTime + value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          shortBreak = prefs.getInt(SHORTBREAK)!;
          shortBreak = shortBreak + value;
          if (shortBreak >= 1 && shortBreak <= 20) {
            prefs.setInt(SHORTBREAK, shortBreak);
            setState(() {
              txtShort.text = shortBreak.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          longBreak = prefs.getInt(LONGBREAK)!;
          longBreak += value;
          if (longBreak >= 1 && longBreak <= 60) {
            prefs.setInt(LONGBREAK, longBreak);
            setState(() {
              txtLong.text = longBreak.toString();
            });
          }
        }
        break;
    }
  }

  void saveSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt(WORKTIME, workTime);
    prefs.setInt(SHORTBREAK, shortBreak);
    prefs.setInt(LONGBREAK, longBreak);
  }
}
