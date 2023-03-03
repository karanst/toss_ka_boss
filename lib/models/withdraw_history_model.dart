/// error : false
/// message : "Withdrawal Request Retrieved Successfully"
/// data : [{"id":"21","user_id":"198","payment_type":"User","payment_address":"{\"UPI\" : \"8770496665@ybl\"}","amount_requested":"1000","remarks":null,"status":"0","date_created":"2023-03-01 13:47:52"}]
/// total : "1"

class WithdrawHistoryModel {
  WithdrawHistoryModel({
      bool? error, 
      String? message, 
      List<Data>? data, 
      String? total,}){
    _error = error;
    _message = message;
    _data = data;
    _total = total;
}

  WithdrawHistoryModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _total = json['total'];
  }
  bool? _error;
  String? _message;
  List<Data>? _data;
  String? _total;
WithdrawHistoryModel copyWith({  bool? error,
  String? message,
  List<Data>? data,
  String? total,
}) => WithdrawHistoryModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  total: total ?? _total,
);
  bool? get error => _error;
  String? get message => _message;
  List<Data>? get data => _data;
  String? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    return map;
  }

}

/// id : "21"
/// user_id : "198"
/// payment_type : "User"
/// payment_address : "{\"UPI\" : \"8770496665@ybl\"}"
/// amount_requested : "1000"
/// remarks : null
/// status : "0"
/// date_created : "2023-03-01 13:47:52"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? paymentType, 
      String? paymentAddress, 
      String? amountRequested, 
      dynamic remarks, 
      String? status, 
      String? dateCreated,}){
    _id = id;
    _userId = userId;
    _paymentType = paymentType;
    _paymentAddress = paymentAddress;
    _amountRequested = amountRequested;
    _remarks = remarks;
    _status = status;
    _dateCreated = dateCreated;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _paymentType = json['payment_type'];
    _paymentAddress = json['payment_address'];
    _amountRequested = json['amount_requested'];
    _remarks = json['remarks'];
    _status = json['status'];
    _dateCreated = json['date_created'];
  }
  String? _id;
  String? _userId;
  String? _paymentType;
  String? _paymentAddress;
  String? _amountRequested;
  dynamic _remarks;
  String? _status;
  String? _dateCreated;
Data copyWith({  String? id,
  String? userId,
  String? paymentType,
  String? paymentAddress,
  String? amountRequested,
  dynamic remarks,
  String? status,
  String? dateCreated,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  paymentType: paymentType ?? _paymentType,
  paymentAddress: paymentAddress ?? _paymentAddress,
  amountRequested: amountRequested ?? _amountRequested,
  remarks: remarks ?? _remarks,
  status: status ?? _status,
  dateCreated: dateCreated ?? _dateCreated,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get paymentType => _paymentType;
  String? get paymentAddress => _paymentAddress;
  String? get amountRequested => _amountRequested;
  dynamic get remarks => _remarks;
  String? get status => _status;
  String? get dateCreated => _dateCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['payment_type'] = _paymentType;
    map['payment_address'] = _paymentAddress;
    map['amount_requested'] = _amountRequested;
    map['remarks'] = _remarks;
    map['status'] = _status;
    map['date_created'] = _dateCreated;
    return map;
  }

}