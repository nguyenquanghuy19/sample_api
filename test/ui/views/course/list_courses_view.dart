import 'package:elearning/core/data/models/course_mock_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../view_models/course/list_courses_view_model.dart';
import 'course_detail_view.dart';

class ListCoursesView extends BaseView {
  const ListCoursesView({super.key});

  @override
  ListCoursesViewState createState() => ListCoursesViewState();
}

class ListCoursesViewState
    extends BaseViewState<ListCoursesView, ListCoursesViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = ListCoursesViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(411, 774),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
        child: Selector<ListCoursesViewModel, List<CoursesModel>>(
          selector: (_, viewModel) => viewModel.courses,
          builder: (_, courses, __) {
            return _listCourses(courses);
          },
        ),
      ),
    );
  }

  /// CUSTOM APP BAR TO SEARCH VIEW
  PreferredSizeWidget _appBar() {
    return viewModel.activeSearch
        ? AppBar(
            automaticallyImplyLeading: false,
            title: TextField(
              decoration: InputDecoration(
                hintText: Strings.of(context)!.hintTextSearchCourses,
                fillColor: Colors.white,
                filled: true,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().screenWidth * 0.01,
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30).w,
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.only(left: 0, right: 20.w),
                icon: const Icon(Icons.close),
                onPressed: () => setState(() => viewModel.activeSearch = false),
              ),
            ],
          )
        : AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                viewModel.removeNotifier();
                Navigator.pop(context);
              },
            ),
            title: Text(
              Strings.of(context)!.titleCourses,
              style: AppText.text24.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.only(left: 0, right: 20.w),
                icon: const Icon(Icons.search),
                onPressed: () => setState(() => viewModel.activeSearch = true),
              ),
            ],
          );
  }

  Widget _listCourses(List<CoursesModel> courses) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      shrinkWrap: true,
      primary: false,
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _itemCardCourses(courses[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10.h,
        );
      },
    );
  }

  Widget _itemCardCourses(CoursesModel course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) {
              return const CourseDetailView();
            },
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2).r,
                child: Image.asset(
                  fit: BoxFit.cover,
                  course.image,
                  width: 80.w,
                  height: 100.h,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.name,
                      style: AppText.text18.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 1,
                    ),
                    SizedBox(height: 10.w),
                    Text(
                      course.description,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.text16.copyWith(color: Colors.black),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
