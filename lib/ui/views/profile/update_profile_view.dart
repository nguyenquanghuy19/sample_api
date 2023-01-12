import 'package:elearning/core/constants/constants.dart';
import 'package:elearning/core/data/models/profile_model.dart';
import 'package:elearning/core/data/share_preference/spref_locale_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/shared/images.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/avatar_widget.dart';
import 'package:elearning/ui/widgets/phone_number_widget.dart';
import 'package:elearning/ui/widgets/popup_menu_custom.dart';
import 'package:elearning/view_models/profile/update_profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateProfileView extends BaseView {
  final Function() callBack;
  final ProfileModel data;
  final List<CountryModel> countries;

  const UpdateProfileView({
    Key? key,
    required this.callBack,
    required this.data,
    this.countries = const [],
  }) : super(key: key);

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState
    extends BaseViewState<UpdateProfileView, UpdateProfileViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<PopupMenuButtonState<CountryModel>> _popupButtonCountryKey =
      GlobalKey();
  final GlobalKey<PopupMenuButtonState<String>> _popupImageKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = UpdateProfileViewModel()..onInitViewModel(context);
    viewModel.initData(widget.data);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          Strings.of(context)!.titleAppBarUpdateProfile,
          style: AppText.text24.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Navigator.of(context).pop();
          },
          icon: Tab(
            icon: SvgPicture.asset(Images.iconArrowLeft,color: Colors.white,),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(_scaffoldKey.currentContext ?? context).unfocus(),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 78.h,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey.shade800
                        : AppColor.primary,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.contentPaddingHorizontal,
                        vertical: 16.h,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 90.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildDisplayNameTextField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildLastNameTextField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildFirstNameTextField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildGender(),
                              SizedBox(
                                height: 6.h,
                              ),
                              _buildDateOfBirth(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildPhoneNumberTextField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildCountryTextField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildCityTextField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buildAddressTextField(),
                              SizedBox(
                                height: 10.h,
                              ),
                              _buttonUpdate(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8.h,
                child: SizedBox(
                  height: 156.h,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      _buildImage(),
                      Positioned(
                        top: 112.h,
                        child: _buildIconEditImage(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: 8.h,
          ),
          child: Text(
            Strings.of(context)!.hintTextGender,
            style: AppText.text16.copyWith(color: AppColor.primary.shade400),
          ),
        ),
        Selector<UpdateProfileViewModel, String?>(
          selector: (_, viewModel) => viewModel.valueGender,
          builder: (_, valueGender, __) {
            return Row(
              children: [
                Row(
                  children: [
                    Radio(
                      value: Constants.male,
                      groupValue: valueGender,
                      onChanged: (value) {
                        viewModel.onChangeValueGender(value);
                      },
                      activeColor: AppColor.primary.shade400,
                      fillColor: MaterialStateColor.resolveWith(
                        (states) => valueGender == Constants.male
                            ? AppColor.primary.shade400
                            : AppColor.neutrals,
                      ),
                    ),
                    Text(
                      viewModel.getGenderName(Constants.male),
                      style: AppText.text14,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: Constants.female,
                      groupValue: valueGender,
                      onChanged: (value) {
                        viewModel.onChangeValueGender(value);
                      },
                      fillColor: MaterialStateColor.resolveWith(
                        (states) => valueGender == Constants.female
                            ? AppColor.primary.shade400
                            : AppColor.neutrals,
                      ),
                    ),
                    Text(
                      viewModel.getGenderName(Constants.female),
                      style: AppText.text14,
                    ),
                  ],
                ),
                Flexible(
                  child: Row(
                    children: [
                      Radio(
                        value: Constants.none,
                        groupValue: valueGender,
                        onChanged: (value) {
                          viewModel.onChangeValueGender(value);
                        },
                        fillColor: MaterialStateColor.resolveWith(
                          (states) => valueGender == Constants.none
                              ? AppColor.primary.shade400
                              : AppColor.neutrals,
                        ),
                      ),
                      Text(
                        viewModel.getGenderName(Constants.none),
                        style: AppText.text14,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildCountryTextField() {
    return AppInput(
      readOnly: true,
      contentPaddingVertical: 12.h,
      label: Strings.of(context)!.hintTextCountry,
      suffixIcon: Tab(
        icon: _buildButtonPopupMenuCountry(),
        height: 25,
      ),
      hintText: Strings.of(context)!.hintTextCountry,
      controller: viewModel.countryController,
      onTap: () {
        _popupButtonCountryKey.currentState?.showButtonMenu();
      },
    );
  }

  Widget _buildButtonPopupMenuAvatar() {
    return PopupMenuButtonCustom<String>(
      key: _popupImageKey,
      position: PopupMenuPositionCustom.under,
      icon: Container(
        width: (32.h + 32.w) / 2,
        height: (32.h + 32.w) / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Colors.brown.shade600),
          color: AppColor.primary.shade400,
        ),
        child: Tab(
          child: SvgPicture.asset(
            Images.iconEdit,
            color: Colors.white,
            width: 12,
            height: 12,
          ),
        ),
      ),
      onSelected: (value) {
        if (value == Constants.camera) {
          viewModel.getImage(ImageSource.camera);

          return;
        }
        if (value == Constants.gallery) {
          viewModel.getImage(ImageSource.gallery);

          return;
        }
        if (value == Constants.removeImage) {
          viewModel.deleteAvatar();

          return;
        }
      },
      itemBuilder: (context) => <PopupMenuEntryCustom<String>>[
        PopupMenuItemCustom<String>(
          value: Constants.camera,
          child: Text(Strings.of(context)!.titleCamera),
        ),
        const PopupMenuDividerCustom(height: 0),
        PopupMenuItemCustom<String>(
          value: Constants.gallery,
          child: Text(Strings.of(context)!.titleGallery),
        ),
        const PopupMenuDividerCustom(height: 0),
        PopupMenuItemCustom<String>(
          value: Constants.removeImage,
          child: Text(Strings.of(context)!.removeAvatar),
        ),
      ],
    );
  }

  Widget _buildButtonPopupMenuCountry() {
    return PopupMenuButton<CountryModel>(
      key: _popupButtonCountryKey,
      icon: Tab(
        icon: SvgPicture.asset(Images.iconArrowDown),
      ),
      onSelected: (value) {
        /// Todo: Check vi when CountryModel has vi
        // final String? nameCountry =
        //     SPrefLocaleModel().getLocale() == Constants.ja
        //         ? value.ja
        //         : SPrefLocaleModel().getLocale() == Constants.vi
        //             ? value.vi
        //             : value.en;

        final String? nameCountry =
            SPrefLocaleModel().getLocale() == Constants.ja
                ? value.ja
                : value.en;
        viewModel.countryController.text = nameCountry ?? "";
        viewModel.onChangeCountry(value);
      },
      itemBuilder: (context) => popupItems(),
    );
  }

  List<PopupMenuItem<CountryModel>> popupItems() {
    List<PopupMenuItem<CountryModel>> items = [];
    for (int i = 0; i < widget.countries.length; i++) {
      final String? view = SPrefLocaleModel().getLocale() == Constants.ja
          ? widget.countries[i].ja
          : widget.countries[i].en;
      final item = PopupMenuItem<CountryModel>(
        value: widget.countries[i],
        child: Text(view ?? ""),
      );
      items.add(item);
    }

    return items;
  }

  Widget _buildCityTextField() {
    return AppInput(
      contentPaddingVertical: 12.h,
      label: Strings.of(context)!.hintTextCity,
      hintText: Strings.of(context)!.hintTextCity,
      controller: viewModel.cityController,
      maxLength: 255,
      onChanged: (value) {
        viewModel.onChangeCity();
      },
    );
  }

  Widget _buildDateOfBirth() {
    return AppInput(
      contentPaddingVertical: 12.h,
      label: Strings.of(context)!.hintTextDateOfBirth,
      onTap: _showDatePicker,
      controller: viewModel.dateOfBirthController,
      hintText: Strings.of(context)!.hintTextDateOfBirth,
      readOnly: true,
      suffixIcon: Tab(
        icon: SvgPicture.asset(Images.iconCalendar),
        height: 0,
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final res = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      errorFormatText: Strings.of(context)!.messageErrorDatePicker,
      errorInvalidText: Strings.of(context)!.messageErrorInvalidDatePicker,
      helpText: Strings.of(context)!.hintTextDateOfBirth,
      context: context,
      initialDate: viewModel.editingProfile?.dateOfBirth != null
          ? viewModel.editingProfile!.dateOfBirth!
          : DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(3000),
    );
    if (res != null) {
      viewModel.dateOfBirthController.text =
          DateFormat('dd/MM/yyyy').format(res);
      viewModel.onChangeDateOfBirth(res);
    } else {
      viewModel.dateOfBirthController.text = "";
      viewModel.onChangeDateOfBirth(res);
    }
  }

  Widget _buildAddressTextField() {
    return AppInput(
      contentPaddingVertical: 12.h,
      label: Strings.of(context)!.hintTextAddress,
      hintText: Strings.of(context)!.hintTextAddress,
      controller: viewModel.addressController,
      maxLength: 255,
      onChanged: (value) {
        viewModel.onChangeAddress();
      },
    );
  }

  Widget _buildDisplayNameTextField() {
    return AppInput(
      contentPaddingVertical: 12.h,
      label: Strings.of(context)!.hintTextDisplayName,
      hintText: Strings.of(context)!.hintTextDisplayName,
      controller: viewModel.nameController,
      maxLength: 255,
      onChanged: (value) {
        viewModel.onChangeDisPlayName();
      },
    );
  }

  Widget _buildLastNameTextField() {
    return AppInput(
      contentPaddingVertical: 12.h,
      label: Strings.of(context)!.hintTextLastName,
      hintText: Strings.of(context)!.hintTextLastName,
      controller: viewModel.lastNameController,
      maxLength: 255,
      onChanged: (value) {
        viewModel.onChangeLastName();
      },
    );
  }

  Widget _buildFirstNameTextField() {
    return AppInput(
      contentPaddingVertical: 12.h,
      label: Strings.of(context)!.hintTextFirstName,
      hintText: Strings.of(context)!.hintTextFirstName,
      controller: viewModel.firstNameController,
      maxLength: 255,
      onChanged: (value) {
        viewModel.onChangeFirstName();
      },
    );
  }

  Widget _buildPhoneNumberTextField() {
    return PhoneNumberWidget(
      label: Strings.of(context)!.hintTextPhoneNumber,
      hintText: Strings.of(context)!.hintTextPhoneNumber,
      controller: viewModel.phoneController,
      onChange: (value) {
        viewModel.onChangePhoneNumber(value);
      },
    );
  }

  Widget _buildIconEditImage() {
    return _buildButtonPopupMenuAvatar();
  }

  Widget _buildImage() {
    return Selector<UpdateProfileViewModel, ProfileModel?>(
      selector: (_, viewModel) => viewModel.editingProfile,
      shouldRebuild: (pre, next) => true,
      builder: (_, editDataModel, __) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 4, color: AppColor.primary.shade400),
            shape: BoxShape.circle,
          ),
          child: AvatarWidget(
            avatar: editDataModel?.avatarFile,
            isSvg: editDataModel?.isSvg ?? false,
          ),
        );
      },
    );
  }

  Widget _buttonUpdate() {
    return Selector<UpdateProfileViewModel, bool>(
      selector: (_, viewModel) => viewModel.isEdit,
      builder: (_, isEdit, __) {
        return Center(
          child: AppButton(
            width: 166.w,
            label: Strings.of(context)!.labelButtonSubmit,
            isDisableButton: !isEdit,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final res = await viewModel.onPressUpdate();
                if (isEdit) {
                  if (!mounted) return;
                  if (res) {
                    widget.callBack();
                    Navigator.of(context).pop();
                  }
                }
              }
            },
          ),
        );
      },
    );
  }
}
