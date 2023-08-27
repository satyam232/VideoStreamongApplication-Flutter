import 'package:better_player/better_player.dart';
import 'package:videostreaming/RefreshIndicator.dart';
import 'package:videostreaming/custom_row.dart';
import 'package:flutter/material.dart';

class Videos extends StatefulWidget {
  String videoS;
  String title;
  String img;
  String dsc;

  Videos({
    super.key,
    required this.videoS,
    required this.title,
    required this.dsc,
    required this.img,
  });

  @override
  State<Videos> createState() => _VideosState(
        videoS: this.videoS,
        img: this.img,
        title: this.title,
        dsc: this.dsc,
      );
}

class _VideosState extends State<Videos> {
  String videoS;
  String title;
  String img;
  String dsc;
  _VideosState({
    required this.videoS,
    required this.title,
    required this.dsc,
    required this.img,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.grey[400],
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).popUntil((route) => route.isFirst);
          return false;
        },
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network(videoS),
            ),
            CustomRowWidget(img: img, titl: title, dsc: dsc),
            Divider(
              color: Colors.grey[400],
              height: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(child: RefreshIndicato())
          ],
        ),
      ),
    );
  }
}
