import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../contrains.dart';

class ytplayer extends StatefulWidget {
  final String videolink;
  final String videoTitle;
  final String videoDescription;
  const ytplayer({
    super.key,
    required this.videolink,
    required this.videoTitle,
    required this.videoDescription,
  });

  @override
  State<ytplayer> createState() => _ytplayerState();
}

class _ytplayerState extends State<ytplayer> {
  late YoutubePlayerController _controller;
  late Map<String, String> _videoUrls;
  String _currentQuality = '720p';

  @override
  void initState() {
    // _protectDataLeakageOn();
    ///   viewModel = Provider.of<CommonViewModel>(context, listen: false);

    super.initState();

    _videoUrls = {
      '360p': widget.videolink, // Replace with actual URL for 360p
      '480p': widget.videolink, // Replace with actual URL for 480p
      '720p': widget.videolink, // Replace with actual URL for 720p
      '1080p': widget.videolink, // Replace with actual URL for 1080p
    };
    _controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId(_videoUrls[_currentQuality]!)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() async {
    /// await ScreenProtector.protectDataLeakageOff();
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isPortrait
          ? AppBar(
              toolbarHeight: 80,
              backgroundColor: Colors.white,
              leading: MaterialButton(
                height: 45,
                minWidth: 45,
                color: primaycolor,
                shape: const CircleBorder(),
                elevation: 4,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              // IconButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   icon: const Icon(
              //     Icons.arrow_back_ios_new,
              //     color: Colors.white,
              //   ),
              // ),
              // title: Text(
              //   widget.videoTitle,
              //   style: const TextStyle(
              //     fontSize: 13,
              //     color: Colors.white,
              //   ),
              // ),
              centerTitle: false,
              elevation: 0,
            )
          : null,
      body: Center(
        child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              onEnded: (metaData) {
                log("ended");
                _controller.play();
              },
              thumbnail: Container(
                color: Colors.transparent,
              ),
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              onReady: () {
                print('Player is ready.');
              },
            ),
            builder: (context, player) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? Container(
                          height: MediaQuery.of(context).size.width * 0.8,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black,
                          child: FittedBox(child: player),
                        )
                      : Expanded(child: player),

                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.videoTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? const SizedBox(height: 12)
                      : SizedBox(),

                  // Video Description with clickable links
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? widget.videoDescription == "B"
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SelectableText.rich(
                                  _buildDescriptionWithLinks(
                                      widget.videoDescription),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                      : SizedBox()
                ],
              );
            }),
      ),
    );
  }

  TextSpan _buildDescriptionWithLinks(String text) {
    final urlRegExp = RegExp(
      r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
      caseSensitive: false,
    );

    final matches = urlRegExp.allMatches(text);
    if (matches.isEmpty) return TextSpan(text: text);

    final List<TextSpan> spans = [];
    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
      }

      final url = text.substring(match.start, match.end);
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
          recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
        ),
      );

      currentIndex = match.end;
    }

    if (currentIndex < text.length) {
      spans.add(TextSpan(text: text.substring(currentIndex)));
    }

    return TextSpan(children: spans);
  }

  Future<void> _launchUrl(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
