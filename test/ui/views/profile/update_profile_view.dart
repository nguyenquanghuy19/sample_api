import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_button.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:elearning/ui/views/base_view.dart';
import 'package:elearning/ui/widgets/phone_number_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../view_models/profile/update_profile_view_model.dart';

class UpdateProfileView extends BaseView {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  EditProfileViewState createState() => EditProfileViewState();
}

class EditProfileViewState
    extends BaseViewState<UpdateProfileView, UpdateProfileViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<PopupMenuButtonState<String>> _popupButtonKey = GlobalKey();

  @override
  void createViewModel() {
    super.createViewModel();
    viewModel = UpdateProfileViewModel()..onInitViewModel(context);
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
      appBar: AppBar(
        title: Text(Strings.of(context)!.titleAppBarUpdateProfile),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _showModalBottomSheet<void>();
                },
                child: Stack(
                  children: [
                    _buildImage(),
                    _buildIconEditImage(),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildFullNameTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildLastNameTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildFirstNameTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildDateOfBirth(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildGenderTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildPhoneNumberTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildAddressTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildCityTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buildCountryTextField(),
                  SizedBox(
                    height: 15.h,
                  ),
                  _buttonUpdate(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<T?> _showModalBottomSheet<T>() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(Strings.of(context)!.titleCamera),
                onTap: () =>
                    viewModel.getImage(ImageSource.camera).whenComplete(
                  () {
                    if (viewModel.image != null) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
              const Divider(
                color: AppColor.neutrals,
                height: 0,
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: Text(Strings.of(context)!.titleGallery),
                onTap: () =>
                    viewModel.getImage(ImageSource.gallery).whenComplete(
                  () {
                    if (viewModel.image != null) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCountryTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextCountry,
      hintText: Strings.of(context)!.hintTextCountry,
      controller: viewModel.countryController,
      prefixIcon: Icon(
        Icons.public,
        size: 18.h,
      ),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildCityTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextCity,
      hintText: Strings.of(context)!.hintTextCity,
      controller: viewModel.cityController,
      prefixIcon: Icon(
        Icons.location_city,
        size: 18.h,
      ),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildDateOfBirth() {
    return AppInput(
      label: Strings.of(context)!.hintTextDateOfBirth,
      onTap: _showDatePicker,
      controller: viewModel.dateOfBirthController,
      hintText: Strings.of(context)!.hintTextDateOfBirth,
      readOnly: true,
      suffixIcon: Icon(
        Icons.arrow_drop_down,
        size: 20.h,
      ),
      prefixIcon: Icon(
        Icons.calendar_month,
        size: 18.h,
      ),
    );
  }

  Future<void> _showDatePicker() async {
    final res = await showDatePicker(
      errorFormatText: Strings.of(context)!.messageErrorDatePicker,
      errorInvalidText: Strings.of(context)!.messageErrorInvalidDatePicker,
      helpText: Strings.of(context)!.hintTextDateOfBirth,
      context: context,
      initialDate: viewModel.editDataModel?.dateOfBirth != null
          ? viewModel.editDataModel!.dateOfBirth!
          : DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(3000),
    );
    if (res != null) {
      viewModel.dateOfBirthController.text =
          DateFormat('yyyy-MM-dd').format(res);
      viewModel.setEditDataModel();
    }
  }

  Widget _buildGenderTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextGender,
      readOnly: true,
      onTap: () {
        _popupButtonKey.currentState?.showButtonMenu();
      },
      suffixIcon: _buildButtonPopupMenu(),
      hintText: Strings.of(context)!.hintTextGender,
      controller: viewModel.genderController,
      prefixIcon: Icon(
        Icons.transgender,
        size: 18.h,
      ),
    );
  }

  Widget _buildButtonPopupMenu() {
    return PopupMenuButton<String>(
      key: _popupButtonKey,
      icon: Icon(
        Icons.arrow_drop_down,
        size: 20.h,
      ),
      onSelected: (value) {
        viewModel.genderController.text = value;
        viewModel.setEditDataModel();
      },
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: Strings.of(context)!.valueMale,
          child: Text(Strings.of(context)!.valueMale),
        ),
        PopupMenuItem<String>(
          value: Strings.of(context)!.valueFemale,
          child: Text(Strings.of(context)!.valueFemale),
        ),
        PopupMenuItem<String>(
          value: Strings.of(context)!.valueOther,
          child: Text(Strings.of(context)!.valueOther),
        ),
      ],
    );
  }

  Widget _buildAddressTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextAddress,
      hintText: Strings.of(context)!.hintTextAddress,
      controller: viewModel.addressController,
      prefixIcon: Icon(
        Icons.location_on,
        size: 18.h,
      ),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildFullNameTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextDisplayName,
      hintText: Strings.of(context)!.hintTextFullName,
      controller: viewModel.nameController,
      validator: (value) => viewModel.validateFullName(value, context),
      prefixIcon: Icon(
        Icons.theater_comedy,
        size: 18.h,
      ),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildLastNameTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextLastName,
      hintText: Strings.of(context)!.hintTextLastName,
      controller: viewModel.lastNameController,
      validator: (value) => viewModel.validateFullName(value, context),
      prefixIcon: Icon(
        Icons.person,
        size: 18.h,
      ),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildFirstNameTextField() {
    return AppInput(
      label: Strings.of(context)!.hintTextFirstName,
      hintText: Strings.of(context)!.hintTextFirstName,
      controller: viewModel.firstNameController,
      validator: (value) => viewModel.validateFullName(value, context),
      prefixIcon: Icon(
        Icons.person,
        size: 18.h,
      ),
      onChanged: (value) {
        viewModel.setEditDataModel();
      },
    );
  }

  Widget _buildPhoneNumberTextField() {
    return PhoneNumberWidget(
      label: Strings.of(context)!.hintTextPhoneNumber,
      hintText: Strings.of(context)!.hintTextPhoneNumber,
      controller: viewModel.phoneController,
      onChange: (value) {
        viewModel.setPhone(value);
      },
    );
  }

  Widget _buildIconEditImage() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.all(5.h),
          color: Colors.white,
          child: const Icon(
            Icons.add_a_photo,
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(width: 4, color: Colors.white),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 10,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 50.h,
        backgroundImage: const AssetImage('assets/images/default_avt.jpg'),
      ),
    );
  }

  Widget _buttonUpdate() {
    return Selector<UpdateProfileViewModel, bool>(
      selector: (_, viewModel) => viewModel.isEdit,
      builder: (_, isEdit, __) {
        return AppButton(
          label: Strings.of(context)!.labelButtonSubmit,
          styleLabel:
              isEdit ? AppText.text24.copyWith(color: Colors.white) : null,
          backgroundColor: isEdit ? AppColor.supporting.shade400 : Colors.white,
          onPressed: () => null,
        );
      },
    );
  }
}
