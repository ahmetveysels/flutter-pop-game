import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:popgame/core/functions/app_size.dart';
import 'package:popgame/core/functions/is_null_or_empty.dart';
import 'package:popgame/core/widgets/show_lottie_animasyon.dart';
import 'package:popgame/screen/game_page/controller/game_controller.dart';
import 'package:popgame/screen/game_page/functions/calculate_left_width.dart';
import 'package:popgame/screen/game_page/model/object_model.dart';

class ObjectCard extends StatefulWidget {
  final ObjectModel item;

  ObjectCard({required this.item}) : super(key: item.key);

  @override
  State<ObjectCard> createState() => _ObjectCardState();
}

class _ObjectCardState extends State<ObjectCard> {
  final _audio = AudioPlayer();
  final _gameController = Get.put(GameController());
  var random = Random();
  final RxBool exploded = false.obs;
  final RxDouble dy = 0.0.obs;

  int speed = 4;

  @override
  void initState() {
    super.initState();
    bool isBalloon = isNullOrEmpty(widget.item.title.trim());
    if (isBalloon) {
      dy.value = ((_gameController.cardObjectSize.value.width * (1 / _gameController.balloonAspectRatio)) * -1);
    } else {
      dy.value = (_gameController.cardObjectSize.value.width * (1 / _gameController.alphabertAspectRatio)) * -1;
    }
    
    String audioCategory = "";
    if (!isNullOrEmpty(widget.item.title.trim())) {
      audioCategory = "assets/voices/${widget.item.title.toLowerCase()}.mp3";
    } else {
      audioCategory = "assets/voices/balloon_pop.mp3";
    }
    _audio.setAsset(audioCategory);

    // dy.value = -_gameController.cardObjectSize.value.height;
    // Bu değerler de dışarı taşınacak
    speed = random.nextInt(1) + 6;

    // _gameController.lastTimerValue.listen((int tickVal) {
    //   Future.microtask(() {
    //     dx.value += (speed / 8);
    //     if (dx.value > appWidth(context)) {
    //       _gameController.removeItemForObjectList(widget.item);
    //     }
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _audio.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Future.microtask(() => true);
      },
      child: StreamBuilder<Object>(
          stream: _gameController.lastTimerValue.stream,
          builder: (context, snapshot) {
            // avsPrint(snapshot.data.toString());
            Future.microtask(() {
              dy.value += (speed / 4);
              if (dy.value > appHeight(context)) {
                _gameController.removeItemForObjectList(widget.item);
              }
            });
            return Obx(() => Positioned(
                  left: calculateLeftWidth(context, widget.item.objectAlignIndex),
                  bottom: dy.value,
                  child: SizedBox(
                    width: _gameController.cardObjectSize.value.width,
                    child: AspectRatio(
                      aspectRatio: isNullOrEmpty(widget.item.title.trim()) ? _gameController.balloonAspectRatio : _gameController.alphabertAspectRatio,
                      child: AnimatedCrossFade(
                          firstChild: InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              // debugPrint("${widget.item.title} clicked");

                              _audio.play();
                              // await changeAssetAudio(audioCategory, audioID: widget.item.key.toString());
                              await Future.delayed(const Duration(milliseconds: 250));
                              exploded.value = true;
                              await Future.delayed(const Duration(seconds: 1));
                              Future.microtask(() {
                                if (widget.item.title.isNotEmpty && widget.item.title == _gameController.tempAllObject[_gameController.activeObjectIndexIndex.value]) {
                                  int tempLength = _gameController.activeObjectIndexIndex.value + 1;
                                  if (tempLength >= _gameController.tempAllObject.length) {
                                    _gameController.activeObjectIndexIndex.value = 0;
                                  } else {
                                    _gameController.activeObjectIndexIndex.value = tempLength;
                                  }
                                }
                                _gameController.removeItemForObjectList(widget.item);
                              });
                            },
                            child: isNullOrEmpty(widget.item.title.trim()) ? AVSLottieAnimation(jsonPath: "assets/balloons/${widget.item.objectAlignIndex + 1}.json") : AVSLottieAnimation(jsonPath: "assets/alphabet/${widget.item.title.trim().toUpperCase()}.json"),
                          ),
                          secondChild: const AVSLottieAnimation(jsonPath: "assets/lottie/explode2.json", repeat: false),
                          crossFadeState: exploded.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 50)),
                    ),
                  ),
                ));
          }),
    );
  }
}
