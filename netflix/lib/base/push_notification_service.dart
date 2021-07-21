import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:netflix/model/match.dart';
import 'package:netflix/utilities.dart';

class PushNotificationService {

  Future<void> setupInteractedMessage() async {
    // String? token = await FirebaseMessaging.instance.getToken();
    logDebug("FirebaseMessaging token: ${await FirebaseMessaging.instance.getToken()}");

    FirebaseMessaging.onMessage.listen((event) {
      logDebug("onMessage: ${event.data.toString()}");
      RemoteMessage initialMessage = event;

      if (initialMessage != null && initialMessage.data['match'] !=null) {
        logDebug("initialMessage.data: ${initialMessage.data['match']}");
        var input  = json.decode(initialMessage.data['match'].toString());
        FootballMatch footballMatch = FootballMatch.fromJson(input);
        logDebug("input: ${input}");
        logDebug("footballMatch.toJson: ${footballMatch.toJson()}");
      }

    });
  }
}