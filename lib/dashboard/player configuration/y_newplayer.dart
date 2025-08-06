import 'package:designingstudio/contrains.dart';
import 'package:flutter/material.dart';
import 'package:y_player/y_player.dart';

class ynewplayerwithqulaity extends StatefulWidget {
  final String videolink;
  final String videoTitle;
  final String videoDescription;
  const ynewplayerwithqulaity({
    super.key,
    required this.videolink,
    required this.videoTitle,
    required this.videoDescription,
  });

  @override
  State<ynewplayerwithqulaity> createState() => _ynewplayerwithqulaityState();
}

class _ynewplayerwithqulaityState extends State<ynewplayerwithqulaity> {
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
      body: Column(
        children: [
          YPlayer(
            youtubeUrl: widget.videolink,
            autoPlay: false,
          ),
          SizedBox(
            height: 5,
          ),
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.videoTitle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
