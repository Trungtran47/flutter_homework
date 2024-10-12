import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import '../model/chatroom.dart';

class ApiService {
  final String baseUrl = "http://192.168.1.5:8080/api/users"; // URL

  Future<String> login(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body; // Thành công
    } else {
      throw Exception(' ${response.body}');
    }
  }

  Future<String> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return response.body; // Thành công
    } else {
      throw Exception('Đăng ký thất bại: ${response.body}');
    }
  }

  Future<List<ChatRoom>> getChatRooms() async {
    final response = await http.get(Uri.parse('$baseUrl/messager'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((chat) => ChatRoom.fromJson(chat)).toList();
    } else {
      throw Exception('Không thể lấy danh sách tin nhắn');
    }
  }

Future<ChatRoom> sendMessage(ChatRoom chatRoom) async {
  final response = await http.post(
    Uri.parse('$baseUrl/send'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(chatRoom.toJson()),
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return ChatRoom.fromJson(data);
  } else {
    throw Exception('Gửi tin nhắn thất bại: ${response.body}');
  }
}

}
