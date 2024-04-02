// import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';


class AmountWidget extends StatelessWidget {
  final image;
  final amount;
  final colors;
  final title;
  final padding;
  AmountWidget({this.image, this.amount, this.colors, this.title, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      width: Get.width *.4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: Get.width *.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  height: 25,
                  width: 25,
                  image: AssetImage(image),
                  color: colors,
                ),
                SizedBox(
                  height: double.parse(padding),
                ),
                Text(title,
                    maxLines: 1,
                    style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 12, color: AppColors.textColorBlack, fontWeight: FontWeight.w500))
              ],
            ),
          ),
          // SizedBox(
          //   width: 5,
          // ),
          Container(
              width: 70,
              decoration:  BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.textColorBlack,
                    width: 1.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        amount,
                        style:  TextStyle(
                          fontSize: 14,
                          color: AppColors.textColorBlack,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                     Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textColorBlack,
                      size: 12,
                    ),
                  ],
                ),
              )),

          // Text.rich(
          //   TextSpan(
          //     text: amount,
          //     style: TextStyle(
          //       fontSize: 22,
          //       color: Color(0xFF652981),
          //       decoration: TextDecoration.underline,
          //     ),
          //     children: <TextSpan>[
          //       TextSpan(
          //           text: '>',
          //           style: TextStyle(
          //             decoration: TextDecoration.underline,
          //             color: Color(0xFF652981),
          //           )),
          //       // can add more TextSpans here...
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
