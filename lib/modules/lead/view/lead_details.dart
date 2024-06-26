import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:salebee_latest/api_provider/api_url.dart';
import 'package:salebee_latest/models/auth/get_all_prospect_by_id_model.dart';

import 'package:salebee_latest/modules/prospect/controller/prospect_controller.dart';

import 'package:salebee_latest/utils/AppColors/app_colors.dart';


class LeadDetailsView extends GetView<ProspectController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProspectResult data = Get.arguments[0];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(

        title:  Text('Prospect Details',style: TextStyle(
          color: AppColors.textColorBlack,fontSize: 24,

        ),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            // color: Colors.blueLight.withOpacity(.6),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('Prospect:',style: TextStyle(
                            color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text(data.prospectName!,style: TextStyle(
                                fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Stage:',style: TextStyle(
                            color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text(data.stage!,style: TextStyle(
                                fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Industry:',style: TextStyle(
                            color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Text(data.industry!,style: TextStyle(
                                fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600
                            ),),
                          )
                      )
                    ],
                  ),
                  // const SizedBox(height: 5,),
                  // const Divider(thickness: 1,color: Colors.grey,),
                  // const SizedBox(height: 5,),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Text('Prospect for:',style: TextStyle(
                  //           color: text,fontSize: 12, fontWeight: FontWeight.w400
                  //       ),),
                  //     ),
                  //     Flexible(
                  //         flex: 3,
                  //         child: Padding(
                  //           padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                  //           child: Text('',style: TextStyle(
                  //               fontSize: 12, color: text, fontWeight: FontWeight.w600
                  //           ),),
                  //         )
                  //     )
                  //   ],
                  // ),


                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Created on:',style: TextStyle(
                            color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat.yMMM().format(data.createdOn!),style: TextStyle(
                                    fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600
                                ),),

                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Created by:',style: TextStyle(
                            color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data.createdBy.toString(),style: TextStyle(
                                    fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600
                                ),),

                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Text('Assign to:',style: TextStyle(
                            color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                        ),),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data.assignTo!.toString(),style: TextStyle(
                                        fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600
                                    ),),

                                  ],
                                ),

                              ],
                            ),
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),

                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Concern Person: ',style: TextStyle(
                              color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                          ),),
                          Container(
                            height: 20,
                            color:
                            Colors.blue,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      4,
                                  child: Text(
                                    "Contact person",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      4,
                                  child: Text(
                                    "Designation",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width /
                                      4,
                                  child: Text(
                                    "Mobile",
                                    style: TextStyle(
                                        color: Colors
                                            .white,
                                        fontSize:
                                        14,
                                        fontWeight:
                                        FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      )
                  ),
                  Container(
                    height: 80,
                    child: ListView.builder(
                        itemCount: data.concernPerson!.length,
                        itemBuilder: (BuildContext  context, int  index){
                          var concern = data.concernPerson![index];


                          return Container(
                            height: 40,
                            color:
                            Colors.white,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 4,
                                  child:
                                  Text(
                                    concern.name!,
                                    style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                ),

                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 3.5,
                                  child:
                                  concern.designation == null ?
                                  Text(
                                    "No Data",
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ):
                                  Text(
                                    concern.designation!,
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),

                                Container(
                                  width:
                                  MediaQuery.of(context).size.width / 4,
                                  child:
                                  concern.mobile == null?
                                  Text(
                                    concern.mobile!,
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  )
                                      : Text(
                                    concern.mobile!,
                                    style:
                                    TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                )

                              ],
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 5,),
                  const Divider(thickness: 1,color: Colors.grey,),
                  Row(
                    children: [
                      Text('Important note: ',style: TextStyle(
                          color: Colors.black54,fontSize: 12, fontWeight: FontWeight.w400
                      ),),
                      Container(
                        width: MediaQuery.of(
                            context)
                            .size
                            .width *
                            .6,
                        child: Text(data.importantNote!,
                          style: TextStyle(
                            fontSize: 12, color: Colors.black54, fontWeight: FontWeight.normal,

                          ),
                          maxLines: 4,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      //Get.to(AddLogFollowUp(prospectID: widget.prospectId, prospect: widget.prospectName,));
                    },
                    child: Container(
                      height: 30,
                      width: 120,

                      decoration:  BoxDecoration(

                          shape: BoxShape.rectangle,
                          color: Colors.blue,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10.0))),


                      child: Center(child: Text("Add Followup", style: TextStyle(fontSize: 12, color: Colors.white),)),
                    ),
                  ),
                  // Container(
                  //     height: 300,
                  //     child: FollowUpList(prospectId: widget.prospectId,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//
