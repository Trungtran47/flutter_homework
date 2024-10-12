import 'package:flutter/material.dart';
import 'package:lab_6/service/api_service.dart';
import 'model/user.dart';
import './model/chatroom.dart';
import 'custom/CustomSnackBar.dart';
import 'Login.dart';

class ChatPage extends StatefulWidget {
  final User userEmail; // Email của người dùng đăng nhập
  const ChatPage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ApiService apiService = ApiService();
  final TextEditingController messagerEditingController =
      TextEditingController();
  final ScrollController _scrollController =
      ScrollController(); // Tạo ScrollController
  late Future<List<ChatRoom>> chatRooms;
  List<ChatRoom> chatList = [];

  @override
  void initState() {
    super.initState();
    fetchChatRooms(); // Lấy danh sách tin nhắn từ API
  }

  void fetchChatRooms() async {
    chatRooms = apiService.getChatRooms();
    chatList = await chatRooms;
    setState(() {
      // Cuộn xuống cuối danh sách khi dữ liệu được tải
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void sendMessage() async {
    ChatRoom chatRoom = ChatRoom(
      message: messagerEditingController.text,
      user: widget.userEmail,
      time: DateTime.now().toIso8601String(), // Thêm giá trị thời gian hiện tại
    );

    try {
      ChatRoom message =
          await apiService.sendMessage(chatRoom); // Gọi API gửi tin nhắn
      CustomSnackBar.show(context, 'Gửi tin nhắn thành công');
      // Thêm tin nhắn mới vào danh sách và cập nhật giao diện
      setState(() {
        chatList.add(message);
        messagerEditingController.clear(); // Xóa nội dung tin nhắn sau khi gửi
        // Cuộn xuống cuối danh sách khi có tin nhắn mới
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(top: 30, left: 10, right: 10),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  LoginPage()), // Điều hướng về trang LoginPage
        );
        return Future.value(false); // Ngăn hành động quay lại mặc định
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Tin nhắn")),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<ChatRoom>>(
                future: chatRooms,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text("Có lỗi xảy ra: ${snapshot.error}"));
                  } else if (!snapshot.hasData ||
                      snapshot.data!.isEmpty && chatList.isEmpty) {
                    return const Center(child: Text("Không có tin nhắn nào."));
                  } else {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        ChatRoom chat = chatList[index];
                        bool isMine = chat.user.email == widget.userEmail.email;

                        return Align(
                          alignment: isMine
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  isMine ? Colors.blue[100] : Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: isMine
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chat.user.email,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(chat.message),
                                Text(
                                  chat.time,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messagerEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Enter a message',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
