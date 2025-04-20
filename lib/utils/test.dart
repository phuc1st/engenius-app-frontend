// import 'package:flutter/material.dart';
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FF),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//         title: const Text(
//           'Trúc cute',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         actions: const [
//           Icon(Icons.call, color: Colors.black),
//           SizedBox(width: 12),
//           Icon(Icons.videocam, color: Colors.black),
//           SizedBox(width: 12),
//         ],
//       ),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Center(
//               child: Chip(label: Text('Hôm nay')),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(12),
//               children: [
//                 Text("thú 6 ngày 12", textWidthBasis: TextWidthBasis.longestLine, textAlign: TextAlign.center,),
//                buildMsg(context, true, "Hello"),
//                 buildMsg(context, true, "ngắn"),
//                 buildMsg(context, false, "Hello"),
//                 buildMsg(context, true, "Hello"),
//                 buildMsg(context, false, "ngắn"),
//                 buildMsg(context, true, "dàiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"),
//                 buildMsg(context, false, "dàiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii"),
//               ],
//             ),
//           ),
//           _buildInputField(),
//         ],
//       ),
//     );
//   }
//
//   Widget buildMsg(BuildContext context, bool isSentByMe, String message) {
//     return Row(
//       // Dùng MainAxisAlignment để căn chỉnh vị trí tin nhắn
//       mainAxisAlignment:
//       isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Container(
//           // Giới hạn chiều rộng tối đa là 70% của màn hình
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width * 0.7,
//           ),
//           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
//           margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//           decoration: BoxDecoration(
//             // Nền màu khác nhau dựa trên người gửi
//             color: isSentByMe ? Colors.blue : Colors.grey[300],
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: Text(
//             message,
//             style: TextStyle(
//               color: isSentByMe ? Colors.white : Colors.black87,
//               fontSize: 16,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildImageBubble() {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.black,
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
//
//   Widget _buildInputField() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Soạn tin nhắn',
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(24),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),
//           const CircleAvatar(
//             backgroundColor: Color(0xFF256DFF),
//             child: Icon(Icons.mic, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() => runApp(const MaterialApp(home: ChatScreen()));
