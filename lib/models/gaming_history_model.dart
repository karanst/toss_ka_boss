/// status : true
/// message : "user Gaming Transactions"
/// data : [{"username":"niti","game_name":"Chess","id":"35","user_id":"189","game_id":"4","amount":"50","status":"Winner","total_return_amount":"90","winner_status":"1","created_at":"2022-09-06 20:03:56","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Snakes","id":"36","user_id":"189","game_id":"6","amount":"152","status":"Winner","total_return_amount":"273.6","winner_status":"1","created_at":"2022-09-06 20:06:27","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Snakes","id":"44","user_id":"189","game_id":"6","amount":"23","status":"Winner","total_return_amount":"41.4","winner_status":"1","created_at":"2022-09-06 20:16:59","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Ladder","id":"45","user_id":"189","game_id":"9","amount":"11","status":"Winner","total_return_amount":"19.8","winner_status":"1","created_at":"2022-09-06 20:32:27","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Ladder","id":"46","user_id":"189","game_id":"9","amount":"25","status":"Winner","total_return_amount":"45","winner_status":"1","created_at":"2022-09-06 20:36:11","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Alpha Race","id":"47","user_id":"189","game_id":"18","amount":"2","status":"Winner","total_return_amount":"3.6","winner_status":"1","created_at":"2022-09-06 20:39:42","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Snakes","id":"50","user_id":"189","game_id":"6","amount":"5","status":"Winner","total_return_amount":"9","winner_status":"1","created_at":"2022-09-07 12:29:08","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Ladder","id":"51","user_id":"189","game_id":"9","amount":"2","status":"Winner","total_return_amount":"3.6","winner_status":"1","created_at":"2022-09-07 12:31:40","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Snakes","id":"52","user_id":"189","game_id":"6","amount":"5","status":"Winner","total_return_amount":"9","winner_status":"1","created_at":"2022-09-07 12:47:09","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Snakes","id":"54","user_id":"189","game_id":"6","amount":"2","status":"Winner","total_return_amount":"3.6","winner_status":"1","created_at":"2022-09-07 14:02:40","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"59","user_id":"189","game_id":"20","amount":"200","status":"Winner","total_return_amount":"360","winner_status":"1","created_at":"2022-09-08 11:19:12","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"62","user_id":"189","game_id":"4","amount":"111","status":"Winner","total_return_amount":"199.8","winner_status":"1","created_at":"2022-09-08 12:37:25","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"67","user_id":"189","game_id":"20","amount":"500","status":"Winner","total_return_amount":"900","winner_status":"1","created_at":"2022-09-12 21:33:21","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"69","user_id":"189","game_id":"4","amount":"12","status":"Winner","total_return_amount":"21.6","winner_status":"1","created_at":"2022-09-13 11:38:53","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Ladder","id":"70","user_id":"189","game_id":"9","amount":"10","status":"Winner","total_return_amount":"18","winner_status":"1","created_at":"2022-09-13 11:40:17","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"71","user_id":"189","game_id":"4","amount":"12","status":"Winner","total_return_amount":"21.6","winner_status":"1","created_at":"2022-09-13 11:40:32","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"72","user_id":"189","game_id":"4","amount":"12","status":"Winner","total_return_amount":"21.6","winner_status":"1","created_at":"2022-09-13 11:42:45","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Snakes","id":"73","user_id":"189","game_id":"6","amount":"2","status":"Winner","total_return_amount":"3.6","winner_status":"1","created_at":"2022-09-13 11:48:04","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"77","user_id":"189","game_id":"4","amount":"58","status":"Winner","total_return_amount":"104.4","winner_status":"1","created_at":"2022-09-27 12:20:48","updated_at":"2023-02-22 13:53:23"},{"username":"niti","game_name":"Chess","id":"78","user_id":"189","game_id":"20","amount":"12","status":"Winner","total_return_amount":"21.6","winner_status":"1","created_at":"2022-09-27 12:21:18","updated_at":"2023-02-22 13:53:23"}]

class GamingHistoryModel {
  GamingHistoryModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GamingHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
GamingHistoryModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GamingHistoryModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// username : "niti"
/// game_name : "Chess"
/// id : "35"
/// user_id : "189"
/// game_id : "4"
/// amount : "50"
/// status : "Winner"
/// total_return_amount : "90"
/// winner_status : "1"
/// created_at : "2022-09-06 20:03:56"
/// updated_at : "2023-02-22 13:53:23"

class Data {
  Data({
      String? username, 
      String? gameName, 
      String? id, 
      String? userId, 
      String? gameId, 
      String? amount, 
      String? status, 
      String? totalReturnAmount, 
      String? winnerStatus, 
      String? createdAt, 
      String? updatedAt,}){
    _username = username;
    _gameName = gameName;
    _id = id;
    _userId = userId;
    _gameId = gameId;
    _amount = amount;
    _status = status;
    _totalReturnAmount = totalReturnAmount;
    _winnerStatus = winnerStatus;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _username = json['username'];
    _gameName = json['game_name'];
    _id = json['id'];
    _userId = json['user_id'];
    _gameId = json['game_id'];
    _amount = json['amount'];
    _status = json['status'];
    _totalReturnAmount = json['total_return_amount'];
    _winnerStatus = json['winner_status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _username;
  String? _gameName;
  String? _id;
  String? _userId;
  String? _gameId;
  String? _amount;
  String? _status;
  String? _totalReturnAmount;
  String? _winnerStatus;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? username,
  String? gameName,
  String? id,
  String? userId,
  String? gameId,
  String? amount,
  String? status,
  String? totalReturnAmount,
  String? winnerStatus,
  String? createdAt,
  String? updatedAt,
}) => Data(  username: username ?? _username,
  gameName: gameName ?? _gameName,
  id: id ?? _id,
  userId: userId ?? _userId,
  gameId: gameId ?? _gameId,
  amount: amount ?? _amount,
  status: status ?? _status,
  totalReturnAmount: totalReturnAmount ?? _totalReturnAmount,
  winnerStatus: winnerStatus ?? _winnerStatus,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get username => _username;
  String? get gameName => _gameName;
  String? get id => _id;
  String? get userId => _userId;
  String? get gameId => _gameId;
  String? get amount => _amount;
  String? get status => _status;
  String? get totalReturnAmount => _totalReturnAmount;
  String? get winnerStatus => _winnerStatus;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['game_name'] = _gameName;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['game_id'] = _gameId;
    map['amount'] = _amount;
    map['status'] = _status;
    map['total_return_amount'] = _totalReturnAmount;
    map['winner_status'] = _winnerStatus;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}