import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sms/sms.dart';

class SmsFeed extends StatefulWidget {
  const SmsFeed({Key? key}) : super(key: key);

  @override
  State<SmsFeed> createState() => _SmsFeedState();
}

class _SmsFeedState extends State<SmsFeed> {
  SmsQuery query = SmsQuery();
  List<SmsMessage> allmessages = [];

  @override
  void initState() {
    super.initState();
    getAllMessages();
  }

  void getAllMessages() async {
    List<SmsMessage> messages = await query.querySms(
      kinds: [SmsQueryKind.Inbox],
      address: "Mon Cash",
      //filter Inbox, sent or draft messages
      count: 10, //number of sms to read
    );
    setState(() {
      allmessages = messages;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yanvalou APP"),
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: allmessages == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: allmessages.map((messageone) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          Text(messageone.address),
                          Text(messageone.body.substring(0, 11)),
                        ],
                      ),
                    );
                  }).toList()),
          ),
        ));
  }
}
