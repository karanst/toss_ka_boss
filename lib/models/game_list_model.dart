class TournamentModel {
  String? id;
  String? gameName;
  String? images;
  String? entryFee;
  String? winnerPrize;
  String? usersLimit;
  String? timeLimit;
  String? endTime;
  String? startDateTime;
  String? dateAdded;
  bool? isJoined;
  int? joinedUsers;

  TournamentModel(
      {this.id,
        this.gameName,
        this.images,
        this.entryFee,
        this.winnerPrize,
        this.usersLimit,
        this.timeLimit,
        this.endTime,
        this.startDateTime,
        this.dateAdded,
        this.isJoined,
        this.joinedUsers});

  TournamentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameName = json['game_name'];
    images = json['images'];
    entryFee = json['entry_fee'];
    winnerPrize = json['winner_prize'];
    usersLimit = json['users_limit'];
    timeLimit = json['time_limit'];
    endTime = json['end_date_time'];
    startDateTime = json['start_date_time'];
    dateAdded = json['date_added'];
    isJoined = json['is_joined'];
    joinedUsers = json['joined_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_name'] = this.gameName;
    data['images'] = this.images;
    data['entry_fee'] = this.entryFee;
    data['winner_prize'] = this.winnerPrize;
    data['users_limit'] = this.usersLimit;
    data['time_limit'] = this.timeLimit;
    data['end_date_time'] = this.endTime;
    data['start_date_time'] = this.startDateTime;
    data['date_added'] = this.dateAdded;
    data['is_joined'] = this.isJoined;
    data['joined_users'] = this.joinedUsers;
    return data;
  }
}

