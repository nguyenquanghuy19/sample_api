import 'package:elearning/core/data/models/meaning_model.dart';
import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_input.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormMeaningWidget extends StatefulWidget {
  final int numberMeaningTextField;
  final Function(MeaningModel?) callBack;

  const FormMeaningWidget({
    Key? key,
    required this.numberMeaningTextField,
    required this.callBack,
  }) : super(key: key);

  @override
  State<FormMeaningWidget> createState() => _FormMeaningWidgetState();
}

class _FormMeaningWidgetState extends State<FormMeaningWidget> {
  final TextEditingController wordMeaningController = TextEditingController();
  final TextEditingController exampleMeaningController =
      TextEditingController();

  final MeaningModel meaningModel = MeaningModel();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Strings.of(context)!.numberMeaning(widget.numberMeaningTextField),
              style: AppText.text21,
            ),
            SizedBox(height: 15.h),
            Text(Strings.of(context)!.wordMeaning, style: AppText.text16),
            SizedBox(height: 10.h),
            AppInput(
              hintText: Strings.of(context)!.enterWordMeaningVie,
              hintStyle: AppText.text14
                  .copyWith(color: AppColor.neutrals.withOpacity(0.5)),
              controller: wordMeaningController,
              onChanged: (value) {
                meaningModel.wordMeaning[widget.numberMeaningTextField].word =
                    wordMeaningController.text;
                widget.callBack(meaningModel);
              },
            ),
            SizedBox(height: 10.h),
            Text(Strings.of(context)!.example, style: AppText.text16),
            SizedBox(height: 10.h),
            AppInput(
              hintText: Strings.of(context)!.exampleWordMeaningEng,
              hintStyle: AppText.text14
                  .copyWith(color: AppColor.neutrals.withOpacity(0.5)),
              controller: exampleMeaningController,
              onChanged: (value) {
                meaningModel.exampleMeaning[widget.numberMeaningTextField]
                    .example = exampleMeaningController.text;
                widget.callBack(meaningModel);
              },
            ),
          ],
        ),
      ),
    );
  }
}
