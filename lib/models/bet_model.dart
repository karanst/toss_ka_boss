import 'package:concoin/utils/constant.dart';

class BetModel {
  String? id;
  String? type;
  String? typeId;
  String? image;
  String? dateAdded;

  BetModel({this.id, this.type, this.typeId, this.image, this.dateAdded});

  BetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    typeId = json['type_id'];
    image = imageUrl + json['image'];
    dateAdded = json['date_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['type_id'] = this.typeId;
    data['image'] = this.image;
    data['date_added'] = this.dateAdded;
    return data;
  }
}

class ChoiceModel {
  String? id;
  String? amount;

  ChoiceModel({this.id, this.amount});

  ChoiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    return data;
  }
}
