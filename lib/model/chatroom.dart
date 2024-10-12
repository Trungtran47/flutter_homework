import './user.dart';

class ChatRoom {
  final String message;
  final User user;
  final String time;

  ChatRoom({
    required this.message,
    required this.user,
    required this.time,
  });
  // Chuyển từ đối tượng User sang JSON
  Map<String, dynamic> toJson() {
    return {'message': message, 'user': user, 'time': time};
  }

  // Chuyển đổi từ JSON sang đối tượng ChatRoom
  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      message: json['message'],
      user: User.fromJson(json['user']), // Chuyển đổi từ JSON sang User
      time: json['time'],
    );
  }
}
