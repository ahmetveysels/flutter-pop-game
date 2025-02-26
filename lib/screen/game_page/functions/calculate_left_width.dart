import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:popgame/screen/game_page/controller/game_controller.dart';

double calculateLeftWidth(BuildContext context, int alignIndex) {
  final gameController = Get.put(GameController());

  // double objectDusenPay = gameController.gameCardboardSize.width / gameController.maxObjectLength.length;

  double cardWidth = gameController.cardObjectSize.value.width;

  return (alignIndex * cardWidth) ;
}
