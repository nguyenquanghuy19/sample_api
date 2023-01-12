import 'dart:convert';

import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/share_preference/spref_setting_flash_card.dart';
import 'package:elearning/core/data/share_preference/spref_user_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/core/look_up/look_up_data.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/mains/main_view_after_sign_in.dart';
import 'package:elearning/ui/views/mains/main_view_before_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inItData();
    });
  }

  Future<void> inItData() async {
    await SPrefUserModel().onInit();
    await SPrefSettingFlashCard().onInit();
    await getCountries();
    getAvatar();
    await Future.delayed(
      const Duration(milliseconds: 300),
    );
    navigateAfterSplash();
  }

  Future<void> getCountries() async {
    String data = await rootBundle.loadString('assets/jsons/countries.json');
    final jsonResult = json.decode(data);
    final countries = (jsonResult as List<dynamic>)
        .map((dynamic e) => CountryModel.fromJson(e as Map<String, dynamic>))
        .toList();
    LookUpData.countries.clear();
    LookUpData.countries.addAll(countries);
  }

  void getAvatar() {
    final avatarString = SPrefUserModel().getAvatar();
    final displayName = SPrefUserModel().getDisplayName();
    LookUpData.avatarType = SPrefUserModel().getAvatarType();
    if (avatarString != null) {
      LookUpData.avatar = base64.decode(avatarString);
    }
    if (displayName != null) {
      LookUpData.displayName = displayName;
    }
  }

  void navigateAfterSplash() {
    if (!SPrefUserModel().getIsSignIn()) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) {
            return const MainViewBeforeSignIn();
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) {
            return const MainViewAfterSignIn();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary.shade400,
      body: Container(
        height: MediaQuery.of(context).size.height.h,
        width: MediaQuery.of(context).size.width.w,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              AppColor.primary.shade300,
              AppColor.primary.shade400,
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                Images.appLogo,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 90.h
                  : 20.h,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  Strings.of(context)!.eLMS,
                  textAlign: TextAlign.center,
                  style: AppText.text40.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
