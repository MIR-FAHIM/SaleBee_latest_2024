// To parse this JSON data, do
//
//     final getAllExpenseModel = getAllExpenseModelFromJson(jsonString);

import 'dart:convert';

GetAllExpenseModel getAllExpenseModelFromJson(String str) => GetAllExpenseModel.fromJson(json.decode(str));

String getAllExpenseModelToJson(GetAllExpenseModel? data) => json.encode(data!.toJson());

class GetAllExpenseModel {
  GetAllExpenseModel({
    this.message,
    this.result,
    this.isSuccess,
  });

  String? message;
  List<ResultAllExpense>? result;
  bool? isSuccess;

  factory GetAllExpenseModel.fromJson(Map<String, dynamic> json) => GetAllExpenseModel(
    message: json["Message"],
    result: json["Result"] == null ? [] : List<ResultAllExpense>.from(json["Result"]!.map((x) => ResultAllExpense.fromJson(x))),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result == null ? [] : List<dynamic>.from(result!.map((x) => x!.toJson())),
    "IsSuccess": isSuccess,
  };
  double getTotalAmount({String? specificType, int? empId}) {
    if (result != null && result!.isNotEmpty) {
      return result!
          .where((expense) =>
      specificType == null || expense.type == specificType  )
          .map((expense) => expense.cost ?? 0)
          .reduce((a, b) => a + b);
    } else {
      return 0.0;
    }
  }
}

class ResultAllExpense {
  ResultAllExpense({
    this.date,
    this.type,
    this.description,
    this.person,
    this.cost,
    this.status,
    this.empId,
    this.expenseID
  });

  DateTime? date;
  String? type;
  String? description;
  int? person;
  double? cost;
  int? status;
  int? empId;
  int? expenseID;

  factory ResultAllExpense.fromJson(Map<String, dynamic> json) => ResultAllExpense(
    date: DateTime.parse(json["Date"]),
    type: json["Type"] ==  null ? "Food" : json["Type"],
    empId: json["EmployeeId"],
    description: json["Description"],
    person: json["Person"],
    cost: json["Cost"],
    status: json["Status"] == null ? 0 : json["Status"],
    expenseID: json["ExpenseId"],
  );

  Map<String, dynamic> toJson() => {
    "Date": date?.toIso8601String(),
    "Type": type,
    "Description": description,
    "EmployeeId": empId,
    "Person": person,
    "Cost": cost,
    "Status": status,
    "ExpenseId": expenseID,
  };
}

enum Type { FOOD, TRANSPORT, OTHERS }

final typeValues = EnumValues({
  "Food": Type.FOOD,
  "Others": Type.OTHERS,
  "Transport": Type.TRANSPORT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
