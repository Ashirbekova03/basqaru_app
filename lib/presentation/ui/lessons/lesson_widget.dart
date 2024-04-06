import 'dart:ui';

import 'package:basqary/presentation/data/LessonViewModel.dart';
import 'package:basqary/presentation/ui/custom/formatter/formatter.dart';
import 'package:basqary/presentation/ui/custom/widget/description_text.dart';
import 'package:basqary/presentation/ui/custom/widget/header_text.dart';
import 'package:flutter/material.dart';

class LessonWidget extends StatelessWidget {

  final LessonViewModel lesson;
  final Function onPressed;

  const LessonWidget(this.lesson, {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 220,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          onPressed.call(lesson);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                _getPreview(lesson.contentUrl),
                width: double.infinity,
                height: 220,
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 21, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.black.withOpacity(0.4)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderText(
                        lesson.title,
                        style: HeaderText.defaultStyle.apply(
                            color: Colors.white
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          DescriptionText(
                            Formatter.parseDate(lesson.time),
                            textAlign: TextAlign.end,
                            style: DescriptionText.defaultStyle.apply(
                                color: Colors.white.withOpacity(0.9)
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPreview(String url) {
    return 'https://img.youtube.com/vi/$url/0.jpg';
  }
}