import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const bgcolor = Color(0xFFe5f0f8);
const buttonColor = Color(0xff2f4569);
final List<String> imageList = [
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chair-knee-to-elbow-1441308819.gif?resize=480:*",
  "https://i.pinimg.com/originals/92/19/4b/92194be364671a144f8b6318d801b5f1.gif",
  "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chair-pull-1441308819.gif?resize=480:*",
  // "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chair-arms-0-1441308819.gif?resize=480:*",
  // "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chair-pull-1441308819.gif?resize=480:*",
  // "https://i.pinimg.com/originals/95/98/cd/9598cdfc149ac0c18113bc5d49e6fdb5.gif"
];
final List<String> nameList = [
  'Knee-to-elbow',
  'Leg Extensions',
  "",
];
final List<String> descList = [
  "Place an ankle weight around each ankle. Sit upright with good posture, lift your left knee upward toward your chest and touch your knee with your right elbow. Slowly return to the starting position, then repeat with the right leg and left elbow. This exercise will help improve your co-ordination, core strength, leg strength and hip mobility.",
  "Sit on the edge of your chair with your arms by your sides. Extend your right leg out straight and flex your foot so that just the right heel is on the floor (keeping your foot flexed engages the muscles in the shins and ankle). Lift your leg up as high as you can without rounding your back. Hold for 3 counts then lower. Repeat with the other leg. Work up to 3 sets of 10 reps on each leg.",
  "",
];
List<Map<dynamic, dynamic>> exercises_details = [
  {
    'exercise_name': 'Knee-to-elbow',
    'exercise_desc':
        "Place an ankle weight around each ankle. Sit upright with good posture, lift your left knee upward toward your chest and touch your knee with your right elbow. Slowly return to the starting position, then repeat with the right leg and left elbow. This exercise will help improve your co-ordination, core strength, leg strength and hip mobility.",
    'exercise_image':
        'https://images.footlocker.com/is/image/EBFL2/O2424001?wid=1024&hei=1024&fmt=png-alpha',
  },
  {
    'exercise_name': 'Leg Extensions',
    'exercise_desc':
        "Sit on the edge of your chair with your arms by your sides. Extend your right leg out straight and flex your foot so that just the right heel is on the floor (keeping your foot flexed engages the muscles in the shins and ankle). Lift your leg up as high as you can without rounding your back. Hold for 3 counts then lower. Repeat with the other leg. Work up to 3 sets of 10 reps on each leg.",
    'exercise_image':
        'https://images.footlocker.com/is/image/EBFL2/O2424001?wid=1024&hei=1024&fmt=png-alpha',
  },
];

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: buttonColor,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: CarouselSlider(
                            options: CarouselOptions(
                                enlargeCenterPage: true,
                                enableInfiniteScroll: false,
                                autoPlay: false,
                                onPageChanged: (index, other) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                            items: imageList
                                .map((e) => ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: <Widget>[
                                          Image.network(
                                            e,
                                            width: 1050,
                                            height: 1050,
                                            fit: BoxFit.fill,
                                          )
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RawMaterialButton(
                            onPressed: () {},
                            // child: Icon(
                            //   Icons.crop_rotate,
                            //   color: Colors.blue,
                            // ),
                            // shape: CircleBorder(),
                            // elevation: 2.0,
                            // fillColor: Colors.white,
                            // padding: const EdgeInsets.all(3.0),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, -1),
                        blurRadius: 5,
                        color: Colors.black12,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 25, left: 25, right: 25),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              Text(
                                nameList[_current],
                                style: TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Description: ",
                                style: TextStyle(fontSize: 21),
                              ),
                              SizedBox(height: 3),
                              Text(
                                descList[_current],
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      RaisedButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 11),
                        color: Colors.cyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {},
                        child: Text("Done"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
