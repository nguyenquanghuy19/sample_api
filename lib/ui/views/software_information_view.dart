import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/software_information_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/view_models/software_information_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SoftwareInformationView extends BaseView {
  const SoftwareInformationView({Key? key}) : super(key: key);

  @override
  SoftwareInformationViewState createState() => SoftwareInformationViewState();
}

class SoftwareInformationViewState extends BaseViewState<
    SoftwareInformationView, SoftwareInformationViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = SoftwareInformationViewModel()..onInitViewModel(context);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(Strings.of(context)!.about),
        centerTitle: true,
        toolbarHeight: Constants.appBarHeight,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Tab(
            icon: SvgPicture.asset(Images.iconArrowLeft),
          ),
        ),
      ),
      body: Selector<SoftwareInformationViewModel, bool>(
        selector: (_, viewModel) => viewModel.isLoading,
        builder: (_, isLoading, __) {
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: [
        _buildSoftwareHeader(),
        _buildSoftwareList(),
        _buildCompanyInformation(),
      ],
    );
  }

  Widget _buildSoftwareHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            Images.appIcon,
            height: 150,
            width: 150,
          ),
          SizedBox(
            height: 10.h,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.of(context)!.version,
                style: AppText.text18,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSoftwareList() {
    return Selector<SoftwareInformationViewModel,
        List<SoftwareInformationModel>?>(
      selector: (_, viewModel) => viewModel.softwareList,
      shouldRebuild: (prev, next) => true,
      builder: (_, items, __) {
        if (items == null || items.isEmpty) {
          return Container();
        }

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.contentPaddingHorizontal,
          ),
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildSoftwareItem(
                items[index],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSoftwareItem(SoftwareInformationModel item) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            item.title ?? '',
            style: AppText.text18.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            item.description ?? '',
            style: AppText.text14.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyInformation() {
    return Container(
      color: AppColor.neutrals.shade800,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.contentPaddingHorizontal,
          vertical: Constants.contentPaddingHorizontal,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                  Text("RikkeiSoft Corporation", style: AppText.text14.copyWith(color: Colors.white),),
                  const SizedBox(height: 14),
                  Image.asset(Images.imageMapAddress),
                  const SizedBox(height: 6),
                  Text(
                    "Address: 11th floor - Vietnam news agency building, 81 Quang Trung st, Hai Chau district, Da Nang City",
                    style: AppText.text14.copyWith(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "Business Registration Certificate",
              style: AppText.text14.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "01016589783, 3rd January 2023 by Department of Planning and Investment and Development of Da Nang City",
              style: AppText.text14.copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              "contact@rikkeisoft.com",
              style:
                  AppText.text14.copyWith(color: AppColor.supporting.shade200),
            ),
            Text(
              "0236 3962 685",
              style:
                  AppText.text14.copyWith(color: AppColor.supporting.shade200),
            ),
          ],
        ),
      ),
    );
  }
}
