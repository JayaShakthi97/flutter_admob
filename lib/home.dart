import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
  );

  int _earn = 0;
  bool _adLoading = false;
  String error = ' ';

  void _showAd() {
    if (!_adLoading) {
      setState(() {
        _adLoading = true;
      });
      RewardedVideoAd.instance.load(
          adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
      //RewardedVideoAd.instance.show();
    }
  }

  @override
  void initState() {
    super.initState();
    RewardedVideoAd.instance.listener =
        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      if (event == RewardedVideoAdEvent.rewarded) {
        setState(() {
          _earn += rewardAmount;
          _adLoading = false;
        });
      } else if (event == RewardedVideoAdEvent.loaded) {
        RewardedVideoAd.instance.show();
      } else if (event == RewardedVideoAdEvent.closed) {
        setState(() {
          _adLoading = false;
        });
      } else if (event == RewardedVideoAdEvent.failedToLoad) {
        setState(() {
          _adLoading = true;
          error = 'Failed Loading';
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Your Earnings: $_earn coins',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: RaisedButton(
                  child: _adLoading
                      ? CircularProgressIndicator()
                      : Text('View Ad'),
                  onPressed: _showAd,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(error),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
