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
  final TextEditingController _controller = TextEditingController();
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
      messages.insert(0, {
        "user": text,
      }); // insert at top since list is reversed
    });

    _controller.clear();

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
    return Column(
      children: [
        Expanded(
          child: messages.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 8,
                    children: suggestions.map((s) {
                      return GestureDetector(
                        onTap: () => _addMessage(s),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: Color.fromRGBO(6, 139, 147, 0.25),
                              strokeAlign: 1,
                            ),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              s,
                              style: TextStyle(fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
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
                ),
        ),
        Container(
          color: const Color.fromRGBO(6, 139, 147, 0.18),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.08,
            ),
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
                        onPressed: () {
                          final text = _controller.text.trim();
                          if (text.isNotEmpty) {
                            _addMessage(text);
                            _controller.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
