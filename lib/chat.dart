import 'package:chat_app_example/message.dart';
import 'package:chat_app_example/send_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class Chat extends StatefulWidget {
  static const String id = 'CHAT';

  final auth.User user;

  Chat({this.user});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if (messageController.text.length > 0) {
      _firestore
          .collection('messages')
          .doc('widget.user.email')
          .collection(widget.user.email)
          .add({
        'text': messageController.text,
        'from': widget.user.email,
        'time': DateTime.now().millisecondsSinceEpoch
      });
      // await _firestore.collection(widget.user.email).add({
      //   'text': messageController.text,
      //   'from': widget.user.email,
      //   'time': DateTime.now().millisecondsSinceEpoch
      // });
      messageController.clear();
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
          tag: 'logo',
          child: Container(
            height: 40,
            child: Image.asset('assets/logo.png'),
          ),
        ),
        title: Text('Tensor Chat'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    _firestore.collectionGroup(widget.user.email).snapshots(),
                // stream: _firestore.collection(widget.user.email).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  List<DocumentSnapshot> docs = snapshot.data.docs;

                  docs.sort((doc1, doc2) =>
                      DateTime.fromMillisecondsSinceEpoch(doc2.data()['time'])
                          .compareTo(DateTime.fromMillisecondsSinceEpoch(
                              doc1.data()['time'])));

                  List<Widget> messages = docs.map((doc) {
                    return Message(
                      from: doc.data()['from'],
                      text: doc.data()['text'],
                      me: widget.user.email == doc.data()['from'],
                      time: DateTime.fromMillisecondsSinceEpoch(
                          doc.data()['time']),
                    );
                  }).toList();

                  return ListView(
                    reverse: true,
                    controller: scrollController,
                    children: [...messages],
                  );
                },
              ),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      decoration: InputDecoration(
                          hintText: 'Enter a Message',
                          border: OutlineInputBorder()),
                      controller: messageController,
                    ),
                  ),
                  SendButton(
                    text: 'Send',
                    callback: callback,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
