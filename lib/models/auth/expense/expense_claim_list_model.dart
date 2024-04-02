// To parse this JSON data, do
//
//     final newExpenseClaimModel = newExpenseClaimModelFromJson(jsonString);

import 'dart:convert';

NewExpenseClaimModel newExpenseClaimModelFromJson(String str) => NewExpenseClaimModel.fromJson(json.decode(str));

String newExpenseClaimModelToJson(NewExpenseClaimModel data) => json.encode(data.toJson());

class NewExpenseClaimModel {
  String? message;
  ResultClaim? result;
  bool? isSuccess;

  NewExpenseClaimModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory NewExpenseClaimModel.fromJson(Map<String, dynamic> json) => NewExpenseClaimModel(
    message: json["Message"],
    result: ResultClaim.fromJson(json["Result"]),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result!.toJson(),
    "IsSuccess": isSuccess,
  };
  double getTotalAmount({String? specificType, int? empId}) {
    if (result != null && result!.data.isNotEmpty) {
      // Filter expenses based on specific type
      var expenses = result!.data
          .where((expense) =>
      specificType == null || expense.expenseType == specificType)
          .toList();

      // Check if there are expenses with the specified type
      if (expenses.isEmpty) {
        return 0; // No expenses with the specified type found
      }

      // Calculate total amount
      return expenses
          .map((expense) => expense.cost ?? 0) // Use ?? operator to handle null cost
          .reduce((a, b) => a + b);
    } else {
      return 0; // No data available
    }
  }
}


class ResultClaim {
  int total;
  int page;
  int itemsPerPage;
  List<DatumClaim> data;
  List<Count> statusCount;
  List<Count> expenseTypeCount;

  ResultClaim({
    required this.total,
    required this.page,
    required this.itemsPerPage,
    required this.data,
    required this.statusCount,
    required this.expenseTypeCount,
  });

  factory ResultClaim.fromJson(Map<String, dynamic> json) => ResultClaim(
    total: json["total"],
    page: json["page"],
    itemsPerPage: json["itemsPerPage"],
    data: List<DatumClaim>.from(json["data"].map((x) => DatumClaim.fromJson(x))),
    statusCount: List<Count>.from(json["statusCount"].map((x) => Count.fromJson(x))),
    expenseTypeCount: List<Count>.from(json["expenseTypeCount"].map((x) => Count.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "itemsPerPage": itemsPerPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "statusCount": List<dynamic>.from(statusCount.map((x) => x.toJson())),
    "expenseTypeCount": List<dynamic>.from(expenseTypeCount.map((x) => x.toJson())),
  };

}


class DatumClaim {
  int id;
  String title;
  String? description;
  double cost;
  int personCount;
  dynamic prospectId;
  int expenseTypeId;
  DateTime expenseDate;
  int claimedBy;
  dynamic approvedBy;
  dynamic approvedDate;
  int statusId;
  dynamic reasonForUpdate;
  dynamic paymentDate;
  dynamic startLocation;
  dynamic endLocation;
  dynamic startLatitude;
  dynamic startLongitude;
  dynamic endLatitude;
  dynamic endLongitude;
  String expenseType;
  String status;
  dynamic prospectName;
  String claimedByName;
  dynamic approvedByName;
  bool active;
  int createdBy;
  DateTime? createdOn;
  dynamic updatedBy;
  dynamic updatedOn;
  bool isDeleted;

  DatumClaim({
    required this.id,
    required this.title,
    required this.description,
    required this.cost,
    required this.personCount,
    required this.prospectId,
    required this.expenseTypeId,
    required this.expenseDate,
    required this.claimedBy,
    required this.approvedBy,
    required this.approvedDate,
    required this.statusId,
    required this.reasonForUpdate,
    required this.paymentDate,
    required this.startLocation,
    required this.endLocation,
    required this.startLatitude,
    required this.startLongitude,
    required this.endLatitude,
    required this.endLongitude,
    required this.expenseType,
    required this.status,
    required this.prospectName,
    required this.claimedByName,
    required this.approvedByName,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.isDeleted,
  });

  factory DatumClaim.fromJson(Map<String, dynamic> json) => DatumClaim(
    id: json["ID"],
    title: json["Title"],
    description: json["Description"],
    cost: json["Cost"],
    personCount: json["PersonCount"],
    prospectId: json["ProspectId"],
    expenseTypeId: json["ExpenseTypeId"],
    expenseDate: DateTime.parse(json["ExpenseDate"]),
    claimedBy: json["ClaimedBy"],
    approvedBy: json["ApprovedBy"],
    approvedDate: json["ApprovedDate"],
    statusId: json["StatusId"],
    reasonForUpdate: json["ReasonForUpdate"],
    paymentDate: json["PaymentDate"],
    startLocation: json["StartLocation"],
    endLocation: json["EndLocation"],
    startLatitude: json["StartLatitude"],
    startLongitude: json["StartLongitude"],
    endLatitude: json["EndLatitude"],
    endLongitude: json["EndLongitude"],
    expenseType: json["ExpenseType"],
    status: json["Status"],
    prospectName: json["ProspectName"],
    claimedByName: json["ClaimedByName"],
    approvedByName: json["ApprovedByName"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"],
    isDeleted: json["IsDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Title": title,
    "Description": description,
    "Cost": cost,
    "PersonCount": personCount,
    "ProspectId": prospectId,
    "ExpenseTypeId": expenseTypeId,
    "ExpenseDate": expenseDate.toIso8601String(),
    "ClaimedBy": claimedBy,
    "ApprovedBy": approvedBy,
    "ApprovedDate": approvedDate,
    "StatusId": statusId,
    "ReasonForUpdate": reasonForUpdate,
    "PaymentDate": paymentDate,
    "StartLocation": startLocation,
    "EndLocation": endLocation,
    "StartLatitude": startLatitude,
    "StartLongitude": startLongitude,
    "EndLatitude": endLatitude,
    "EndLongitude": endLongitude,
    "ExpenseType": expenseType,
    "Status": status,
    "ProspectName": prospectName,
    "ClaimedByName": claimedByName,
    "ApprovedByName": approvedByName,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn,
    "IsDeleted": isDeleted,
  };
}

class Count {
  int id;
  String? type;
  int count;
  double totalAmount;
  String? status;

  Count({
    required this.id,
    this.type,
    required this.count,
    required this.totalAmount,
    this.status,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    id: json["ID"],
    type: json["Type"],
    count: json["Count"],
    totalAmount: json["TotalAmount"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Type": type,
    "Count": count,
    "TotalAmount": totalAmount,
    "Status": status,
  };
}
