
import 'package:badges/badges.dart' as badges;


import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee_latest/routes/app_pages.dart';
import 'package:salebee_latest/utils/AppColors/app_colors.dart';

class DraggableCircularButton extends StatefulWidget {
  final String label;
  final String image;
  final int index;
  final void Function(int oldIndex, int newIndex) onDrop;
  final double top;
  final double left;

  DraggableCircularButton({
    required this.label,
    required this.image,
    required this.index,

    required Key key,
    required this.onDrop,
    required this.top,
    required this.left,
  }) : super(key: key);

  @override
  DraggableCircularButtonState createState() => DraggableCircularButtonState();
}

class DraggableCircularButtonState extends State<DraggableCircularButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: DragTarget<int>(
        builder: (context, candidateData, rejectedData) {
          return GestureDetector(
            onTap: () {
              // Handle tap
            },
            child: Draggable<int>(
              data: widget.index,
              feedback: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue.withOpacity(0.5),
                child: Text(
                  widget.label,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              child: circleRow(
                badge: false,
                size: 0,
                option: widget.label

              ),
            ),
          );
        },
        onWillAccept: (data) {
          // Returning true means this Draggable can be accepted by this DragTarget
          return true;
        },
        onAccept: (data) {
          // When a Draggable is accepted, call the onDrop callback
          widget.onDrop(data, widget.index);
        },
      ),
    );
  }

  Widget circleRow({size, option, bool? badge}) {
    return SizedBox(
      width: 150,
      child: Row(
        children: [
          badge == true
              ? badges.Badge(
            badgeContent: Text("2"),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.greenAccent,
            ),
            child: InkWell(
              onTap: (){
                if(option == "Task"){
                  Get.toNamed(Routes.TASKVIEW);
                }else if(option == "Prospect"){
                  Get.toNamed(Routes.PROSPECTVIEW);
                }else if(option == "Lead"){
                  Get.toNamed(Routes.LEADVIEW);
                }else if(option == "Attendance"){
                  Get.toNamed(Routes.ATTENDANCEVIEW);
                }else if(option == "Visit"){
                  Get.toNamed(Routes.GETVISIT);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.colorBlue),
                // transform: Matrix4.translationValues(x, y, 0.0),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.ac_unit,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
              : InkWell(
            onTap: (){
              if(option == "Task"){
                Get.toNamed(Routes.TASKVIEW);
              }else if(option == "Prospect"){
                Get.toNamed(Routes.PROSPECTVIEW);

              }else if(option == "Attendance"){
                Get.toNamed(Routes.ATTENDANCEVIEW);

              }else if(option == "Lead"){
                Get.toNamed(Routes.LEADVIEW);

              }else if(option == "Visit"){
                Get.toNamed(Routes.GETVISIT);
              }
            },
                child: Container(
            decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.colorBlue),
            // transform: Matrix4.translationValues(x, y, 0.0),
            child:  Padding(
                padding: EdgeInsets.all(12.0),
                child: SizedBox(
                  height: Get.height*.05,
                    width: Get.width*.08,
                    child: Image.asset(widget.image!)),
            ),
          ),
              ),
          SizedBox(
            width: 5,
          ),
          Container(
            // transform: Matrix4.translationValues(x, y, 0.0),
              child: Text(
                '$option',
                style: const TextStyle(color: Colors.grey),
              ))
        ],
      ),
    );
  }
}