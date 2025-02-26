import 'package:flutter/material.dart';
import 'package:popgame/core/extension/avs_extensions.dart';
import 'package:popgame/core/functions/app_size.dart';
import 'package:popgame/core/functions/def_sizedbox.dart';

class ModuleCard extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;
  const ModuleCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            width: appWidth(context) / 9,
            height: appWidth(context) / 9,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover)),
          ),
          defNormalSizedBox,
          Text(
            title.toUpperCaseTR(),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
