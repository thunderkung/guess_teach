import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultPage extends StatelessWidget {
  static const routeName = '/resultPage';

  const ResultPage({Key? key}) : super(key: key);

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'อายุอาจารย์',
                  style: GoogleFonts.mali(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.black),
                ),
                Text(
                  '\n46 ปี 10 เดือน',
                  style: GoogleFonts.mali(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/ame.png',width: 200,),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}