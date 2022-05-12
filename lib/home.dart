import 'white_noises.dart' as bottom;

import 'package:flutter/material.dart';
import 'to_do_page.dart';

import 'exercise.dart';
import 'stopwatch.dart';

class MyHomePage extends StatelessWidget {
   String title;
   String session;
   MyHomePage({
    Key? key,  required this.title, required this.session
  }) : super(key: key);

  @override

  void openwhiteNoise(var context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery
                        .of(context)
                        .viewInsets
                        .bottom),
                child: const bottom.BottomSheet()),
          ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery
        .of(context)
        .size
        .width;
    var h = MediaQuery
        .of(context)
        .size
        .height;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme
                    .of(context)
                    .primaryColor,
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
              StopWatch(size: w * .8),
              const SizedBox(
                height: 12,
              ),
              // math206
              // TO DO: math206 ile stopwatch yer değiştirebilir.
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("$title \n $session",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        width: 12,
                      ),
                      Icon(
                        Icons.play_lesson,
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
                      color: Theme
                          .of(context)
                          .primaryColorDark,
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
                                Theme
                                    .of(context)
                                    .primaryColor),
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
                                Theme
                                    .of(context)
                                    .primaryColor),
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
                                Theme
                                    .of(context)
                                    .primaryColor),
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
