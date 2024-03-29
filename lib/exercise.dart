import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const bgcolor = Color(0xFFe5f0f8);
const buttonColor = Color(0xff2f4569);
final List<String> imageList = [
  "assets/kneetoelbow.gif",
  "assets/legextensions.gif",
  "assets/pull.gif",
  "assets/armcircle.webp",
  "assets/chestsqueeze.gif",
  "assets/pressup.gif",
  "assets/chairdips.gif",
  "assets/kneetucks.gif",
  "assets/cheststretch.gif",
  "assets/modplanks.jpg",
  "assets/chairsquat.jpg",
  "assets/modsquat.jpg",
  "assets/heelslide.jpg",
  "assets/calfraise.jpg"
];
final List<String> nameList = [
  'Oblique Twist',
  'Leg Extensions',
  'Chair Slide',
  'Arm Circles',
  'Chest Squeeze',
  'Seated Press Up',
  "Chair Dips",
  'Knee Tucks',
  "Chest Stretch",
  "Modified Planks",
  "Chair Squat",
  "Modified Squats",
  "Heel Slides",
  "Seated Calf Raises"
];
final List<String> descList = [
  "Place an ankle weight around each ankle. Sit upright with good posture, lift your left knee upward toward your chest and touch your knee with your right elbow. Slowly return to the starting position, then repeat with the right leg and left elbow. This exercise will help improve your co-ordination, core strength, leg strength and hip mobility.",
  "Sit on the edge of your chair with your arms by your sides. Extend your right leg out straight and flex your foot so that just the right heel is on the floor (keeping your foot flexed engages the muscles in the shins and ankle). Lift your leg up as high as you can without rounding your back. Hold for 3 counts then lower. Repeat with the other leg. Work up to 3 sets of 10 reps on each leg.",
  "If you have a chair with wheels, sit and extend both legs forward, toes up and heels on the floor. Keeping the rest of your body still, press your heels into the floor as you bend your knees and try to bring the chair toward your feet. Extend your legs again and repeat. If you're in a regular chair, place your heels on a towel on a slick floor (or wear socks), and draw the towel toward your chair. Straighten your legs and slide the towel out again to return to the starting position. Do up to 10 reps.",
  "Raise your arms straight out to your sides like in a T and press your shoulder blades together. Extend arms with palms down, thumbs facing forward, and do 20 forward circles with your arms. Flip your palms up, thumbs facing behind you, and do 20 backward circles with your arms. Repeat 2 to 3 times.",
  "Form a goalpost with your arms: Keep your upper arms (shoulders to elbows) parallel to the floor and your lower arms (elbows to hands) perpendicular to it. Bring your forearms together in front of your face. Press forearms together and lift arms 1 inch, squeezing through chest. Return your arms to the starting point, squeezing your shoulder blades together, and repeat as long as you can hold proper form. Your back, chest, and arms will get a workout.",
  "Sitting in a chair with your feet firmly planted on the floor, place your hands on the arm rests of the chair and press down, raising your body off the chair. Extend your arms straight and allow your hips and buttocks to lift up off the chair. Keep your head lined up over your pelvis. Allow your spine to “dangle” and unravel straight down, creating space between each vertebrae. Hold this position or push up and down to work the backs of the arms more. Repeat 4 times if holding; work up to 3 sets of 10 reps if lifting and lowering.",
  "Sit on the edge of your chair with your arms by your sides, palms on the edge of the seat, fingers over the edge. Shift your body weight forward and lower down off the chair. Hold your body suspended for 5 counts and then push up back onto the seat. Work up to 3 sets of 10 reps.",
  "Sit tall (chest high and shoulders down) on the front half of your chair. Grasp the sides lightly with your hands and lean back slightly as you tighten your abs and bring your right knee up to chest height. Lower it as you raise your left knee on the next rep. Alternate sides. If you get really good at this, try lifting both knees at once, even just a few inches. Do up to 5 reps per leg.",
  "Sit upright in your normal chair. Sit tall away from the back of the chair.Reach behind with both arms and grasp the chair back, then press your chest upwards and forwards until you feel a stretch across your chest and the front of your shoulders.Hold for 10-20 seconds",
  "The plank exercise is known for being one of the most popular core exercises for any age. The exercise increases tension on the core, causing the body to keep stable. Training with this movement will help in a variety of ways, one being the ability to keep good posture while seated.",
  "This exercise should be started off with the older adult’s own body weight. If they feel like it’s too easy and their body feels good about the movement, they can add weight by carrying a medicine ball or another of-equal-to weight object.",
  "It doesn’t matter what age we are, squatting is noted as one of the most beneficial exercises a person can perform. However, not everyone can perform a typical squat; sometimes assistance is needed.",
  "If a senior is currently experiencing major knee pain, this might not be a suitable exercise due to pressure sustained on the joints. If a senior does have knee pain, they should keep the pressure to a minimum so as not to agitate the joint. To protect the floor from damage, grab a towel or a blanket and place it on the ground in front of the chair.",
  "If a senior is feeling tense in their calves and it isn’t very easy to squat, calf raises might help stretch those tense muscles or joints around the lower part of the leg."
];

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MaterialApp(home: ExercisePage()));
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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 11),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.3,
                        MediaQuery.of(context).size.width * 0.07)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done"),
              ),
            )
          ],
        ),
        backgroundColor: buttonColor,
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              enableInfiniteScroll: false,
              autoPlay: false,
            ),
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

List<Widget> exercises = [
  ExerciseColumn(current: 0),
  ExerciseColumn(current: 1),
  ExerciseColumn(current: 2),
  ExerciseColumn(current: 3),
  ExerciseColumn(current: 4),
  ExerciseColumn(current: 5),
  ExerciseColumn(current: 6),
  ExerciseColumn(current: 7),
  ExerciseColumn(current: 8),
  ExerciseColumn(current: 9),
  ExerciseColumn(current: 10),
  ExerciseColumn(current: 11),
  ExerciseColumn(current: 12),
  ExerciseColumn(current: 13),
];

class ExerciseColumn extends StatelessWidget {
  const ExerciseColumn({
    Key? key,
    required int current,
  })  : _current = current,
        super(key: key);

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
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.3,
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                      padding: EdgeInsets.only(top: 25, left: 25, right: 25),
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
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
