// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'white_noises.dart' as bottom;
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'to_do_page.dart';

import 'exercise.dart'

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PoTO-Doro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(220, 231, 242, 1.0),
        primaryColorDark: const Color.fromRGBO(47, 69, 105, 1.0),
        backgroundColor: const Color.fromRGBO(216, 129, 146, 0.6),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _borderWidth = 5;
  Color _borderColor = Colors.orange;
  bool _start = false;

  void openwhiteNoise(var context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const bottom.BottomSheet()),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor,
                const Color.fromRGBO(149, 202, 255, 0.0),
              ]),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                width: w * .8,
                height: w * .8,
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Theme.of(context).primaryColorDark,
                        const Color.fromRGBO(69, 104, 161, 0.0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(w * .45),
                    border: Border.all(
                      color: _borderColor,
                      style: BorderStyle.solid,
                      width: _borderWidth,
                    )),
                curve: Curves.fastOutSlowIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: w * .7,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text("Math 206",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                        height: 30,
                        width: w * .5,
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text("Session-2",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ],
                ),
              ),

              const SizedBox(
                height: 12,
              ),
              // time, stopwatch:
              Container(
                width: w * .9,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "24 min",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32),
                    ),
                    Text(
                      ":",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      "46 sec",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              // math206
              // TO DO: math206 ile stopwatch yer değiştirebilir.
              const SizedBox(
                height: 12,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _start = !_start;
                    final random = Random();

                    _borderColor =
                        Color.fromRGBO(0, 0, random.nextInt(200) + 55, 1.0);
                    _borderWidth = random.nextInt(12) + 4;
                  });
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: _start == true
                      ? const Icon(
                          Icons.pause,
                          size: 60,
                          color: Colors.white,
                        )
                      : const Icon(
                          Icons.play_arrow,
                          size: 60,
                          color: Colors.white,
                        ),
                ),
              ),
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Rainy Day...",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.music_note_outlined,
                        size: 32,
                        color: Colors.cyanAccent,
                      )
                    ]),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () => openwhiteNoise(context),
                            icon: const Icon(
                              Icons.music_note_sharp,
                              size: 36,
                            ),
                            label: const Text("music"),
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // exercise
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ExercisePage(),
                              ));
                            },
                            icon: const Icon(Icons.sports_gymnastics_outlined,
                                size: 36),
                            label: const Text("Exercise"),
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // TO-Do
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ToDoPage(),
                              ));
                            },
                            icon: const Icon(
                              Icons.list_sharp,
                              size: 36,
                            ),
                            label: const Text("TO-Do"),
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).primaryColor),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Theme.of(context).primaryColor,
        body: const Center(
          child: Text("Music Screen"),
        ));
  }
}
