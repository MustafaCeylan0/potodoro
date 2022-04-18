import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

Map gifs = {
  'rain':
      'https://media4.giphy.com/media/Mgq7EMQUrhcvC/giphy.gif?cid=ecf05e47ocpvoo0urelqhyttsfh2c7kwp80lvd39veowc05e&rid=giphy.gif&ct=g',
  'fire':
      'https://media0.giphy.com/media/ynx1sj5Wz2atO/giphy.gif?cid=ecf05e47zlfci64mq30pjzedbcm36agn2bpuwxq395uk89pk&rid=giphy.gif&ct=g',
  'river':
      'https://media1.giphy.com/media/2csuIJj6TmuKA/giphy.gif?cid=ecf05e47cwv9jwjteajqfytv61c35iktas0qpu9uqwmzoxzc&rid=giphy.gif&ct=g'
};
Map local_visuals = {
  'rain_image': 'assets/rain_image.webp',
  'rain_gif': 'assets/rain_gif.webp',
  'river_image': 'assets/river_image.png',
  'river_gif': 'assets/river_gif.webp',
  'fire_image': 'assets/fire_image.png',
  'fire_gif': 'assets/fire_gif.gif'
};

class BottomSheet extends ConsumerWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<WhiteNoise> wns = ref.watch(whiteNoisesProvider);
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: wns.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding:
                      EdgeInsets.only(top: 5.0, left: 5, right: 5, bottom: 10),
                  child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //play or stop **
                              ref
                                  .read(whiteNoisesProvider.notifier)
                                  .toggle(index);

                              //print("id = $index isplaying = ${!ref.watch(wntProvider.notifier).whiteNoiseTileData.isPlaying} ");
                            },
                            child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: !wns[index].isPlaying
                                        ? AssetImage(wns[index].imageLoc)
                                        : AssetImage(wns[index].gifLoc),
                                  ),
                                )),
                          ),
                          !wns[index].isPlaying
                              ? Material()
                              : SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    activeTrackColor: Colors.cyan,
                                    inactiveTrackColor: Colors.grey,
                                    trackShape: RectangularSliderTrackShape(),
                                    trackHeight: 4.0,
                                    thumbColor: Colors.cyan,
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 6),
                                    overlayColor: Colors.red.withAlpha(32),
                                    overlayShape: RoundSliderOverlayShape(
                                        overlayRadius: 14),
                                  ),
                                  child: Container(
                                    height: 15,
                                    width: 105,
                                    child: Slider(
                                      min: 0,
                                      max: 1,
                                      value: wns[index].vol,
                                      onChanged: (nValue) {
                                        ref
                                            .read(whiteNoisesProvider.notifier)
                                            .changeVol(index, nValue);
                                      },
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                  ));
            }),
      ),
    );
  }
}

BoxDecoration whiteNoiseContainerDec() =>
    BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.green);
final wntProvider = StateNotifierProvider((ref) => WhiteNoiseTileST());

class WNTile {
  double volume = 0.2;
  bool isPlaying = false;
}

class WhiteNoiseTiles {
  List<WNTile> tiles = [WNTile(), WNTile()];
}

class WhiteNoiseTileST extends StateNotifier<WhiteNoiseTileData> {
  WhiteNoiseTileData whiteNoiseTileData = WhiteNoiseTileData(0.2, false);

  WhiteNoiseTileST() : super(WhiteNoiseTileData(0.3, false));

  double get getVolume {
    return whiteNoiseTileData.volume;
  }

  bool get playing {
    return whiteNoiseTileData.isPlaying;
  }

  void toggle() {
    whiteNoiseTileData.isPlaying = !whiteNoiseTileData.isPlaying;
    state = WhiteNoiseTileData(
        whiteNoiseTileData.volume, !whiteNoiseTileData.isPlaying);
  }

  void changeVolume(double newVolume) {
    whiteNoiseTileData.volume = newVolume;
    state = WhiteNoiseTileData(newVolume, true);
  }
}

class WhiteNoiseTileData {
  static int total = 0;
  int id = total;
  double volume = 0.2;
  bool isPlaying = false;

  WhiteNoiseTileData(double volume, bool isPlaying) {
    id = total;
    total++;
  }
}

