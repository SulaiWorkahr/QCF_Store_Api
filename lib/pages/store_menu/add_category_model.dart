// To parse this JSON data, do
//
//     final addCategorymodel = addCategorymodelFromJson(jsonString);

import 'dart:convert';

import 'package:namstore/pages/store_menu/category_list_model.dart';

AddCategorymodel addCategorymodelFromJson(String str) =>
    AddCategorymodel.fromJson(json.decode(str));

String addCategorymodelToJson(AddCategorymodel data) =>
    json.encode(data.toJson());

class AddCategorymodel {
  String status;
  String code;
  String message;

  AddCategorymodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory AddCategorymodel.fromJson(Map<String, dynamic> json) =>
      AddCategorymodel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  List<CategoryList>? get list => null;

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
