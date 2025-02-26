import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popgame/core/functions/app_size.dart';
import 'package:popgame/core/widgets/avs_toast.dart';
import 'package:popgame/screen/game_page/controller/game_controller.dart';

class GameAppBar extends StatelessWidget {
  const GameAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: appWidth(context),
      // decoration: BoxDecoration(color: Colors.white.withOpacity(.4)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onDoubleTap: () {
                Navigator.pop(context);
              },
              onTap: () => AVSToast.show("Çıkmak için çift tıklayın", context),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.home,
                  size: 50,
                  color: Colors.red,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                final gameController = Get.put(GameController());
                gameController.playPauseButtonFunction();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(
                  () {
                    final gameController = Get.put(GameController());
                    return gameController.isTimerPlaying.value
                        ? const Icon(
                            Icons.pause,
                            size: 50,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            size: 50,
                            color: Colors.red,
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
