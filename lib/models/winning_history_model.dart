/// status : true
/// message : "Winners"
/// data : [{"entry_fee":"50","winning_amount":"90","user_id":"189","user_name":"niti","user_email":"patodipalak09@gmail.com","user_phone":"9098368503"},{"entry_fee":"111","winning_amount":"199.8","user_id":"189","user_name":"niti","user_email":"patodipalak09@gmail.com","user_phone":"9098368503"},{"entry_fee":"12","winning_amount":"21.6","user_id":"189","user_name":"niti","user_email":"patodipalak09@gmail.com","user_phone":"9098368503"},{"entry_fee":"12","winning_amount":"21.6","user_id":"189","user_name":"niti","user_email":"patodipalak09@gmail.com","user_phone":"9098368503"},{"entry_fee":"12","winning_amount":"21.6","user_id":"189","user_name":"niti","user_email":"patodipalak09@gmail.com","user_phone":"9098368503"},{"entry_fee":"58","winning_amount":"104.4","user_id":"189","user_name":"niti","user_email":"patodipalak09@gmail.com","user_phone":"9098368503"},{"entry_fee":"55","winning_amount":"99","user_id":"198","user_name":"","user_email":"","user_phone":"9999996666"},{"entry_fee":"50","winning_amount":"90","user_id":"198","user_name":"","user_email":"","user_phone":"9999996666"}]

class WinningHistory {
  WinningHistory({
      bool? status, 
      String? message, 
      List<Winners>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  WinningHistory.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Winners.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Winners>? _data;
WinningHistory copyWith({  bool? status,
  String? message,
  List<Winners>? data,
}) => WinningHistory(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Winners>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// entry_fee : "50"
/// winning_amount : "90"
/// user_id : "189"
/// user_name : "niti"
/// user_email : "patodipalak09@gmail.com"
/// user_phone : "9098368503"

class Winners {
  Winners({
      String? entryFee, 
      String? winningAmount, 
      String? userId, 
      String? userName, 
      String? userEmail, 
      String? userPhone,}){
    _entryFee = entryFee;
    _winningAmount = winningAmount;
    _userId = userId;
    _userName = userName;
    _userEmail = userEmail;
    _userPhone = userPhone;
}

  Winners.fromJson(dynamic json) {
    _entryFee = json['entry_fee'];
    _winningAmount = json['winning_amount'];
    _userId = json['user_id'];
    _userName = json['user_name'];
    _userEmail = json['user_email'];
    _userPhone = json['user_phone'];
  }
  String? _entryFee;
  String? _winningAmount;
  String? _userId;
  String? _userName;
  String? _userEmail;
  String? _userPhone;
Winners copyWith({  String? entryFee,
  String? winningAmount,
  String? userId,
  String? userName,
  String? userEmail,
  String? userPhone,
}) => Winners(  entryFee: entryFee ?? _entryFee,
  winningAmount: winningAmount ?? _winningAmount,
  userId: userId ?? _userId,
  userName: userName ?? _userName,
  userEmail: userEmail ?? _userEmail,
  userPhone: userPhone ?? _userPhone,
);
  String? get entryFee => _entryFee;
  String? get winningAmount => _winningAmount;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userPhone => _userPhone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['entry_fee'] = _entryFee;
    map['winning_amount'] = _winningAmount;
    map['user_id'] = _userId;
    map['user_name'] = _userName;
    map['user_email'] = _userEmail;
    map['user_phone'] = _userPhone;
    return map;
  }

}