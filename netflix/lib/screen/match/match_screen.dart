import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/base/log.dart';
import 'package:netflix/utilities.dart';
import 'package:netflix/screen/match/match_bloc.dart';
import 'package:provider/provider.dart';

class MatchPage extends StatefulWidget {
  MatchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    final matchBloc = Provider.of<MatchBloc>(context, listen: false);
    FirebaseMessaging.onMessage.listen((event) {
      var data = event.data;
      int vietnam = StringExtension(data['vietnam']).parseInt();
      int indo = StringExtension(data['indo']).parseInt();
      logDebug("vietnam: $vietnam");

      matchBloc.action.add(SetMatchAction(vietnam, indo));
    });
  }

  @override
  Widget build(BuildContext context) {
    final matchBloc = Provider.of<MatchBloc>(context);
    return Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Match: ',
                  style: Theme.of(context).textTheme.headline4,
                ),
                StreamBuilder(
                  stream: matchBloc.vietnam,
                    builder: (context, data ){
                      return Text(
                        'Vietnam: ${data.data}',
                      );
                    }
                ),
                StreamBuilder(
                    stream: matchBloc.indo,
                    builder: (context, data ){
                      return Text(
                        'Indo: ${data.data}',
                      );
                    }
                ),
                ElevatedButton(
                  child: Text("Send event"),
                  onPressed: () {
                    _sendAnalyticsEvent();
                  },
                ),
              ],
            )

        )
    );
  }

  Future<void> _sendAnalyticsEvent() async {
    logDebug("_sendAnalyticsEvent");
    final FirebaseAnalytics analytics = FirebaseAnalytics();
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'string',
        'int': 42,
        'long': 12345678910,
        'double': 42.0,
        'bool': true,
      },
    );
    // setMessage('logEvent succeeded');
  }
}