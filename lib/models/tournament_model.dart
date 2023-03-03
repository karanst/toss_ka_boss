// /// status : true
// /// msg : "Game list"
// /// data : [{"id":"38","game_name":"Toss Ka Boss","images":"https://developmentalphawizz.com/Gaming/uploads/media/2022/unnamed.png","entry_fee":"100.00","winner_prize":"200.00","users_limit":"0","status":"1","time_limit":"20","end_date_time":"2023-03-02 19:05:00","start_date_time":"2023-03-02 18:59:00","is_joined":false,"joined_users":0,"gameslab":[{"id":"62409","slab":"2023-03-02 18:59:00","game_id":"38","user_id":"0","remining_time":""},{"id":"62410","slab":"2023-03-02 19:10:00","game_id":"38","user_id":"0","remining_time":""}]}]
//
// class TournamentModel {
//   TournamentModel({
//       bool? status,
//       String? msg,
//       List<GameData>? data,}){
//     _status = status;
//     _msg = msg;
//     _data = data;
// }
//
//   TournamentModel.fromJson(dynamic json) {
//     _status = json['status'];
//     _msg = json['msg'];
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(GameData.fromJson(v));
//       });
//     }
//   }
//   bool? _status;
//   String? _msg;
//   List<GameData>? _data;
// TournamentModel copyWith({  bool? status,
//   String? msg,
//   List<GameData>? data,
// }) => TournamentModel(  status: status ?? _status,
//   msg: msg ?? _msg,
//   data: data ?? _data,
// );
//   bool? get status => _status;
//   String? get msg => _msg;
//   List<GameData>? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['msg'] = _msg;
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// id : "38"
// /// game_name : "Toss Ka Boss"
// /// images : "https://developmentalphawizz.com/Gaming/uploads/media/2022/unnamed.png"
// /// entry_fee : "100.00"
// /// winner_prize : "200.00"
// /// users_limit : "0"
// /// status : "1"
// /// time_limit : "20"
// /// end_date_time : "2023-03-02 19:05:00"
// /// start_date_time : "2023-03-02 18:59:00"
// /// is_joined : false
// /// joined_users : 0
// /// gameslab : [{"id":"62409","slab":"2023-03-02 18:59:00","game_id":"38","user_id":"0","remining_time":""},{"id":"62410","slab":"2023-03-02 19:10:00","game_id":"38","user_id":"0","remining_time":""}]
//
// class GameData {
//   GameData({
//       String? id,
//       String? gameName,
//       String? images,
//       String? entryFee,
//       String? winnerPrize,
//       String? usersLimit,
//       String? status,
//       String? timeLimit,
//       String? endDateTime,
//       String? startDateTime,
//       bool? isJoined,
//       num? joinedUsers,
//       List<Gameslab>? gameslab,}){
//     _id = id;
//     _gameName = gameName;
//     _images = images;
//     _entryFee = entryFee;
//     _winnerPrize = winnerPrize;
//     _usersLimit = usersLimit;
//     _status = status;
//     _timeLimit = timeLimit;
//     _endDateTime = endDateTime;
//     _startDateTime = startDateTime;
//     _isJoined = isJoined;
//     _joinedUsers = joinedUsers;
//     _gameslab = gameslab;
// }
//
//   GameData.fromJson(dynamic json) {
//     _id = json['id'];
//     _gameName = json['game_name'];
//     _images = json['images'];
//     _entryFee = json['entry_fee'];
//     _winnerPrize = json['winner_prize'];
//     _usersLimit = json['users_limit'];
//     _status = json['status'];
//     _timeLimit = json['time_limit'];
//     _endDateTime = json['end_date_time'];
//     _startDateTime = json['start_date_time'];
//     _isJoined = json['is_joined'];
//     _joinedUsers = json['joined_users'];
//     if (json['gameslab'] != null) {
//       _gameslab = [];
//       json['gameslab'].forEach((v) {
//         _gameslab?.add(Gameslab.fromJson(v));
//       });
//     }
//   }
//   String? _id;
//   String? _gameName;
//   String? _images;
//   String? _entryFee;
//   String? _winnerPrize;
//   String? _usersLimit;
//   String? _status;
//   String? _timeLimit;
//   String? _endDateTime;
//   String? _startDateTime;
//   bool? _isJoined;
//   num? _joinedUsers;
//   List<Gameslab>? _gameslab;
// GameData copyWith({  String? id,
//   String? gameName,
//   String? images,
//   String? entryFee,
//   String? winnerPrize,
//   String? usersLimit,
//   String? status,
//   String? timeLimit,
//   String? endDateTime,
//   String? startDateTime,
//   bool? isJoined,
//   num? joinedUsers,
//   List<Gameslab>? gameslab,
// }) => GameData(  id: id ?? _id,
//   gameName: gameName ?? _gameName,
//   images: images ?? _images,
//   entryFee: entryFee ?? _entryFee,
//   winnerPrize: winnerPrize ?? _winnerPrize,
//   usersLimit: usersLimit ?? _usersLimit,
//   status: status ?? _status,
//   timeLimit: timeLimit ?? _timeLimit,
//   endDateTime: endDateTime ?? _endDateTime,
//   startDateTime: startDateTime ?? _startDateTime,
//   isJoined: isJoined ?? _isJoined,
//   joinedUsers: joinedUsers ?? _joinedUsers,
//   gameslab: gameslab ?? _gameslab,
// );
//   String? get id => _id;
//   String? get gameName => _gameName;
//   String? get images => _images;
//   String? get entryFee => _entryFee;
//   String? get winnerPrize => _winnerPrize;
//   String? get usersLimit => _usersLimit;
//   String? get status => _status;
//   String? get timeLimit => _timeLimit;
//   String? get endDateTime => _endDateTime;
//   String? get startDateTime => _startDateTime;
//   bool? get isJoined => _isJoined;
//   num? get joinedUsers => _joinedUsers;
//   List<Gameslab>? get gameslab => _gameslab;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['game_name'] = _gameName;
//     map['images'] = _images;
//     map['entry_fee'] = _entryFee;
//     map['winner_prize'] = _winnerPrize;
//     map['users_limit'] = _usersLimit;
//     map['status'] = _status;
//     map['time_limit'] = _timeLimit;
//     map['end_date_time'] = _endDateTime;
//     map['start_date_time'] = _startDateTime;
//     map['is_joined'] = _isJoined;
//     map['joined_users'] = _joinedUsers;
//     if (_gameslab != null) {
//       map['gameslab'] = _gameslab?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
//
// }
//
// /// id : "62409"
// /// slab : "2023-03-02 18:59:00"
// /// game_id : "38"
// /// user_id : "0"
// /// remining_time : ""
//
// class Gameslab {
//   Gameslab({
//       String? id,
//       String? slab,
//       String? gameId,
//       String? userId,
//       String? reminingTime,}){
//     _id = id;
//     _slab = slab;
//     _gameId = gameId;
//     _userId = userId;
//     _reminingTime = reminingTime;
// }
//
//   Gameslab.fromJson(dynamic json) {
//     _id = json['id'];
//     _slab = json['slab'];
//     _gameId = json['game_id'];
//     _userId = json['user_id'];
//     _reminingTime = json['remining_time'];
//   }
//   String? _id;
//   String? _slab;
//   String? _gameId;
//   String? _userId;
//   String? _reminingTime;
// Gameslab copyWith({  String? id,
//   String? slab,
//   String? gameId,
//   String? userId,
//   String? reminingTime,
// }) => Gameslab(  id: id ?? _id,
//   slab: slab ?? _slab,
//   gameId: gameId ?? _gameId,
//   userId: userId ?? _userId,
//   reminingTime: reminingTime ?? _reminingTime,
// );
//   String? get id => _id;
//   String? get slab => _slab;
//   String? get gameId => _gameId;
//   String? get userId => _userId;
//   String? get reminingTime => _reminingTime;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['slab'] = _slab;
//     map['game_id'] = _gameId;
//     map['user_id'] = _userId;
//     map['remining_time'] = _reminingTime;
//     return map;
//   }
//
// }