class WhiteNoises extends StateNotifier<List<WhiteNoiseTileData>> {
  WhiteNoises() : super([]);

  void add(WhiteNoiseTileData) {}
}

//V^3
final whiteNoisesProvider =
    StateNotifierProvider<WhiteNoisesNotifier, List<WhiteNoise>>((ref) {
  return WhiteNoisesNotifier();
});

@immutable
class WhiteNoise {
  int id;
  String imageLoc;
  String gifLoc;
  bool isPlaying;
  double vol;
  String audioLoc;

  WhiteNoise(
      {required this.id,
      required this.imageLoc,
      required this.gifLoc,
      required this.isPlaying,
      required this.vol,
      required this.audioLoc});

  WhiteNoise copyWith({int? nid, bool? nplaying, double? nvol}) {
    return WhiteNoise(
        id: nid ?? this.id,
        isPlaying: nplaying ?? this.isPlaying,
        imageLoc: this.imageLoc,
        gifLoc: this.gifLoc,
        vol: nvol ?? this.vol,
        audioLoc: this.audioLoc);
  }
}

class WhiteNoisesNotifier extends StateNotifier<List<WhiteNoise>> {
//create a new player

  WhiteNoisesNotifier()
      : super([
          WhiteNoise(
              id: 0,
              imageLoc: local_visuals['rain_image'],
              gifLoc: local_visuals['rain_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/rain_audio.m4a'),
          WhiteNoise(
              id: 1,
              imageLoc: local_visuals['river_image'],
              gifLoc: local_visuals['river_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/river_audio.m4a'),
          WhiteNoise(
              id: 2,
              imageLoc: local_visuals['fire_image'],
              gifLoc: local_visuals['fire_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/fire_audio.mp3'),
          WhiteNoise(
              id: 3,
              imageLoc: local_visuals['river_image'],
              gifLoc: local_visuals['river_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/river_audio.m4a'),
          WhiteNoise(
              id: 4,
              imageLoc: local_visuals['fire_image'],
              gifLoc: local_visuals['fire_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/fire_audio.mp3'),
          WhiteNoise(
              id: 5,
              imageLoc: local_visuals['rain_image'],
              gifLoc: local_visuals['rain_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/rain_audio.m4a'),
          WhiteNoise(
              id: 6,
              imageLoc: local_visuals['fire_image'],
              gifLoc: local_visuals['fire_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/fire_audio.mp3'),
          WhiteNoise(
              id: 7,
              imageLoc: local_visuals['rain_image'],
              gifLoc: local_visuals['rain_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/rain_audio.m4a'),
          WhiteNoise(
              id: 8,
              imageLoc: local_visuals['fire_image'],
              gifLoc: local_visuals['fire_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/fire_audio.mp3'),
          WhiteNoise(
              id: 9,
              imageLoc: local_visuals['fire_image'],
              gifLoc: local_visuals['fire_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/fire_audio.mp3'),
          WhiteNoise(
              id: 10,
              imageLoc: local_visuals['rain_image'],
              gifLoc: local_visuals['rain_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/rain_audio.m4a'),
          WhiteNoise(
              id: 11,
              imageLoc: local_visuals['fire_image'],
              gifLoc: local_visuals['fire_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: 'assets/fire_audio.mp3'),
        ]);

  Future<void> toggle(int wnId) async {
    state = [
      for (final wn in state)
        if (wn.id == wnId)
          wn.copyWith(nplaying: !wn.isPlaying)
        else
          // other todos are not modified
          wn,
    ];
    var audioPlayer = Players[wnId];

    if (state[wnId].isPlaying) {
      await audioPlayer.setAsset(state[wnId].audioLoc);
      await audioPlayer.setLoopMode(LoopMode.one);
      audioPlayer.play();
    } else {
      audioPlayer.stop();
    }
  }

  Future<void> changeVol(int wnId, nVol) async {
    var audioPlayer = Players[wnId];

    state = [
      for (final wn in state)
        if (wn.id == wnId) wn.copyWith(nvol: nVol) else wn,
    ];
    await audioPlayer.setVolume(nVol);
  }
}

//PLAYERS
final List<AudioPlayer> Players = [
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
  AudioPlayer(),
];
