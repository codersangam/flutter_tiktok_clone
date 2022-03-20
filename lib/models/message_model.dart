class MessageModel {
  String? messageId;
  String? message;
  bool? seen;
  String? sender;
  DateTime? time;

  MessageModel(
      {this.messageId, this.message, this.seen, this.sender, this.time});

  MessageModel.fromMap(Map<String, dynamic> map) {
    messageId = map['messageId'];
    message = map['message'];
    seen = map['seen'];
    sender = map['sender'];
    time = map['time'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'message': message,
      'seen': seen,
      'sender': sender,
      'time': time,
    };
  }
}
