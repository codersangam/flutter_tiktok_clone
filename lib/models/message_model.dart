class MessageModel {
  String? message;
  bool? seen;
  String? sender;
  DateTime? time;

  MessageModel({this.message, this.seen, this.sender, this.time});

  MessageModel.fromMap(Map<String, dynamic> map) {
    message = map['message'];
    seen = map['seen'];
    sender = map['sender'];
    time = map['time'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'seen': seen,
      'sender': sender,
      'time': time,
    };
  }
}
