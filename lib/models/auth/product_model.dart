// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String? message;
  Result? result;
  bool? isSuccess;

  ProductModel({
     this.message,
     this.result,
     this.isSuccess,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    message: json["Message"],
    result: Result.fromJson(json["Result"]),
    isSuccess: json["IsSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "Result": result!.toJson(),
    "IsSuccess": isSuccess,
  };
}

class Result {
  int total;
  int page;
  int itemsPerPage;
  List<Product> data;

  Result({
    required this.total,
    required this.page,
    required this.itemsPerPage,
    required this.data,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    total: json["total"],
    page: json["page"],
    itemsPerPage: json["itemsPerPage"],
    data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "itemsPerPage": itemsPerPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Product {
  int id;
  String? productName;
  int productCategoryId;
  int? productSubCategoryId;
  int productUnitId;
  double? estimatedSellingPrice;
  String? description;
  bool? companyItem;
  bool? supplierItem;
  bool active;
  int createdBy;
  DateTime createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  ProductCategoryObj productCategoryObj;
  ProductCategoryObj productSubCategoryObj;

  Product({
    required this.id,
    required this.productName,
    required this.productCategoryId,
    required this.productSubCategoryId,
    required this.productUnitId,
    required this.estimatedSellingPrice,
    required this.description,
    required this.companyItem,
    required this.supplierItem,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    required this.productCategoryObj,
    required this.productSubCategoryObj,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["ID"],
    productName: json["ProductName"] ?? "No Data",
    productCategoryId: json["ProductCategoryId"],
    productSubCategoryId: json["ProductSubCategoryId"],
    productUnitId: json["ProductUnitID"],
    estimatedSellingPrice: json["EstimatedSellingPrice"],
    description: json["Description"],
    companyItem: json["CompanyItem"],
    supplierItem: json["SupplierItem"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
    productCategoryObj: ProductCategoryObj.fromJson(json["ProductCategoryObj"]),
    productSubCategoryObj: ProductCategoryObj.fromJson(json["ProductSubCategoryObj"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "ProductName": productName,
    "ProductCategoryId": productCategoryId,
    "ProductSubCategoryId": productSubCategoryId,
    "ProductUnitID": productUnitId,
    "EstimatedSellingPrice": estimatedSellingPrice,
    "Description": description,
    "CompanyItem": companyItem,
    "SupplierItem": supplierItem,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn?.toIso8601String(),
    "ProductCategoryObj": productCategoryObj.toJson(),
    "ProductSubCategoryObj": productSubCategoryObj.toJson(),
  };
}

class ProductCategoryObj {
  int id;
  String? name;
  String? description;
  bool active;
  int? createdBy;
  DateTime? createdOn;
  int? updatedBy;
  DateTime? updatedOn;
  int? productCategoryId;
  ProductCategoryObj? productCategoryObj;

  ProductCategoryObj({
    required this.id,
    required this.name,
    required this.description,
    required this.active,
    required this.createdBy,
    required this.createdOn,
    required this.updatedBy,
    required this.updatedOn,
    this.productCategoryId,
    this.productCategoryObj,
  });

  factory ProductCategoryObj.fromJson(Map<String, dynamic> json) => ProductCategoryObj(
    id: json["ID"],
    name: json["Name"],
    description: json["Description"],
    active: json["Active"],
    createdBy: json["CreatedBy"],
    createdOn: json["CreatedOn"] == null ? null : DateTime.parse(json["CreatedOn"]),
    updatedBy: json["UpdatedBy"],
    updatedOn: json["UpdatedOn"] == null ? null : DateTime.parse(json["UpdatedOn"]),
    productCategoryId: json["ProductCategoryId"],
    productCategoryObj: json["ProductCategoryObj"] == null ? null : ProductCategoryObj.fromJson(json["ProductCategoryObj"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Description": description,
    "Active": active,
    "CreatedBy": createdBy,
    "CreatedOn": createdOn?.toIso8601String(),
    "UpdatedBy": updatedBy,
    "UpdatedOn": updatedOn?.toIso8601String(),
    "ProductCategoryId": productCategoryId,
    "ProductCategoryObj": productCategoryObj?.toJson(),
  };
}
