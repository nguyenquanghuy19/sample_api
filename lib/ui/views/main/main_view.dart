import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:testproject/core/data/models/category_model.dart';
import 'package:testproject/ui/shared/app_theme.dart';
import 'package:testproject/ui/shared/images.dart';
import 'package:testproject/ui/views/base_view.dart';
import 'package:testproject/view_models/main/main_view_model.dart';

class MainView extends BaseView {
  const MainView({
    super.key,
  });

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends BaseViewState<MainView, MainViewModel> {
  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = MainViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 500.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.imageBackgroundMain),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.8),
                      Colors.black,
                      Colors.black,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 0,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: TextButton(
                  child: Text("Done", style: AppText.text16.copyWith(color: Colors.white),),
                  onPressed: () {
                    viewModel.onTapSaveListCategory();
                  },
                ),
              ),
            ),
            Positioned.fill(
              top: 200.h,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to Flutter Test",
                      style: AppText.text22.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Please select categories what you would like to see on your feed. You can set this later on Filter.",
                      style: AppText.text16
                          .copyWith(color: Colors.white.withOpacity(0.82)),
                    ),
                    Selector<MainViewModel, List<CategoryModel>>(
                      selector: (_, viewModel) => viewModel.categories,
                      shouldRebuild: (pre, next) => true,
                      builder: (_, categories, __) {
                        return Expanded(
                          child: GridView.builder(
                            primary: false,
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final item = categories[index];

                              return _buildItemCategory(item, index);
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 15.h,
                              crossAxisCount: 3,
                              childAspectRatio: 1.75,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCategory(CategoryModel item, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          item.isSelected = !item.isSelected;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 4,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            border:
                Border.all(color: Colors.white.withOpacity(0.12), width: 1.w),
            color: item.isSelected ? AppColor.colorsBackgroundItem : null,
          ),
          child: Center(
            child: Text(
              item.name,
              style: AppText.text14
                  .copyWith(color: Colors.white.withOpacity(0.82)),
            ),
          ),
        ),
      ),
    );
  }
}
