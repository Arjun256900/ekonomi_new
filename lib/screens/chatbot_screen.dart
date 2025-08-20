import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/widgets/back_button.dart';
import 'package:flutter/material.dart';

class Chatbot extends StatelessWidget {
  const Chatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Positioned.fill(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: BackButtonLeading(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      height: 46,
                      width: 106,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(194, 224, 229, 1),
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: const Text(
                        "History",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              body: const ChatConvo(),
              bottomNavigationBar: const ChatInputBar(),
            ),
          ),
        ),
      ],
    );
  }
}

class ChatConvo extends StatefulWidget {
  const ChatConvo({super.key});

  @override
  State<ChatConvo> createState() => _ChatConvoState();
}

class _ChatConvoState extends State<ChatConvo> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [];

  final List<String> suggestions = [
    "Give me tips to save more this month.",
    "What goal is closest to completion?",
    "What is the status of my apartment savings goal?",
  ];

  void _addMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.insert(0, {"user": text});
    });

    // Simulated bot reply
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        messages.insert(0, {"bot": "You said: $text"});
      });
    });
  }

  Widget _buildMessageBubble(Map<String, String> msg) {
    if (msg.containsKey("user")) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              12,
            ).copyWith(bottomRight: const Radius.circular(0)),
          ),
          child: Text(
            msg["user"]!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(195, 224, 228, 1),
            borderRadius: BorderRadius.circular(
              12,
            ).copyWith(bottomLeft: const Radius.circular(0)),
          ),
          child: Text(
            msg["bot"]!,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: suggestions.map((s) {
                return GestureDetector(
                  onTap: () => _addMessage(s),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(6, 139, 147, 0.25),
                      ),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      s,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        : ListView.builder(
            reverse: true,
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return _buildMessageBubble(messages[index]);
            },
          );
  }
}

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      // Use Navigator to access ChatConvo state or pass callback via constructor
      // For now just print
      print("Message sent: $text");
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(6, 139, 147, 0.18),
      padding: const EdgeInsets.only(bottom: 60, left: 10, right: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                hintText: "Enter the message",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
