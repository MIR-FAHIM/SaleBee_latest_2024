import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerLinkWidget extends StatelessWidget {
  final String? icon;
  final String? text;
  final ValueChanged<void>? onTap;
  const DrawerLinkWidget({
    Key? key,
    this.icon,
    this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!('');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Image(
              image: AssetImage(icon!),
              height: 30,
              width: 30,
            ),
            icon != null
                ? Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              width: 1,
              height: 28,
              color: Get.theme.dividerColor.withOpacity(0.2),
            )
                : Wrap(),
            Expanded(
              child: Text(text!.tr, style: Get.textTheme.bodyText2!.merge(TextStyle(fontSize: 16))),
            ),
          ],
        ),
      ),
    );
  }
}
