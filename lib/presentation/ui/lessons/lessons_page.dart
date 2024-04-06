import 'package:basqary/domain/api/lesson.dart';
import 'package:basqary/presentation/data/LessonViewModel.dart';
import 'package:basqary/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:basqary/presentation/ui/custom/widget/empy_content.dart';
import 'package:basqary/presentation/ui/custom/widget/loader_content.dart';
import 'package:basqary/presentation/ui/custom/widget/scrollable_page.dart';
import 'package:basqary/presentation/ui/lessons/lesson_widget.dart';
import 'package:basqary/presentation/ui/lessons/lessons_top.dart';
import 'package:basqary/presentation/ui/lesson/lesson_page.dart';
import 'package:flutter/material.dart';

class LessonsPage extends StatefulWidget {

  const LessonsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LessonsPage();
  }
}

class _LessonsPage extends State<LessonsPage> {

  final LessonAPI _lessonAPI = LessonAPI();
  final TextEditingController _searchController = TextEditingController();
  final List<LessonViewModel> _lessons = [];
  final List<LessonViewModel> _sLessons = [];
  bool _loading = true;

  void _filter() {
    setState(() {
      _loading = true;
    });
    _sLessons.clear();
    for (LessonViewModel lesson in _lessons) {
      if (lesson.title.toLowerCase().contains(_searchController.text.toLowerCase())) {
        _sLessons.add(lesson);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _lessonAPI.findAll().then((value) => {
      _lessons.addAll(value),
      _filter()
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 200),
          child: ScrollablePage(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12, top: 30, bottom: 100),
                child: _loading ? const LoaderContentWidget() : _sLessons.isNotEmpty ? Column(
                  children: List.generate(
                      _sLessons.length,
                      (index) => LessonWidget(
                      _sLessons[index],
                      onPressed: (lesson) {
                        NavigationUtils.push(
                          context,
                          LessonPage(lesson: lesson)
                        );
                      },
                    )
                  ),
                ) : const EmptyContentWidget(),
              )
            ],
          ),
        ),
        LessonsTopWidget(
          searchController: _searchController,
          onSubmitted: (value) {
            _filter();
          },
        ),
      ],
    );
  }
}
