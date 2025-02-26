import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popgame/core/functions/app_size.dart';
import 'package:popgame/core/functions/avs_print.dart';
import 'package:popgame/core/settings/enums.dart';
import 'package:popgame/core/widgets/background.dart';
import 'package:popgame/core/widgets/view_widget_size.dart';
import 'package:popgame/screen/game_page/controller/game_controller.dart';
import 'package:popgame/screen/game_page/game_page.dart';
import 'package:popgame/screen/homepage/components/module_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _gameController = Get.put(GameController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackgraundWidget(),
          // SizedBox(
          //   width: appWidth(context),
          //   height: appHeight(context) + 50,
          //   child: const AVSLottieAnimation(jsonPath: "assets/day and night.json"),
          // ),
          SafeArea(
            bottom: false,
            child: WidgetSize(
              onChange: (p0) {
                _gameController.gameCardboardSize = p0;
                avsPrint("gameCardboardSize: $p0");
                _gameController.maxObjectLength = List.generate((p0.width / _gameController.cardObjectSize.value.width).floor(), (index) => index);
                double va = _gameController.gameCardboardSize.width / _gameController.maxObjectLength.length;
                _gameController.cardObjectSize.value = Size(va, va);
                avsPrint("maxObjectLength: ${_gameController.maxObjectLength}");
              },
              child: SizedBox(
                width: appWidth(context),
                height: appHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "POP GAME",
                          style: TextStyle(fontSize: 60),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ModuleCard(title: "alphabet", icon: "assets/images/abc.png", onTap: () => Get.to(() => const GamePage(gameMode: GameModes.alphabet))),
                          const SizedBox(width: 60),
                          ModuleCard(title: "numbers", icon: "assets/images/numbers.png", onTap: () => Get.to(() => const GamePage(gameMode: GameModes.number))),
                        ],
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: const Text("Harfler"),
                    // ),
                    // defSizedBox,
                    // TextButton(
                    //   onPressed: () {
                    //     Get.to(() => const GamePage(gameMode: GameModes.number));
                    //   },
                    //   child: const Text("numbers"),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// burada listeden oluşan son 3 değerde eğer kategori değeri gelmemişse kategori getirme işlemi yapılacak