// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

import 'dart:core';
import 'dart:math';

Color? randomColour1 = Colors.transparent;

Color? randomColour4 = Colors.transparent;
Color? randomColour5 = Colors.transparent;
Color? randomColour6 = Colors.transparent;

int dateInMS = 0;

List buttonColours = [
  randomColour1,
  randomColour4,
  randomColour5,
  randomColour6,
];
List<int> timeDiffColours = [];
List<int> avgTimeColours = [0];

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class colourReflexes extends StatefulWidget {
  const colourReflexes({Key? key}) : super(key: key);

  @override
  colourReflexesState createState() => colourReflexesState();
}

class colourReflexesState extends State<colourReflexes> {
  late double deviceWidth;
  late double deviceHeight;

  void start() {
    buttonColours.add(randomColour1);
    buttonColours.add(randomColour4);
    buttonColours.add(randomColour5);
    buttonColours.add(randomColour6);
  }
  // Variables that might be affected

  List<Color?> colorList = [
    Colors.yellow,
    Colors.teal,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.lime,
    Colors.lightGreen,
    Colors.lightBlue[200],
    Colors.indigo,
    Colors.green,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
    Colors.blue,
    Colors.amber,
    Colors.black,
    const Color.fromARGB(255, 105, 105, 105), // Grey but hex is #696969
    const Color.fromARGB(255, 66, 4, 32), // Magenta but hex is #b00b69
    const Color.fromARGB(255, 176, 11, 105), // Dark Purple but hex is #420420
  ];

  Random random = Random();

  // Function to execute
  void newColour() {
    setState(() {
      buttonColours.clear();
      randomColour1 = colorList[random.nextInt(colorList.length)];
      randomColour4 = colorList[random.nextInt(colorList.length)];
      randomColour5 = colorList[random.nextInt(colorList.length)];
      randomColour6 = colorList[random.nextInt(colorList.length)];

      while (randomColour1 == randomColour4) {
        randomColour4 = colorList[random.nextInt(colorList.length)];
      }
      while (randomColour1 == randomColour5) {
        randomColour5 = colorList[random.nextInt(colorList.length)];
      }
      while (randomColour1 == randomColour6) {
        randomColour6 = colorList[random.nextInt(colorList.length)];
      }
      while (randomColour4 == randomColour5) {
        randomColour5 = colorList[random.nextInt(colorList.length)];
      }
      while (randomColour4 == randomColour6) {
        randomColour6 = colorList[random.nextInt(colorList.length)];
      }
      while (randomColour5 == randomColour6) {
        randomColour6 = colorList[random.nextInt(colorList.length)];
      }

      if (randomColour1 != randomColour4 &&
          randomColour4 != randomColour5 &&
          randomColour5 != randomColour6) {
        buttonColours.add(randomColour1);
        buttonColours.add(randomColour4);
        buttonColours.add(randomColour5);
        buttonColours.add(randomColour6);
      }

      // ignore: avoidprint
    });
  }

  int randomButton = Random().nextInt(3);

  @override
  Widget build(BuildContext context) {
    int dateInMS = DateTime.now().millisecondsSinceEpoch;
    timeDiffColours.add(dateInMS);
    start();
    randomButton = Random().nextInt(3);
    if (randomColour1 == randomColour4 ||
        randomColour1 == randomColour5 ||
        randomColour1 == randomColour6) {
      newColour();
    }
    int avgTimeTaken = 1 +
        (avgTimeColours.map((m) => m).reduce((a, b) => a + b) /
                avgTimeColours.length)
            .ceil();
    // ignore: avoid_print
    print("Correct button is : " + randomButton.toString());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: const BackButton(),
        title: Text('Colour Reflexes - Average time taken : $avgTimeTaken ms'),
        backgroundColor: Colors.blue[700],
      ),
      // ignore: prefer_const_constructors
      extendBodyBehindAppBar: true,
      // ignore: avoid_unnecessary_containers, prefer_const_constructors
      body: SafeArea(
        // ignore: prefer_const_constructors
        child: colourBox(),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'bitch',
            onPressed: () {
              if (randomButton == 0) {
                correctAnswer(context);
                newColour();
              } else {
                wrongAnswer(context);
              }
            },
            backgroundColor:
                randomButton == 0 ? buttonColours[0] : buttonColours[1],
            child: const Icon(Icons.add),
          ), // First Button

          FloatingActionButton(
            heroTag: 'asshole',
            onPressed: () {
              if (randomButton == 1) {
                correctAnswer(context);
                newColour();
              } else {
                wrongAnswer(context);
              }
            },
            backgroundColor:
                randomButton == 1 ? buttonColours[0] : buttonColours[2],
            child: const Icon(Icons.add),
          ), // Second Button

          FloatingActionButton(
            heroTag: 'colourblind',
            onPressed: () {
              if (randomButton == 2) {
                correctAnswer(context);
                newColour();
              } else {
                wrongAnswer(context);
              }
            },
            backgroundColor:
                randomButton == 2 ? buttonColours[0] : buttonColours[3],
            child: const Icon(Icons.add),
          ), // Third Button
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class colourBox extends StatelessWidget {
  const colourBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: buttonColours[0],
            alignment: Alignment.center,
          ),
        )
      ],
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }
}

void correctAnswer(BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;

  int dateInMSAfterAnswer = DateTime.now().millisecondsSinceEpoch;
  timeDiffColours.add(dateInMSAfterAnswer);

  int timeTaken = timeDiffColours[1] - timeDiffColours[0];
  avgTimeColours.add(timeTaken);
  // ignore: deprecated_member_use
  scaffoldKey.currentState!.hideCurrentSnackBar();
  // ignore: deprecated_member_use
  scaffoldKey.currentState!.showSnackBar(SnackBar(
    elevation: deviceHeight / 2, // Doesnt work, bc why not ?
    duration: const Duration(milliseconds: 1069),
    content: Text('Right Answer ! It took you : $timeTaken ms'),
  ));
  timeDiffColours.clear();
}

void wrongAnswer(BuildContext context) {
  double deviceHeight = MediaQuery.of(context).size.height;
  // ignore: deprecated_member_use
  scaffoldKey.currentState!.hideCurrentSnackBar();
  // ignore: deprecated_member_use
  scaffoldKey.currentState!.showSnackBar(SnackBar(
    duration: const Duration(milliseconds: 1069),
    elevation: deviceHeight / 2, // Doesnt work, bc why not ?
    content: const Text('Wrong Answer !'),
  ));
}

void goBack(BuildContext context) {
  dateInMS = 0;
  Navigator.of(context).pop();
}
