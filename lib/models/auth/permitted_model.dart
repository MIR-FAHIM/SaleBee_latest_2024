// To parse this JSON data, do
//
//     final pemittedModel = pemittedModelFromJson(jsonString);

import 'dart:convert';

PemittedModel pemittedModelFromJson(String str) => PemittedModel.fromJson(json.decode(str));

String pemittedModelToJson(PemittedModel data) => json.encode(data.toJson());

class PemittedModel {
  String? message;
  List<Result>? result;
  bool? isSuccess;

  PemittedModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory PemittedModel.fromJson(Map<String, dynamic> json) => PemittedModel(
    message: json["Message"],
    result: List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
    "IsSuccess": isSuccess,
  };
}

class Result {
  int id;
  String label;
  int parentId;
  String? className;
  int displayOrder;
  bool menuVisibility;

  Result({
    required this.id,
    required this.label,
    required this.parentId,
    required this.className,
    required this.displayOrder,
    required this.menuVisibility,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["Id"],
    label: json["Label"],
    parentId: json["ParentId"],
    className: json["ClassName"],
    displayOrder: json["DisplayOrder"],
    menuVisibility: json["MenuVisibility"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Label": label,
    "ParentId": parentId,
    "ClassName": className,
    "DisplayOrder": displayOrder,
    "MenuVisibility": menuVisibility,
  };
}
