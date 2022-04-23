import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const bgcolor = Color(0xFFe5f0f8);
const buttonColor = Color(0xff2f4569);
final List<String> imageList = [
  "assets/legextensions.gif",
  "assets/pull.gif",
  "assets/kneetoelbow.gif",

  // "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chair-knee-to-elbow-1441308819.gif?resize=480:*",
  // "https://i.pinimg.com/originals/92/19/4b/92194be364671a144f8b6318d801b5f1.gif",
  // "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/chair-pull-1441308819.gif?resize=480:*",
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
  "Sit on the edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sthe edge of your chair with your arms by your sides. Extend your right leg out straight and flex your foot so that just the right heel is on the floor (keeping your foot flexed engages the muscles in the shins and ankle). Lift your leg up as high as you can without rounding your back. Hold for 3 counts then lower. Repeat with the other leg. Work up to 3 sets of 10 reps on each leg.",
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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(ExercisePage());
  });
}

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key? key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red.withOpacity(0),
          elevation: 0,
        ),
        backgroundColor: buttonColor,
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(height: MediaQuery.of(context).size.height,
              enableInfiniteScroll: false,
              autoPlay: false,),
            items: exercises.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return i;
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
List<Widget> exercises= [
  ExerciseColumn(current: 0),
  ExerciseColumn(current: 1),
  ExerciseColumn(current: 2),
];

class ExerciseColumn extends StatelessWidget {
  const ExerciseColumn({
    Key? key,
    required int current,
  }) : _current = current, super(key: key);

  final int _current;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: MediaQuery.of(context).size.height*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(imageList[_current]),
                ),
              )),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -1),
                    blurRadius: 5,
                    color: Colors.black12,
                  )
                ],
                borderRadius: BorderRadius.all(
                 Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding:
                      EdgeInsets.only(top: 25, left: 25, right: 25),
                      child: Column(
                        children: <Widget>[
                          Text(
                            nameList[_current],
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),

                          SizedBox(height: 3),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  descList[_current],
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.cyan,shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),minimumSize: Size(MediaQuery.of(context).size.width*0.3, MediaQuery.of(context).size.width*0.07)),
                      onPressed: () {},
                      child: Text("Done"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}

class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Deneme'),
        centerTitle: true,
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: bgcolor,
                  title: Text('To-Do List'),
                  content: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -80.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter Course Name',
                                  icon: Icon(Icons.local_activity_sharp),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Enter the activity to do',
                                  icon: Icon(Icons.description),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Save'),
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                    )
                  ],
                );
              },
            );
          },
          child: Text("Open To-Do menu"),
        ),
      ),
    );
  }
}
