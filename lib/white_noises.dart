import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

Map local_visuals = {
  //brown campfire fan fireplace rain river ocean shower thunder
  'brown_image': 'assets/wn/image/brown.jpg',
  'brown_gif': 'assets/wn/gif/brown.webp',
  'brown_audio': 'assets/wn/ogg/brown.ogg',

  'campfire_image': 'assets/wn/image/campfire.png',
  'campfire_gif': 'assets/wn/gif/campfire.gif',
  'campfire_audio': 'assets/wn/ogg/campfire.ogg',

  'fan_image': 'assets/wn/image/fan.jpg',
  'fan_gif': 'assets/wn/gif/fan.webp',
  'fan_audio': 'assets/wn/ogg/fan.ogg',

  'fireplace_image': 'assets/wn/image/fireplace.jpg',
  'fireplace_gif': 'assets/wn/gif/fireplace.webp',
  'fireplace_audio': 'assets/wn/ogg/fireplace.ogg',

  'rain_image': 'assets/wn/image/rain.webp',
  'rain_gif': 'assets/wn/gif/rain.webp',
  'rain_audio': 'assets/wn/ogg/rain.ogg',

  'river_image': 'assets/wn/image/river.png',
  'river_gif': 'assets/wn/gif/river.webp',
  'river_audio': 'assets/wn/ogg/river.ogg',

  'ocean_image': 'assets/wn/image/ocean.jpg',
  'ocean_gif': 'assets/wn/gif/ocean.gif',
  'ocean_audio': 'assets/wn/ogg/ocean.ogg',

  'shower_image': 'assets/wn/image/shower.jpg',
  'shower_gif': 'assets/wn/gif/shower.webp',
  'shower_audio': 'assets/wn/ogg/shower.ogg',

  'thunder_image': 'assets/wn/image/thunder.jpg',
  'thunder_gif': 'assets/wn/gif/thunder.webp',
  'thunder_audio': 'assets/wn/ogg/thunder.ogg'
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
              imageLoc: local_visuals['brown_image'],
              gifLoc: local_visuals['brown_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['brown_audio']),
          WhiteNoise(
              id: 1,
              imageLoc: local_visuals['campfire_image'],
              gifLoc: local_visuals['campfire_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['campfire_audio']),
          WhiteNoise(
              id: 2,
              imageLoc: local_visuals['fan_image'],
              gifLoc: local_visuals['fan_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['fan_audio']),
          WhiteNoise(
              id: 3,
              imageLoc: local_visuals['fireplace_image'],
              gifLoc: local_visuals['fireplace_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['fireplace_audio']),
          WhiteNoise(
              id: 4,
              imageLoc: local_visuals['rain_image'],
              gifLoc: local_visuals['rain_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['rain_audio']),
          WhiteNoise(
              id: 5,
              imageLoc: local_visuals['river_image'],
              gifLoc: local_visuals['river_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['river_audio']),
          WhiteNoise(
              id: 6,
              imageLoc: local_visuals['ocean_image'],
              gifLoc: local_visuals['ocean_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['ocean_audio']),
          WhiteNoise(
              id: 7,
              imageLoc: local_visuals['shower_image'],
              gifLoc: local_visuals['shower_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['shower_audio']),
          WhiteNoise(
              id: 8,
              imageLoc: local_visuals['thunder_image'],
              gifLoc: local_visuals['thunder_gif'],
              isPlaying: false,
              vol: 1,
              audioLoc: local_visuals['thunder_audio']),
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
];
