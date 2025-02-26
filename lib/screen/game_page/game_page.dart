import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:popgame/core/settings/enums.dart';
import 'package:popgame/core/widgets/background.dart';
import 'package:popgame/screen/game_page/components/game_appbar.dart';
import 'package:popgame/screen/game_page/components/pause_screen.dart';
import 'package:popgame/screen/game_page/controller/game_controller.dart';
import 'package:popgame/screen/game_page/functions/get_all_object.dart';
import 'package:popgame/screen/game_page/model/object_model.dart';

class GamePage extends StatefulWidget {
  final GameModes gameMode;
  const GamePage({super.key, required this.gameMode});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with WidgetsBindingObserver {
  final _gameController = Get.put(GameController());
  final String text = "";
  final RxInt streamIntValue = 0.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _gameController.onClose();

    // Kategoriye göre tüm objeleri getir
    _gameController.tempAllObject.value = getAllObject(widget.gameMode);

    _gameController.activeObjectIndexIndex.value = 0;

    _gameController.playTimer();
    _gameController.bgAudio = AudioPlayer();
    _gameController.bgAudio.setAsset("assets/music/backgroundmusic2.mp3");
    _gameController.bgAudio.setLoopMode(LoopMode.all);
    _gameController.bgAudio.setVolume(0.06);
    _gameController.bgAudio.play();
  }

  @override
  void dispose() {
    _gameController.onClose();
    _gameController.bgAudio.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint("State: $state");
    if (state != AppLifecycleState.resumed) {
      _gameController.pauseTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _gameController.timer?.cancel();
        return true;
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     _gameController.playPauseButtonFunction();
        //   },
        //   child: const Icon(Icons.add),
        // ),
        body: Stack(
          children: [
            const BackgraundWidget(),
            SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  StreamBuilder(
                    stream: _gameController.lastTimerValue.stream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        // int valuem = snapshot.data;
                        streamIntValue.value++;
                        int valuem = streamIntValue.value;
                        // avsPrint("İşlemYapılan: $valuem");
                        bool firstTimer = (valuem) == 0;
                        bool normalValue = (valuem) % 100 == 0;
                        bool aNormalValue = (_gameController.objectCardList.length < 3 && (valuem) % 50 == 0);
                        // avsPrint("SnapHot: $valuem,firstTimer: $firstTimer, normalValue: $normalValue, aNormalValue: $aNormalValue");
                        if (firstTimer || normalValue || aNormalValue) {
                          // avsPrint("LastTimer: ${_gameController.lastTimerValue.value}, SnapShot: $valuem}}");
                          int tAlign = 0;
                          if (_gameController.objectCardList.isNotEmpty) {
                            tAlign = _gameController.objectCardList.last.item.objectAlignIndex;
                          }
                          // avsPrint("message1");
                          ObjectModel tempV = _gameController.getNewObject(tAlign);
                          // avsPrint("message2");
                          _gameController.addItemForObjectList(tempV);
                          // avsPrint("message3");
                        }
                      }
                      return Obx(
                        () => _gameController.objectCardList.isNotEmpty
                            ? Stack(
                                children: _gameController.objectCardList,
                              )
                            : const Center(
                                child: Text("No Object"),
                              ),
                      );
                    },
                  ),
                  const GameAppBar(),
                ],
              ),
            ),
            PauseScreen(),
          ],
        ),
      ),
    );
  }
}
