import 'package:basqary/l10n/app_localizations.dart';
import 'package:basqary/presentation/data/LessonViewModel.dart';
import 'package:basqary/presentation/ui/custom/constant/app_size.dart';
import 'package:basqary/presentation/ui/custom/widget/button_icon.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:basqary/presentation/ui/custom/widget/scrollable_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonPage extends StatefulWidget {

  final LessonViewModel lesson;

  const LessonPage({super.key, required this.lesson});

  @override
  State<StatefulWidget> createState() {
    return _LessonPage();
  }
}

class _LessonPage extends State<LessonPage> {

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.lesson.contentUrl,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: true,
        disableDragSeek: false,
        hideControls: false,
        hideThumbnail: false,
        loop: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: YoutubePlayerBuilder(
        onEnterFullScreen: () {

        },
        onExitFullScreen: () {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
            SystemUiOverlay.top,
          ]);
        },
        player: YoutubePlayer(controller: _controller),
        builder: (context, player) {
          return Scaffold(
            body: ScrollablePage(
              children: [
                Column(
                  children: [
                    SizedBox(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/top.png",
                            height: 120,
                            width: double.infinity,
                            alignment: Alignment.topCenter,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 110),
                            child: player,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: AppSize.topMargin, left: AppSize.horizontal, right: AppSize.horizontal),
                            height: 35,
                            child: Row(
                              children: [
                                ButtonIcon(
                                  Icons.arrow_back_ios_new_rounded,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 35),
                                    child: HeaderText(
                                      AppLocalizations.of(context)!.lesson,
                                      textAlign: TextAlign.center,
                                      style: HeaderText.defaultStyle.apply(
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 14, right: 14, top: 20),
                  child: HeaderText(
                      widget.lesson.title
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 14, right: 14, top: 6),
                  child: DescriptionText(
                    widget.lesson.description,
                    style: DescriptionText.defaultStyle.apply(
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}