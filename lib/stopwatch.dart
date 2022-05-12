import 'dart:async';

import 'package:flutter/material.dart';

import '../exercise.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key, required this.size}) : super(key: key);
  final double size;

  @override
  _StopWatch createState() => _StopWatch();
}

class _StopWatch extends State<StopWatch> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? timer;
  static const int total = 10;
  int _totalTimeSec = total; // 25*60 olacak
  bool _start = false;
  bool _isMessageShowed = false;

  @override
  void initState() {
    super.initState();

    //runTimer();
    print("initstate");
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.3,
      duration: const Duration(seconds: 3),
    )..stop(); //..repeat();
  }

  runTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start) {
        if (_totalTimeSec != 0) {
          setState(() {
            _totalTimeSec--;
            print(_totalTimeSec);
          });
        } else {
          timer.cancel();
          _controller.reset();
          setState(() {
            _start = !_start;
          });
        }
      }
    });
  }

  void animationResetORrepeat() {
    if (_start) {
      //_controller.stop();
      _controller.stop();
    } else if (_totalTimeSec != 0) {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = widget.size;
    print("build works");
    askForExercise(false);
    return Column(
      children: [
        SizedBox(
          height: w,
          width: w,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _buildCircularContainer(w * 0.7),
              _buildCircularContainer(w * 0.9),
              _buildCircularContainer(w),
              stopWatch(w),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    animationResetORrepeat();
                    if (_totalTimeSec != 0) {
                      setState(() {
                        _start = !_start;
                      });
                    }
                    if (_totalTimeSec == total && _start) {
                      runTimer();
                    }
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColorDark.withOpacity(0.8),
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
                Container(
                  height: 20,
                  width: 240,
                  color: Colors.transparent,
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SizedBox(
                height: 40,
                width: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColorDark,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Icon(Icons.square),
                  onPressed: () {
                    if (_totalTimeSec > 0) {
                      _controller.reset();
                    }
                    print("pressed.");
                    if (_totalTimeSec < total) {
                      // timer!.cancel();
                      // setState(() {
                      //   _start = false;
                      //   _totalTimeSec = total;
                      // });

                      askForExercise(true);
                    }

                    // TODO: Show a dialog to say session ended/completed by user.
                  },
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget stopWatch(double w) {
    return Align(
      child: Container(
        height: 60,
        width: w * 0.4,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${giveTime()['min']}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Text(
              ":",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "${giveTime()['sec']}",
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularContainer(double radius) {
    return AnimatedBuilder(
      animation: CurvedAnimation(
          parent: _controller, curve: Curves.fastLinearToSlowEaseIn),
      builder: (context, child) {
        return Container(
          width: _controller.value * radius * 2, // *2 yoktu.
          height: _controller.value * radius * 2,
          decoration: BoxDecoration(
              color: Theme.of(context)
                  .primaryColorDark
                  .withOpacity(1 - _controller.value),
              shape: BoxShape.circle),
        );
      },
    );
  }

  void showAlert(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
              title: Container(
                color: Colors.greenAccent,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                      child: Text(
                    message,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                ),
              ),
              content: SizedBox(
                height: 80,
                width: 100,
                child: Center(
                  child: Column(
                    children: [
                      const Text("Do you want to do exercise?"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _totalTimeSec = total;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text("No, later."),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _totalTimeSec = total;
                              });
                              Navigator.of(context).pop();

                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const ExercisePage(),
                              ));
                            },
                            child: const Text("Let's go!"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  Map<String, String> giveTime() {
    var minSec = {'min': '25', 'sec': '00'};

    int min = (_totalTimeSec / 60).floor(); // ceil idi.
    int sec = _totalTimeSec % 60;

    minSec['min'] = min / 10 >= 1 ? min.toString() : "0" + min.toString();
    minSec['sec'] = sec / 10 >= 1 ? sec.toString() : "0" + sec.toString();

    return minSec;
  }

  void askForExercise(bool earlier) {
    String message = earlier
        ? "You ended the session manually"
        : "Congrats! \nYou completed the session.";
    if ((_totalTimeSec == 0 && !_isMessageShowed) || earlier) {
      setState(() {
        _totalTimeSec = total;
        _start = false;
        timer!.cancel();
        _isMessageShowed = true;
        _controller.reset();
      });
      Future.delayed(Duration.zero, () => showAlert(context, message));
      setState(() {
        _isMessageShowed = false;
      });
    }
  }
}
