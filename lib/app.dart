import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweetapp/core/local_db/shared_preferences.dart';
import 'package:tweetapp/features/onboarding/ui/onboarding_screen.dart';
import 'package:tweetapp/features/tweet/ui/tweets_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  static StreamController<String> authStream = StreamController.broadcast();

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    String uid = SharedPreferencesManager.getUid();
    if (uid.isEmpty) {
      InitialPage.authStream.add("");
    } else {
      InitialPage.authStream.add(uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: InitialPage.authStream.stream,
        builder: (context, snapshot) {
          if (snapshot.data == null || (snapshot.data?.isEmpty ?? true)) {
            return OnboardingScreen();
          } else {
            return TweetsPage();
          }
        });
  }
}
