import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:popgame/core/functions/avs_print.dart';
import 'package:popgame/screen/game_page/components/object_card.dart';
import 'package:popgame/screen/game_page/model/object_model.dart';

class GameController extends GetxController {
  @override
  void onClose() {
    avsPrint("Close Çalıştı");
    lastTimerValue.value = 0;
    lastAlignIndexes = [];
    lastCategoriesOrBallonsID = [];
    objectCardList.value = [];
    tempAllObject.value = [];
    timer?.cancel();
    super.onClose();
  }

  var bgAudio = AudioPlayer();

  Timer? timer;
  final RxBool isTimerPlaying = false.obs;

  final _random = Random();

//Last alignIndexes
  List<int> lastAlignIndexes = [];

  // Last kategori veya balon index
  List<int> lastCategoriesOrBallonsID = [];

  // Lottie Ballons ratio
  final double balloonAspectRatio = 220 / 351;
  final double alphabertAspectRatio = 1;

  //Game Cardboard Size
  Size gameCardboardSize = const Size(100, 100);

  // Ekrana yerleştirilecek objelerin max sayısı
    List<int> maxObjectLength=[];

  // Timer Tick Values
  final RxInt lastTimerValue = 0.obs;

  // Ekranda Gösterilen Objeler
  final RxList<ObjectCard> objectCardList = <ObjectCard>[].obs;

  // Obje Boyutu
  final Rx<Size> cardObjectSize = Size(Get.width / 7, Get.width / 7).obs;

  // Kategoriye Göre Tüm Objeler
  final RxList<String> tempAllObject = <String>[].obs;

  // Kategoride tıklanmayı bekleyen obje indexi
  final RxInt activeObjectIndexIndex = 0.obs;

  Future<void> addItemForObjectList(ObjectModel item) async {
    objectCardList.add(ObjectCard(item: item));
  }

  Future<void> removeItemForObjectList(ObjectModel item) async {
    objectCardList.removeWhere((element) => element.item == item);
    avsPrint("$item removed");
  }

  void playPauseButtonFunction({bool firstStart = false}) {
    if (timer?.isActive == true) {
      pauseTimer();
    } else {
      playTimer();
    }
  }

  void pauseTimer() {
    timer?.cancel();
    bgAudio.pause();
    isTimerPlaying.value = timer?.isActive ?? false;
  }

  void playTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) async {
      await Future.delayed(const Duration(milliseconds: 3));
      lastTimerValue.value = lastTimerValue.value + 1;
      // avsPrint("GelenTimer: ${lastTimerValue.value}");
    });
    isTimerPlaying.value = timer?.isActive ?? false;
    bgAudio.play();
  }

  ObjectModel getNewObject(int lastAlign) {
    //TODO Burada last align 2 tane olması lazım en az
    List<int> tempObjectAlign = [];

    // Burada gelen değer eğer 1 ise oyun türüne göre değer alınacak değilse boş
    int val = _random.nextInt(5);

    if (lastCategoriesOrBallonsID.length > 5) {
      val = 1;
    } else if (lastCategoriesOrBallonsID.isEmpty && val == 1) {
      val = 2;
    }

    if (val != 1) {
      lastCategoriesOrBallonsID.add(val);
    } else {
      lastCategoriesOrBallonsID = [];
    }

    // Son değerler silinip ona göre konum ataması yapılacak
    try {
      // burada bir sorun var bakılacak
      tempObjectAlign.remove(lastAlign);
      for (var i = 0; i < maxObjectLength.length; i++) {
        if (maxObjectLength[i] != lastAlign) {
          tempObjectAlign.add(maxObjectLength[i]);
        }
      }
    } catch (e) {
      avsPrint("Silme hatası");
    }

    int alignIndex = tempObjectAlign.isEmpty ? 0 : _random.nextInt(tempObjectAlign.length);
    // burada sublist yapıp son 4 değere göre varmı yok mu yapılacak yukarıda temp align işlemi yapılmıi
    //     if (condition) {
    //     } else {
    //     }

    int align = tempObjectAlign.isEmpty ? 0 : tempObjectAlign[alignIndex];

    return ObjectModel(
      key: UniqueKey(),
      title: val == 1 ? tempAllObject[activeObjectIndexIndex.value] : "",
      objectAlignIndex: align,
      objectIndex: _random.nextInt(7),
    );
  }
}
