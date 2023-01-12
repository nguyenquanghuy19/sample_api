import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/theme_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/application_view_model.dart';
import 'package:elearning/view_models/setting/dark_mode_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DarkModeView extends BaseView {
  const DarkModeView({Key? key}) : super(key: key);

  @override
  DarkModeViewState createState() => DarkModeViewState();
}

class DarkModeViewState extends BaseViewState<DarkModeView, DarkModeViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = DarkModeViewModel()..onInitViewModel(context);
  }

  @override
  void onBuildCompleted() {
    super.onBuildCompleted();
  }

  @override
  Widget buildView(BuildContext context) {
    viewModel.inItLanguage();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Tab(
            icon: SvgPicture.asset(Images.iconArrowLeft),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          Strings.of(context)!.themeMode,
          style: AppText.text24
              .copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Selector<DarkModeViewModel, List<ThemeModel>>(
            selector: (_, viewModel) => viewModel.checkBoxList,
            shouldRebuild: (prev, next) => true,
            builder: (_, checkBoxList, __) {
              return ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return Selector<DarkModeViewModel, int>(
                    selector: (_, viewModel) => viewModel.modeChoose,
                    builder: (_, modeChoose, __) {
                      return InkWell(
                        onTap: () {
                          viewModel.onTapChangeMode(index);
                          Provider.of<ApplicationViewModel>(context, listen: false)
                              .toggleMode(index);
                          Provider.of<ApplicationViewModel>(context, listen: false)
                              .saveTheme();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Constants.contentPaddingHorizontal,
                            vertical: 20.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  checkBoxList[index].title,
                                  style: AppText.text18.copyWith(
                                    color: modeChoose == checkBoxList[index].id
                                        ? AppColor.primary.shade400
                                        : null,
                                    fontWeight:
                                        modeChoose == checkBoxList[index].id
                                            ? FontWeight.w700
                                            : FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (modeChoose == checkBoxList[index].id)
                                SvgPicture.asset(Images.iconCheck),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                itemCount: checkBoxList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 1,
                    color: AppColor.neutrals.shade300,
                    height: 0,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
