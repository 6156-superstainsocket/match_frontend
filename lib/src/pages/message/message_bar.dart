import 'package:demo/constants.dart';
import 'package:demo/src/pages/message/message_matched.dart';
import 'package:flutter/material.dart';

class MessageBar extends StatefulWidget {
  const MessageBar({super.key});

  @override
  State<MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<MessageBar> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: "Matched"),
            Tab(text: "Invitation"),
            Tab(text: "Management"),
          ],
          indicatorColor: pinkHeavyColor,
        ),
        body: TabBarView(
          children: [
            MessageMatched(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
