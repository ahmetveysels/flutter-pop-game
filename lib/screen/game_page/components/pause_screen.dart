import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popgame/core/functions/app_size.dart';
import 'package:popgame/screen/game_page/controller/game_controller.dart';

class PauseScreen extends StatelessWidget {
  PauseScreen({super.key});
  final _gameController = Get.put(GameController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => _gameController.isTimerPlaying.value
        ? const SizedBox()
        : Container(
            width: appWidth(context),
            height: appHeight(context),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.5),
            ),
            child: InkWell(
              onTap: () {
                final gameController = Get.put(GameController());
                gameController.playTimer();
              },
              child: SizedBox(
                width: appWidth(context),
                height: appHeight(context),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Paused",
                    style: TextStyle(fontSize: 50, fontFamily: "BoldFont"),
                  ),
                ),
              ),
            ),
          ));
  }
}
