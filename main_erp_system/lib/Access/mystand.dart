import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class StandardModel {
  String? standardName;
  List<StandardItems>? standardItems;

  StandardModel({this.standardName, this.standardItems});

  // StandardModel.fromJson(Map<String, dynamic> json) {
  //   standardName = json['standard_name'];
  //   if (json['standard_items'] != null) {
  //     standardItems = <StandardItems>[];
  //     json['standard_items'].forEach((v) {
  //       standardItems!.add(StandardItems.fromJson(v));
  //     });
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['standard_name'] = standardName;
    if (standardItems != null) {
      data['standard_items'] = standardItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StandardItems {
  String? inventoryName;
  int? inventoryQuantity;

  StandardItems({this.inventoryName, this.inventoryQuantity});

  // StandardItems.fromJson(Map<String, dynamic> json) {
  //   inventoryName = json['inventory_name'];
  //   inventoryQuantity = json['inventory_quantity'];
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inventory_name'] = this.inventoryName;
    data['inventory_quantity'] = this.inventoryQuantity;
    return data;
  }
}

// final stobj = StandardModel.fromJson(res.body);


// stobj.toJson()
