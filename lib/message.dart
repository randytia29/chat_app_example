import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;
  final DateTime time;

  Message({this.from, this.text, this.me, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        me ? Container() : Icon(Icons.photo),
        Bubble(
          radius: Radius.circular(20),
          nip: me ? BubbleNip.rightTop : BubbleNip.leftTop,
          nipOffset: 20,
          margin: BubbleEdges.only(top: 5, bottom: 5),
          alignment: Alignment.topRight,
          color: Colors.grey,
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Stack(
              children: [
                Align(
                  alignment: me ? Alignment.topLeft : Alignment.topRight,
                  child: Text(
                    '${time.hour.toString()} : ${time.minute.toString()} ',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Align(
                  alignment: me ? Alignment.topRight : Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment:
                        me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Align(
                          alignment:
                              me ? Alignment.topRight : Alignment.topLeft,
                          child: Text(
                            from,
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                          alignment:
                              me ? Alignment.topRight : Alignment.topLeft,
                          child:
                              Text(text, style: TextStyle(color: Colors.black)))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        me ? Icon(Icons.photo) : Container()
      ],
    );
    // return Container(
    //   child: Column(
    //     crossAxisAlignment:
    //         me ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    //     children: [
    //       Text(from),
    //       Row(
    //         mainAxisAlignment:
    //             me ? MainAxisAlignment.end : MainAxisAlignment.start,
    //         children: [
    //           (me)
    //               ? Text('${time.hour.toString()} : ${time.minute.toString()} ')
    //               : Container(),
    //           Material(
    //             color: me ? Colors.teal : Colors.red,
    //             borderRadius: BorderRadius.circular(10),
    //             elevation: 6,
    //             child: Container(
    //               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //               child: Text(text),
    //             ),
    //           ),
    //           (me)
    //               ? Container()
    //               : Text('${time.hour.toString()} : ${time.minute.toString()} ')
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
