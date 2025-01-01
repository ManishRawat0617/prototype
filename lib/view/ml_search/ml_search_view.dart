import 'package:flutter/material.dart';
import 'package:prototype/resources/constants/app_Colors.dart';
import 'package:prototype/view/ml_search/widget/ChatInputField.dart';

class MLSearchView extends StatefulWidget {
  @override
  _MLSearchViewState createState() => _MLSearchViewState();
}

class _MLSearchViewState extends State<MLSearchView> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": message});
    });

    _controller.clear();

    // Simulate chatbot response
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({"sender": "bot", "text": _getBotResponse(message)});
      });
    });
  }

  String _getBotResponse(String message) {
    // Dummy bot responses
    if (message.toLowerCase().contains("hello")) {
      return "Hi there! How can I assist you today?";
    } else if (message.toLowerCase().contains("help")) {
      return "Sure, I'm here to help! Please tell me more.";
    } else {
      return "Trying to find the expert for your problem ....";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chatbot"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/vectors/ml_serach.png', // Replace with your image path
                          height: 200,
                          width: 200,
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            " Your AI assistant designed to connect you with the perfect expert to solve your specific problem efficiently and effectively.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isUserMessage = message["sender"] == "user";
                      return Align(
                        alignment: isUserMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                isUserMessage ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message["text"]!,
                            style: TextStyle(
                              color:
                                  isUserMessage ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          ChatInputField(
            controller: _controller,
            onSend: (message) => _sendMessage(message),
          ),
        ],
      ),
    );
  }
}
