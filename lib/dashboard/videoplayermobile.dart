import 'package:flutter/foundation.dart' show kIsWeb; // Add this import
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:last_pod_player/last_pod_player.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String videoDescription;
  final String youtubeurl;

  const VideoPlayerPage({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoDescription,
    required this.youtubeurl,
  }) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final PodPlayerController controller;
  bool _isLoading = true;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    // Lock to portrait mode initially
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _initializePlayer();
  }

  @override
  void dispose() {
    // Reset to default orientations when disposing
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    controller.dispose();
    super.dispose();
  }

  bool _isValidYoutubeUrl(String url) {
    if (url.isEmpty) return false;
    return url.contains('youtube.com') || url.contains('youtu.be');
  }

  Future<void> _initializePlayer() async {
    PlayVideoFrom playVideoFrom;

    // Always use network URL if running on web
    if (kIsWeb) {
      if (widget.videoUrl.isNotEmpty) {
        playVideoFrom = PlayVideoFrom.network(widget.videoUrl);
      } else {
        throw Exception("No valid network video URL provided for web");
      }
    }
    // For non-web platforms, use YouTube if available, otherwise fallback to network
    else if (_isValidYoutubeUrl(widget.youtubeurl)) {
      playVideoFrom = PlayVideoFrom.youtube(widget.youtubeurl);
    } else if (widget.videoUrl.isNotEmpty) {
      playVideoFrom = PlayVideoFrom.network(widget.videoUrl);
    } else {
      throw Exception("No valid video URL provided");
    }

    controller = PodPlayerController(
      playVideoFrom: playVideoFrom,
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
      ),
    )..initialise().then((_) {
        setState(() => _isLoading = false);
      });

    // Listen for fullscreen changes
    controller.addListener(_handleFullScreenChange);
  }

  void _handleFullScreenChange() {
    if (controller.isFullScreen && !_isFullScreen) {
      // Entering fullscreen - explicitly enable landscape orientations
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      setState(() => _isFullScreen = true);
    } else if (!controller.isFullScreen && _isFullScreen) {
      // Exiting fullscreen - lock to portrait
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      setState(() => _isFullScreen = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _isFullScreen
          ? null
          : AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              title: Text(
                widget.videoTitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              centerTitle: false,
              elevation: 0,
            ),
      body: _isFullScreen
          ? PodVideoPlayer(controller: controller)
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Player
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : PodVideoPlayer(controller: controller),
                  ),

                  // Video Details
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Video Title
                        Text(
                          widget.videoTitle,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Video Description with clickable links
                        widget.videoDescription == "B"
                            ? const SizedBox()
                            : SelectableText.rich(
                                _buildDescriptionWithLinks(
                                    widget.videoDescription),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
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

// import 'package:elearning_web/contrains.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:pod_player/pod_player.dart';
// import 'package:url_launcher/url_launcher.dart';

// class VideoPlayerPage extends StatefulWidget {
//   final String videoUrl;
//   final String videoTitle;
//   final String videoDescription;

//   const VideoPlayerPage({
//     Key? key,
//     required this.videoUrl,
//     required this.videoTitle,
//     required this.videoDescription,
//   }) : super(key: key);

//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }

// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late final PodPlayerController controller;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   Future<void> _initializePlayer() async {
//     controller = PodPlayerController(
//       playVideoFrom: PlayVideoFrom.network(widget.videoUrl),
//       podPlayerConfig: const PodPlayerConfig(
//         autoPlay: true,
//         isLooping: false,
//       ),
//     )..initialise().then((_) {
//         setState(() => _isLoading = false);
//       });
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//        appBar: AppBar(
//           backgroundColor: backgroundColor,
//           leading: IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: Colors.white,
//               )),
//           title:  Text(
//             widget.videoTitle,
//             style: const TextStyle(
//               fontSize: 13,
//               color: Colors.white,
//             ),
//           ),
//           centerTitle: false,
//           elevation: 0,
//         ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Video Player
//             AspectRatio(
//               aspectRatio: 16 / 9,
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : PodVideoPlayer(controller: controller),
//             ),

//             // Video Details
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Video Title
//                   Text(
//                     widget.videoTitle,
//                     style: const TextStyle(

//                           fontWeight: FontWeight.normal,
//                           color: Colors.white,
//                           fontSize: 14
//                         ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Video Description with clickable links
//                   widget.videoDescription == "B"
//                       ? const SizedBox()
//                       : SelectableText.rich(
//                           _buildDescriptionWithLinks(widget.videoDescription),
//                           // style: Theme.of(context).textTheme.bodyMedium,
//                           style: const TextStyle(fontSize: 12,color: Colors.white),
//                         ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   TextSpan _buildDescriptionWithLinks(String text) {
//     final urlRegExp = RegExp(
//       r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+',
//       caseSensitive: false,
//     );

//     final matches = urlRegExp.allMatches(text);
//     if (matches.isEmpty) return TextSpan(text: text);

//     final List<TextSpan> spans = [];
//     int currentIndex = 0;

//     for (final match in matches) {
//       if (match.start > currentIndex) {
//         spans.add(TextSpan(text: text.substring(currentIndex, match.start)));
//       }

//       final url = text.substring(match.start, match.end);
//       spans.add(
//         TextSpan(
//           text: url,
//           style: const TextStyle(
//             color: Colors.blue,
//             decoration: TextDecoration.underline,
//           ),
//           recognizer: TapGestureRecognizer()..onTap = () => _launchUrl(url),
//         ),
//       );

//       currentIndex = match.end;
//     }

//     if (currentIndex < text.length) {
//       spans.add(TextSpan(text: text.substring(currentIndex)));
//     }

//     return TextSpan(children: spans);
//   }

//   Future<void> _launchUrl(String url) async {
//     if (!url.startsWith('http://') && !url.startsWith('https://')) {
//       url = 'https://$url';
//     }

//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Could not launch $url')),
//       );
//     }
//   }
// }
