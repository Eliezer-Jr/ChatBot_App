import 'package:flutter/material.dart';
import 'developer_info.dart';

void main() {
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatBot App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to ChatBot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to ChatBot App!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
              child: const Text('Start Chatting'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];

  void _handleSubmitted(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUserMessage: true,
      ));

      // Simulate chatbot response
      _messages.add(ChatMessage(
        text: 'Hello! I am your chatbot. How can I assist you?',
        isUserMessage: false,
      ));
    });
  }

void _showDeveloperInfo() {
    final developer = DeveloperInfo(
      name: 'Eliezer',
      github: 'Eliezer-Jr',
      avatarImage: 'lib/assets/avatar.png', // Update with the actual asset path
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeveloperInfoDialog(developer: developer);
      },
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration.collapsed(
                  hintText: 'Send a message',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatBot'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: _showDeveloperInfo,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (_, index) => _messages[index],
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const ChatMessage({super.key, required this.text, required this.isUserMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: isUserMessage ? const Text('You') : const Text('Bot')),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(isUserMessage ? 'You' : 'ChatBot'),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showDeveloperInfo() {
  final developer = DeveloperInfo(
    name: 'Eliezer',
    github: 'Eliezer-Jr',
    avatarImage: 'lib/assets/avatar.png', // Update with the actual asset path
  );

  var context;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeveloperInfoDialog(developer: developer);
    },
  );
}

class DeveloperInfo {
  final String name;
  final String github;
  final String avatarImage;

  DeveloperInfo({required this.name, required this.github, required this.avatarImage});
}

class DeveloperInfoDialog extends StatelessWidget {
  final DeveloperInfo developer;

  const DeveloperInfoDialog({super.key, required this.developer});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Developer Info'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(developer.avatarImage),
                radius: 30,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Name:- ${developer.name}'),
                  const SizedBox(height: 5),
                  Text('GitHub:- ${developer.github}'),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
