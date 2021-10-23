import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:work14/pages/api.dart';
import 'package:work14/pages/result_page.dart';

class GamePage extends StatefulWidget {
  static const routeName = '/guessPage';

  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  var year = 0;
  var month = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("GUESS TEACHER'S AGE", style: GoogleFonts.ubuntu()),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/clock_background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'อายุอาจารย์',
                style:
                    GoogleFonts.rubikMonoOne(fontSize: 30, color: Colors.black),
              ),
              _buildInputPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputPanel() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpinBox(
                    min: 0,
                    max: 120,
                    value: 0,
                    onChanged: (value) => setState(() {
                          year = value as int;
                        }),
                    textStyle: GoogleFonts.mali(fontSize: 30),
                    decoration: InputDecoration(
                        labelText: 'ปี',
                        labelStyle: GoogleFonts.mali(fontSize: 25))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SpinBox(
                    min: 0,
                    max: 12,
                    value: 0,
                    onChanged: (value) => setState(() {
                          month = value as int;
                        }),
                    textStyle: GoogleFonts.mali(fontSize: 30),
                    decoration: InputDecoration(
                        labelText: 'เดือน',
                        labelStyle: GoogleFonts.mali(fontSize: 25))),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: _handleClickButton,
                    child: Text(
                      'ทาย',
                      style: GoogleFonts.mali(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      primary: Colors.brown,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "ผลการทาย",
            style: TextStyle(color: Colors.black),
          ),
          content:
              Text(msg, style: TextStyle(fontSize: 20, color: Colors.black)),
          actions: [
            TextButton(
              child: Text('OK',
                  style: GoogleFonts.righteous(
                    fontSize: 20,
                    color: Colors.indigo,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _handleClickButton() async {
    var guest = await _login(year, month);

    if (guest['value'] == true) {
      Navigator.pushReplacementNamed(
        context,
        '/resultPage',
        arguments: {'year': year, 'month': month},
      );
    } else {
      _showMaterialDialog('ผลการทาย', '${guest['text']}');
    }
  }

  Future<dynamic> _login(int y, int m) async {
    try {
      var isLogin =
          (await Api().submit('guess_teacher_age', {'year': y, 'month': m}));
      print('LOGIN: $isLogin');
      return isLogin;
    } catch (e) {
      print(e);
      _showMaterialDialog('ERROR', e.toString());
      return null;
    }
  }
}
