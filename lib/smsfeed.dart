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

        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: allmessages == null
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: allmessages.map((messageone) {
                    //populating children to column using map
                    String type =
                        "NONE"; //get the type of message i.e. inbox, sent, draft
                    if (messageone.kind == SmsMessageKind.Received) {
                      type = "Inbox";
                    } else if (messageone.kind == SmsMessageKind.Sent) {
                      type = "Outbox";
                    } else if (messageone.kind == SmsMessageKind.Draft) {
                      type = "Draft";
                    }
                    return Container(
                      child: Card(
                          child: ListTile(
                        leading: Icon(Icons.message),
                        title: Padding(
                            child: Text(messageone.address + " (" + type + ")"),
                            padding: EdgeInsets.only(
                                bottom: 10, top: 10)), // printing address
                        subtitle: Padding(
                            child: Text(messageone.date.toString() +
                                "\n" +
                                messageone.body),
                            padding: EdgeInsets.only(
                                bottom: 10,
                                top: 10)), //pringint date time, and body
                      )),
                    );
                  }).toList()),
          ),
        ));
  }
}
