import 'dart:async';

import 'package:elearning/core/l10n/strings.dart';
import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberWidget extends StatefulWidget {
  final TextEditingController? controller;
  final double? contentPaddingHorizontal;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double radius;
  final String? hintText;
  final String? phoneNumberRequired;
  final Function(String?)? onChange;
  final String? label;

  const PhoneNumberWidget({
    Key? key,
    this.controller,
    this.contentPaddingHorizontal,
    this.textStyle,
    this.hintStyle,
    this.radius = 100,
    this.hintText,
    this.phoneNumberRequired,
    this.onChange,
    this.label,
  }) : super(key: key);

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  String? validPhoneNumber;

  @override
  void initState() {
    super.initState();
    validPhoneNumber = widget.phoneNumberRequired;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: 8.h,
            ),
            child: Text(
              widget.label!,
              style:
                  AppText.text16.copyWith(color: AppColor.primary.shade400),
            ),
          ),
        IntlPhoneField(
          decoration: InputDecoration(
            counter: const SizedBox.shrink(),
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            hintStyle: widget.hintStyle ??
                AppText.text20.copyWith(color: AppColor.neutrals.withOpacity(0.5)),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
          onChanged: (value) {
            if (widget.onChange != null) {
              widget.onChange!(getPhoneNumber(value));
            }
          },
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]{0,1}[0-9]*')),
            TextInputFormatter.withFunction(
              (oldValue, newValue) => newValue.copyWith(
                text: newValue.text.replaceAll('.', ','),
              ),
            ),
          ],
          controller: widget.controller,
          style: widget.textStyle ??
              AppText.text20.copyWith(fontWeight: FontWeight.bold),
          flagsButtonMargin: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          showDropdownIcon: false,
          textAlignVertical: TextAlignVertical.center,
          invalidNumberMessage: validPhoneNumber,
          validator: (value) {
            validatePhoneNumber(value);

            return validPhoneNumber;
          },
          initialCountryCode: 'VN',
        ),
      ],
    );
  }

  String? getPhoneNumber(PhoneNumber phoneNumber) {
    Country country =
        countries.firstWhere((_) => _.code == phoneNumber.countryISOCode);
    if (phoneNumber.number.length >= country.minLength &&
        phoneNumber.number.length <= country.maxLength) {
      return phoneNumber.number;
    }

    return null;
  }

  void validatePhoneNumber(PhoneNumber? phoneNumber) {
    if (phoneNumber == null || phoneNumber.number.isEmpty) {
      setState(() {
        validPhoneNumber = widget.phoneNumberRequired;
      });
    } else {
      Country country =
          countries.firstWhere((_) => _.code == phoneNumber.countryISOCode);
      if (phoneNumber.number.length >= country.minLength &&
          phoneNumber.number.length <= country.maxLength) {
        setState(() {
          validPhoneNumber = widget.phoneNumberRequired;
        });
      } else {
        setState(() {
          validPhoneNumber = Strings.of(context)!.phoneNumberInValid;
        });
      }
    }
  }
}

const List<Country> countries = [
  Country(
    name: "Afghanistan",
    flag: "🇦🇫",
    code: "AF",
    dialCode: "93",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Åland Islands",
    flag: "🇦🇽",
    code: "AX",
    dialCode: "358",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Albania",
    flag: "🇦🇱",
    code: "AL",
    dialCode: "355",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Algeria",
    flag: "🇩🇿",
    code: "DZ",
    dialCode: "213",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "American Samoa",
    flag: "🇦🇸",
    code: "AS",
    dialCode: "1684",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Andorra",
    flag: "🇦🇩",
    code: "AD",
    dialCode: "376",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Angola",
    flag: "🇦🇴",
    code: "AO",
    dialCode: "244",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Anguilla",
    flag: "🇦🇮",
    code: "AI",
    dialCode: "1264",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Antarctica",
    flag: "🇦🇶",
    code: "AQ",
    dialCode: "672",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Antigua and Barbuda",
    flag: "🇦🇬",
    code: "AG",
    dialCode: "1268",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Argentina",
    flag: "🇦🇷",
    code: "AR",
    dialCode: "54",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Armenia",
    flag: "🇦🇲",
    code: "AM",
    dialCode: "374",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Aruba",
    flag: "🇦🇼",
    code: "AW",
    dialCode: "297",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Australia",
    flag: "🇦🇺",
    code: "AU",
    dialCode: "61",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Austria",
    flag: "🇦🇹",
    code: "AT",
    dialCode: "43",
    minLength: 13,
    maxLength: 13,
  ),
  Country(
    name: "Azerbaijan",
    flag: "🇦🇿",
    code: "AZ",
    dialCode: "994",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Bahamas",
    flag: "🇧🇸",
    code: "BS",
    dialCode: "1242",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Bahrain",
    flag: "🇧🇭",
    code: "BH",
    dialCode: "973",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Bangladesh",
    flag: "🇧🇩",
    code: "BD",
    dialCode: "880",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Barbados",
    flag: "🇧🇧",
    code: "BB",
    dialCode: "1246",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Belarus",
    flag: "🇧🇾",
    code: "BY",
    dialCode: "375",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Belgium",
    flag: "🇧🇪",
    code: "BE",
    dialCode: "32",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Belize",
    flag: "🇧🇿",
    code: "BZ",
    dialCode: "501",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Benin",
    flag: "🇧🇯",
    code: "BJ",
    dialCode: "229",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Bermuda",
    flag: "🇧🇲",
    code: "BM",
    dialCode: "1441",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Bhutan",
    flag: "🇧🇹",
    code: "BT",
    dialCode: "975",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Bolivia, Plurinational State of bolivia",
    flag: "🇧🇴",
    code: "BO",
    dialCode: "591",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Bosnia and Herzegovina",
    flag: "🇧🇦",
    code: "BA",
    dialCode: "387",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Botswana",
    flag: "🇧🇼",
    code: "BW",
    dialCode: "267",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Bouvet Island",
    flag: "🇧🇻",
    code: "BV",
    dialCode: "47",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Brazil",
    flag: "🇧🇷",
    code: "BR",
    dialCode: "55",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "British Indian Ocean Territory",
    flag: "🇮🇴",
    code: "IO",
    dialCode: "246",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Brunei Darussalam",
    flag: "🇧🇳",
    code: "BN",
    dialCode: "673",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Bulgaria",
    flag: "🇧🇬",
    code: "BG",
    dialCode: "359",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Burkina Faso",
    flag: "🇧🇫",
    code: "BF",
    dialCode: "226",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Burundi",
    flag: "🇧🇮",
    code: "BI",
    dialCode: "257",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Cambodia",
    flag: "🇰🇭",
    code: "KH",
    dialCode: "855",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Cameroon",
    flag: "🇨🇲",
    code: "CM",
    dialCode: "237",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Canada",
    flag: "🇨🇦",
    code: "CA",
    dialCode: "1",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Cape Verde",
    flag: "🇨🇻",
    code: "CV",
    dialCode: "238",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Cayman Islands",
    flag: "🇰🇾",
    code: "KY",
    dialCode: "345",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Central African Republic",
    flag: "🇨🇫",
    code: "CF",
    dialCode: "236",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Chad",
    flag: "🇹🇩",
    code: "TD",
    dialCode: "235",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Chile",
    flag: "🇨🇱",
    code: "CL",
    dialCode: "56",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "China",
    flag: "🇨🇳",
    code: "CN",
    dialCode: "86",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Christmas Island",
    flag: "🇨🇽",
    code: "CX",
    dialCode: "61",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Cocos (Keeling) Islands",
    flag: "🇨🇨",
    code: "CC",
    dialCode: "61",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Colombia",
    flag: "🇨🇴",
    code: "CO",
    dialCode: "57",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Comoros",
    flag: "🇰🇲",
    code: "KM",
    dialCode: "269",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Congo",
    flag: "🇨🇬",
    code: "CG",
    dialCode: "242",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Congo, The Democratic Republic of the Congo",
    flag: "🇨🇩",
    code: "CD",
    dialCode: "243",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Cook Islands",
    flag: "🇨🇰",
    code: "CK",
    dialCode: "682",
    minLength: 5,
    maxLength: 5,
  ),
  Country(
    name: "Costa Rica",
    flag: "🇨🇷",
    code: "CR",
    dialCode: "506",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Côte d'Ivoire",
    flag: "🇨🇮",
    code: "CI",
    dialCode: "225",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Croatia",
    flag: "🇭🇷",
    code: "HR",
    dialCode: "385",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Cuba",
    flag: "🇨🇺",
    code: "CU",
    dialCode: "53",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Cyprus",
    flag: "🇨🇾",
    code: "CY",
    dialCode: "357",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Czech Republic",
    flag: "🇨🇿",
    code: "CZ",
    dialCode: "420",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Denmark",
    flag: "🇩🇰",
    code: "DK",
    dialCode: "45",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Djibouti",
    flag: "🇩🇯",
    code: "DJ",
    dialCode: "253",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Dominica",
    flag: "🇩🇲",
    code: "DM",
    dialCode: "1767",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Dominican Republic",
    flag: "🇩🇴",
    code: "DO",
    dialCode: "1849",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Ecuador",
    flag: "🇪🇨",
    code: "EC",
    dialCode: "593",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Egypt",
    flag: "🇪🇬",
    code: "EG",
    dialCode: "20",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "El Salvador",
    flag: "🇸🇻",
    code: "SV",
    dialCode: "503",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Equatorial Guinea",
    flag: "🇬🇶",
    code: "GQ",
    dialCode: "240",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Eritrea",
    flag: "🇪🇷",
    code: "ER",
    dialCode: "291",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Estonia",
    flag: "🇪🇪",
    code: "EE",
    dialCode: "372",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Ethiopia",
    flag: "🇪🇹",
    code: "ET",
    dialCode: "251",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Falkland Islands (Malvinas)",
    flag: "🇫🇰",
    code: "FK",
    dialCode: "500",
    minLength: 5,
    maxLength: 5,
  ),
  Country(
    name: "Faroe Islands",
    flag: "🇫🇴",
    code: "FO",
    dialCode: "298",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Fiji",
    flag: "🇫🇯",
    code: "FJ",
    dialCode: "679",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Finland",
    flag: "🇫🇮",
    code: "FI",
    dialCode: "358",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "France",
    flag: "🇫🇷",
    code: "FR",
    dialCode: "33",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "French Guiana",
    flag: "🇬🇫",
    code: "GF",
    dialCode: "594",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "French Polynesia",
    flag: "🇵🇫",
    code: "PF",
    dialCode: "689",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "French Southern Territories",
    flag: "🇹🇫",
    code: "TF",
    dialCode: "262",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Gabon",
    flag: "🇬🇦",
    code: "GA",
    dialCode: "241",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Gambia",
    flag: "🇬🇲",
    code: "GM",
    dialCode: "220",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Georgia",
    flag: "🇬🇪",
    code: "GE",
    dialCode: "995",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Germany",
    flag: "🇩🇪",
    code: "DE",
    dialCode: "49",
    minLength: 9,
    maxLength: 13,
  ),
  Country(
    name: "Ghana",
    flag: "🇬🇭",
    code: "GH",
    dialCode: "233",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Gibraltar",
    flag: "🇬🇮",
    code: "GI",
    dialCode: "350",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Greece",
    flag: "🇬🇷",
    code: "GR",
    dialCode: "30",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Greenland",
    flag: "🇬🇱",
    code: "GL",
    dialCode: "299",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Grenada",
    flag: "🇬🇩",
    code: "GD",
    dialCode: "1473",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Guadeloupe",
    flag: "🇬🇵",
    code: "GP",
    dialCode: "590",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Guam",
    flag: "🇬🇺",
    code: "GU",
    dialCode: "1671",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Guatemala",
    flag: "🇬🇹",
    code: "GT",
    dialCode: "502",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Guernsey",
    flag: "🇬🇬",
    code: "GG",
    dialCode: "44",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Guinea",
    flag: "🇬🇳",
    code: "GN",
    dialCode: "224",
    minLength: 8,
    maxLength: 9,
  ),
  Country(
    name: "Guinea-Bissau",
    flag: "🇬🇼",
    code: "GW",
    dialCode: "245",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Guyana",
    flag: "🇬🇾",
    code: "GY",
    dialCode: "592",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Haiti",
    flag: "🇭🇹",
    code: "HT",
    dialCode: "509",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Heard Island and Mcdonald Islands",
    flag: "🇭🇲",
    code: "HM",
    dialCode: "672",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Holy See (Vatican City State)",
    flag: "🇻🇦",
    code: "VA",
    dialCode: "379",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Honduras",
    flag: "🇭🇳",
    code: "HN",
    dialCode: "504",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Hong Kong",
    flag: "🇭🇰",
    code: "HK",
    dialCode: "852",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Hungary",
    flag: "🇭🇺",
    code: "HU",
    dialCode: "36",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Iceland",
    flag: "🇮🇸",
    code: "IS",
    dialCode: "354",
    minLength: 7,
    maxLength: 9,
  ),
  Country(
    name: "India",
    flag: "🇮🇳",
    code: "IN",
    dialCode: "91",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Indonesia",
    flag: "🇮🇩",
    code: "ID",
    dialCode: "62",
    minLength: 13,
    maxLength: 13,
  ),
  Country(
    name: "Iran, Islamic Republic of Persian Gulf",
    flag: "🇮🇷",
    code: "IR",
    dialCode: "98",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Iraq",
    flag: "🇮🇶",
    code: "IQ",
    dialCode: "964",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Ireland",
    flag: "🇮🇪",
    code: "IE",
    dialCode: "353",
    minLength: 7,
    maxLength: 9,
  ),
  Country(
    name: "Isle of Man",
    flag: "🇮🇲",
    code: "IM",
    dialCode: "44",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Israel",
    flag: "🇮🇱",
    code: "IL",
    dialCode: "972",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Italy",
    flag: "🇮🇹",
    code: "IT",
    dialCode: "39",
    minLength: 13,
    maxLength: 13,
  ),
  Country(
    name: "Jamaica",
    flag: "🇯🇲",
    code: "JM",
    dialCode: "1876",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Japan",
    flag: "🇯🇵",
    code: "JP",
    dialCode: "81",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Jersey",
    flag: "🇯🇪",
    code: "JE",
    dialCode: "44",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Jordan",
    flag: "🇯🇴",
    code: "JO",
    dialCode: "962",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Kazakhstan",
    flag: "🇰🇿",
    code: "KZ",
    dialCode: "7",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Kenya",
    flag: "🇰🇪",
    code: "KE",
    dialCode: "254",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Kiribati",
    flag: "🇰🇮",
    code: "KI",
    dialCode: "686",
    minLength: 5,
    maxLength: 5,
  ),
  Country(
    name: "Korea, Democratic People's Republic of Korea",
    flag: "🇰🇵",
    code: "KP",
    dialCode: "850",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Korea, Republic of South Korea",
    flag: "🇰🇷",
    code: "KR",
    dialCode: "82",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Kosovo",
    flag: "🇽🇰",
    code: "XK",
    dialCode: "383",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Kuwait",
    flag: "🇰🇼",
    code: "KW",
    dialCode: "965",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Kyrgyzstan",
    flag: "🇰🇬",
    code: "KG",
    dialCode: "996",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Laos",
    flag: "🇱🇦",
    code: "LA",
    dialCode: "856",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Latvia",
    flag: "🇱🇻",
    code: "LV",
    dialCode: "371",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Lebanon",
    flag: "🇱🇧",
    code: "LB",
    dialCode: "961",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Lesotho",
    flag: "🇱🇸",
    code: "LS",
    dialCode: "266",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Liberia",
    flag: "🇱🇷",
    code: "LR",
    dialCode: "231",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Libyan Arab Jamahiriya",
    flag: "🇱🇾",
    code: "LY",
    dialCode: "218",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Liechtenstein",
    flag: "🇱🇮",
    code: "LI",
    dialCode: "423",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Lithuania",
    flag: "🇱🇹",
    code: "LT",
    dialCode: "370",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Luxembourg",
    flag: "🇱🇺",
    code: "LU",
    dialCode: "352",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Macao",
    flag: "🇲🇴",
    code: "MO",
    dialCode: "853",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Macedonia",
    flag: "🇲🇰",
    code: "MK",
    dialCode: "389",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Madagascar",
    flag: "🇲🇬",
    code: "MG",
    dialCode: "261",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Malawi",
    flag: "🇲🇼",
    code: "MW",
    dialCode: "265",
    minLength: 7,
    maxLength: 9,
  ),
  Country(
    name: "Malaysia",
    flag: "🇲🇾",
    code: "MY",
    dialCode: "60",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Maldives",
    flag: "🇲🇻",
    code: "MV",
    dialCode: "960",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Mali",
    flag: "🇲🇱",
    code: "ML",
    dialCode: "223",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Malta",
    flag: "🇲🇹",
    code: "MT",
    dialCode: "356",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Marshall Islands",
    flag: "🇲🇭",
    code: "MH",
    dialCode: "692",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Martinique",
    flag: "🇲🇶",
    code: "MQ",
    dialCode: "596",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Mauritania",
    flag: "🇲🇷",
    code: "MR",
    dialCode: "222",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Mauritius",
    flag: "🇲🇺",
    code: "MU",
    dialCode: "230",
    minLength: 7,
    maxLength: 8,
  ),
  Country(
    name: "Mayotte",
    flag: "🇾🇹",
    code: "YT",
    dialCode: "262",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Mexico",
    flag: "🇲🇽",
    code: "MX",
    dialCode: "52",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Micronesia, Federated States of Micronesia",
    flag: "🇫🇲",
    code: "FM",
    dialCode: "691",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Moldova",
    flag: "🇲🇩",
    code: "MD",
    dialCode: "373",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Monaco",
    flag: "🇲🇨",
    code: "MC",
    dialCode: "377",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Mongolia",
    flag: "🇲🇳",
    code: "MN",
    dialCode: "976",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Montenegro",
    flag: "🇲🇪",
    code: "ME",
    dialCode: "382",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Montserrat",
    flag: "🇲🇸",
    code: "MS",
    dialCode: "1664",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Morocco",
    flag: "🇲🇦",
    code: "MA",
    dialCode: "212",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Mozambique",
    flag: "🇲🇿",
    code: "MZ",
    dialCode: "258",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Myanmar",
    flag: "🇲🇲",
    code: "MM",
    dialCode: "95",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Namibia",
    flag: "🇳🇦",
    code: "NA",
    dialCode: "264",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Nauru",
    flag: "🇳🇷",
    code: "NR",
    dialCode: "674",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Nepal",
    flag: "🇳🇵",
    code: "NP",
    dialCode: "977",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Netherlands",
    flag: "🇳🇱",
    code: "NL",
    dialCode: "31",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Netherlands Antilles",
    flag: "",
    code: "AN",
    dialCode: "599",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "New Caledonia",
    flag: "🇳🇨",
    code: "NC",
    dialCode: "687",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "New Zealand",
    flag: "🇳🇿",
    code: "NZ",
    dialCode: "64",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Nicaragua",
    flag: "🇳🇮",
    code: "NI",
    dialCode: "505",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Niger",
    flag: "🇳🇪",
    code: "NE",
    dialCode: "227",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Nigeria",
    flag: "🇳🇬",
    code: "NG",
    dialCode: "234",
    minLength: 10,
    maxLength: 11,
  ),
  Country(
    name: "Niue",
    flag: "🇳🇺",
    code: "NU",
    dialCode: "683",
    minLength: 4,
    maxLength: 4,
  ),
  Country(
    name: "Norfolk Island",
    flag: "🇳🇫",
    code: "NF",
    dialCode: "672",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Northern Mariana Islands",
    flag: "🇲🇵",
    code: "MP",
    dialCode: "1670",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Norway",
    flag: "🇳🇴",
    code: "NO",
    dialCode: "47",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Oman",
    flag: "🇴🇲",
    code: "OM",
    dialCode: "968",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Pakistan",
    flag: "🇵🇰",
    code: "PK",
    dialCode: "92",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Palau",
    flag: "🇵🇼",
    code: "PW",
    dialCode: "680",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Palestinian Territory, Occupied",
    flag: "🇵🇸",
    code: "PS",
    dialCode: "970",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Panama",
    flag: "🇵🇦",
    code: "PA",
    dialCode: "507",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Papua New Guinea",
    flag: "🇵🇬",
    code: "PG",
    dialCode: "675",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Paraguay",
    flag: "🇵🇾",
    code: "PY",
    dialCode: "595",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Peru",
    flag: "🇵🇪",
    code: "PE",
    dialCode: "51",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Philippines",
    flag: "🇵🇭",
    code: "PH",
    dialCode: "63",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Pitcairn",
    flag: "🇵🇳",
    code: "PN",
    dialCode: "64",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Poland",
    flag: "🇵🇱",
    code: "PL",
    dialCode: "48",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Portugal",
    flag: "🇵🇹",
    code: "PT",
    dialCode: "351",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Puerto Rico",
    flag: "🇵🇷",
    code: "PR",
    dialCode: "1939",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Qatar",
    flag: "🇶🇦",
    code: "QA",
    dialCode: "974",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Romania",
    flag: "🇷🇴",
    code: "RO",
    dialCode: "40",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Russia",
    flag: "🇷🇺",
    code: "RU",
    dialCode: "7",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Rwanda",
    flag: "🇷🇼",
    code: "RW",
    dialCode: "250",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Reunion",
    flag: "🇷🇪",
    code: "RE",
    dialCode: "262",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Saint Barthelemy",
    flag: "🇧🇱",
    code: "BL",
    dialCode: "590",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Saint Helena, Ascension and Tristan Da Cunha",
    flag: "🇸🇭",
    code: "SH",
    dialCode: "290",
    minLength: 4,
    maxLength: 4,
  ),
  Country(
    name: "Saint Kitts and Nevis",
    flag: "🇰🇳",
    code: "KN",
    dialCode: "1869",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Saint Lucia",
    flag: "🇱🇨",
    code: "LC",
    dialCode: "1758",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Saint Martin",
    flag: "🇲🇫",
    code: "MF",
    dialCode: "590",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Saint Pierre and Miquelon",
    flag: "🇵🇲",
    code: "PM",
    dialCode: "508",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Saint Vincent and the Grenadines",
    flag: "🇻🇨",
    code: "VC",
    dialCode: "1784",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Samoa",
    flag: "🇼🇸",
    code: "WS",
    dialCode: "685",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "San Marino",
    flag: "🇸🇲",
    code: "SM",
    dialCode: "378",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Sao Tome and Principe",
    flag: "🇸🇹",
    code: "ST",
    dialCode: "239",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Saudi Arabia",
    flag: "🇸🇦",
    code: "SA",
    dialCode: "966",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Senegal",
    flag: "🇸🇳",
    code: "SN",
    dialCode: "221",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Serbia",
    flag: "🇷🇸",
    code: "RS",
    dialCode: "381",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Seychelles",
    flag: "🇸🇨",
    code: "SC",
    dialCode: "248",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Sierra Leone",
    flag: "🇸🇱",
    code: "SL",
    dialCode: "232",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Singapore",
    flag: "🇸🇬",
    code: "SG",
    dialCode: "65",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Slovakia",
    flag: "🇸🇰",
    code: "SK",
    dialCode: "421",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Slovenia",
    flag: "🇸🇮",
    code: "SI",
    dialCode: "386",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Solomon Islands",
    flag: "🇸🇧",
    code: "SB",
    dialCode: "677",
    minLength: 5,
    maxLength: 5,
  ),
  Country(
    name: "Somalia",
    flag: "🇸🇴",
    code: "SO",
    dialCode: "252",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "South Africa",
    flag: "🇿🇦",
    code: "ZA",
    dialCode: "27",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "South Sudan",
    flag: "🇸🇸",
    code: "SS",
    dialCode: "211",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "South Georgia and the South Sandwich Islands",
    flag: "🇬🇸",
    code: "GS",
    dialCode: "500",
    minLength: 15,
    maxLength: 15,
  ),
  Country(
    name: "Spain",
    flag: "🇪🇸",
    code: "ES",
    dialCode: "34",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Sri Lanka",
    flag: "🇱🇰",
    code: "LK",
    dialCode: "94",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Sudan",
    flag: "🇸🇩",
    code: "SD",
    dialCode: "249",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Suriname",
    flag: "🇸🇷",
    code: "SR",
    dialCode: "597",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Svalbard and Jan Mayen",
    flag: "🇸🇯",
    code: "SJ",
    dialCode: "47",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Eswatini",
    flag: "🇸🇿",
    code: "SZ",
    dialCode: "268",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Sweden",
    flag: "🇸🇪",
    code: "SE",
    dialCode: "46",
    minLength: 13,
    maxLength: 13,
  ),
  Country(
    name: "Switzerland",
    flag: "🇨🇭",
    code: "CH",
    dialCode: "41",
    minLength: 12,
    maxLength: 12,
  ),
  Country(
    name: "Syrian Arab Republic",
    flag: "🇸🇾",
    code: "SY",
    dialCode: "963",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Taiwan",
    flag: "🇹🇼",
    code: "TW",
    dialCode: "886",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Tajikistan",
    flag: "🇹🇯",
    code: "TJ",
    dialCode: "992",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Tanzania, United Republic of Tanzania",
    flag: "🇹🇿",
    code: "TZ",
    dialCode: "255",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Thailand",
    flag: "🇹🇭",
    code: "TH",
    dialCode: "66",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Timor-Leste",
    flag: "🇹🇱",
    code: "TL",
    dialCode: "670",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Togo",
    flag: "🇹🇬",
    code: "TG",
    dialCode: "228",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Tokelau",
    flag: "🇹🇰",
    code: "TK",
    dialCode: "690",
    minLength: 4,
    maxLength: 4,
  ),
  Country(
    name: "Tonga",
    flag: "🇹🇴",
    code: "TO",
    dialCode: "676",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Trinidad and Tobago",
    flag: "🇹🇹",
    code: "TT",
    dialCode: "1868",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Tunisia",
    flag: "🇹🇳",
    code: "TN",
    dialCode: "216",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Turkey",
    flag: "🇹🇷",
    code: "TR",
    dialCode: "90",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Turkmenistan",
    flag: "🇹🇲",
    code: "TM",
    dialCode: "993",
    minLength: 8,
    maxLength: 8,
  ),
  Country(
    name: "Turks and Caicos Islands",
    flag: "🇹🇨",
    code: "TC",
    dialCode: "1649",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Tuvalu",
    flag: "🇹🇻",
    code: "TV",
    dialCode: "688",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Uganda",
    flag: "🇺🇬",
    code: "UG",
    dialCode: "256",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Ukraine",
    flag: "🇺🇦",
    code: "UA",
    dialCode: "380",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "United Arab Emirates",
    flag: "🇦🇪",
    code: "AE",
    dialCode: "971",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "United Kingdom",
    flag: "🇬🇧",
    code: "GB",
    dialCode: "44",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "United States",
    flag: "🇺🇸",
    code: "US",
    dialCode: "1",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Uruguay",
    flag: "🇺🇾",
    code: "UY",
    dialCode: "598",
    minLength: 11,
    maxLength: 11,
  ),
  Country(
    name: "Uzbekistan",
    flag: "🇺🇿",
    code: "UZ",
    dialCode: "998",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Vanuatu",
    flag: "🇻🇺",
    code: "VU",
    dialCode: "678",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Venezuela, Bolivarian Republic of Venezuela",
    flag: "🇻🇪",
    code: "VE",
    dialCode: "58",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Vietnam",
    flag: "🇻🇳",
    code: "VN",
    dialCode: "84",
    minLength: 10,
    maxLength: 10,
  ),
  Country(
    name: "Virgin Islands, British",
    flag: "🇻🇬",
    code: "VG",
    dialCode: "1284",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Virgin Islands, U.S.",
    flag: "🇻🇮",
    code: "VI",
    dialCode: "1340",
    minLength: 7,
    maxLength: 7,
  ),
  Country(
    name: "Wallis and Futuna",
    flag: "🇼🇫",
    code: "WF",
    dialCode: "681",
    minLength: 6,
    maxLength: 6,
  ),
  Country(
    name: "Yemen",
    flag: "🇾🇪",
    code: "YE",
    dialCode: "967",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Zambia",
    flag: "🇿🇲",
    code: "ZM",
    dialCode: "260",
    minLength: 9,
    maxLength: 9,
  ),
  Country(
    name: "Zimbabwe",
    flag: "🇿🇼",
    code: "ZW",
    dialCode: "263",
    minLength: 9,
    maxLength: 9,
  ),
];

class Country {
  final String name;
  final String flag;
  final String code;
  final String dialCode;
  final int minLength;
  final int maxLength;

  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.minLength,
    required this.maxLength,
  });
}

class IntlPhoneField extends StatefulWidget {
  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<PhoneNumber>? onChanged;

  final ValueChanged<Country>? onCountryChanged;

  /// An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  ///
  /// A [PhoneNumber] is passed to the validator as argument.
  /// The validator can handle asynchronous validation when declared as a [Future].
  /// Or run synchronously when declared as a [Function].
  ///
  /// By default, the validator checks whether the input number length is between selected country's phone numbers min and max length.
  /// If `disableLengthCheck` is not set to `true`, your validator returned value will be overwritten by the default validator.
  /// But, if `disableLengthCheck` is set to `true`, your validator will have to check phone number length itself.
  final FutureOr<String?> Function(PhoneNumber?)? validator;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled": it ignores taps, the [TextFormField]'s
  /// [decoration] is rendered in grey,
  /// [decoration]'s [InputDecoration.counterText] is set to `""`,
  /// and the drop down icon is hidden no matter [showDropdownIcon] value.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.brightness].
  final Brightness? keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  /// 2 Letter ISO Code
  final String? initialCountryCode;

  /// List of 2 Letter ISO Codes of countries to show. Defaults to showing the inbuilt list of all countries.
  final List<String>? countries;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool disableLengthCheck;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  /// The style use for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// The text that describes the search input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on top of the input field (i.e., at the same location on the screen where text may be entered in the input field).
  /// When the input field receives focus (or if the field is non-empty), the label moves above (i.e., vertically adjacent to) the input field.
  final String searchText;

  /// Position of an icon [leading, trailing]
  final IconPosition dropdownIconPosition;

  /// Icon of the drop down button.
  ///
  /// Default is [Icon(Icons.arrow_drop_down)]
  final Icon dropdownIcon;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Autovalidate mode for text form field.
  ///
  /// If [AutovalidateMode.onUserInteraction], this FormField will only auto-validate after its content changes.
  /// If [AutovalidateMode.always], it will auto-validate even without user interaction.
  /// If [AutovalidateMode.disabled], auto-validation will be disabled.
  ///
  /// Defaults to [AutovalidateMode.onUserInteraction].
  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showCountryFlag;

  /// Message to be displayed on autoValidate error
  ///
  /// Default value is `Invalid Mobile Number`.
  final String? invalidNumberMessage;

  /// The color of the cursor.
  final Color? cursorColor;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius? cursorRadius;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// Whether to show cursor.
  final bool? showCursor;

  /// The padding of the Flags Button.
  ///
  /// The amount of insets that are applied to the Flags Button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsetsGeometry flagsButtonPadding;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Optional set of styles to allow for customizing the country search
  /// & pick dialog
  final PickerDialogStyle? pickerDialogStyle;

  /// The margin of the country selector button.
  ///
  /// The amount of space to surround the country selector button.
  ///
  /// If unset, defaults to [EdgeInsets.zero].
  final EdgeInsets flagsButtonMargin;

  const IntlPhoneField({
    Key? key,
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    @Deprecated('Use searchFieldInputDecoration of PickerDialogStyle instead')
        this.searchText = 'Search country',
    this.dropdownIconPosition = IconPosition.leading,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.flagsButtonPadding = EdgeInsets.zero,
    this.invalidNumberMessage = 'Invalid Mobile Number',
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.pickerDialogStyle,
    this.flagsButtonMargin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries
            .where((country) => widget.countries!.contains(country.code))
            .toList();
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere(
        (country) => number.startsWith(country.dialCode),
        orElse: () => _countryList.first,
      );
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry = _countryList.firstWhere(
        (item) => item.code == (widget.initialCountryCode ?? 'US'),
        orElse: () => _countryList.first,
      );
    }

    if (widget.autovalidateMode == AutovalidateMode.always) {
      final initialPhoneNumber = PhoneNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.dialCode}',
        number: widget.initialValue ?? '',
      );

      final value = widget.validator?.call(initialPhoneNumber);

      if (value is String) {
        validatorMessage = value;
      } else {
        (value as Future).then((msg) {
          validatorMessage = msg;
        });
      }
    }
  }

  Future<void> _changeCountry() async {
    filteredCountries = _countryList;
    await showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) => StatefulBuilder(
        builder: (ctx, setState) => CountryPickerDialog(
          style: widget.pickerDialogStyle,
          filteredCountries: filteredCountries,
          searchText: widget.searchText,
          countryList: _countryList,
          selectedCountry: _selectedCountry,
          onCountryChanged: (Country country) {
            _selectedCountry = country;
            widget.onCountryChanged?.call(country);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: (widget.controller == null) ? number : null,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      showCursor: widget.showCursor,
      onFieldSubmitted: widget.onSubmitted,
      decoration: widget.decoration.copyWith(
        prefixIcon: _buildFlagsButton(),
        prefixIconConstraints:
            const BoxConstraints(minHeight: 20, minWidth: 20),
        counterText: !widget.enabled ? '' : null,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
      ),
      style: widget.style,
      onSaved: (value) {
        widget.onSaved?.call(
          PhoneNumber(
            countryISOCode: _selectedCountry.code,
            countryCode: '+${_selectedCountry.dialCode}',
            number: value!,
          ),
        );
      },
      onChanged: (value) async {
        final phoneNumber = PhoneNumber(
          countryISOCode: _selectedCountry.code,
          countryCode: '+${_selectedCountry.dialCode}',
          number: value,
        );

        if (widget.autovalidateMode != AutovalidateMode.disabled) {
          validatorMessage = await widget.validator?.call(phoneNumber);
        }

        widget.onChanged?.call(phoneNumber);
      },
      validator: (value) {
        if (!widget.disableLengthCheck && value != null) {
          return value.length >= _selectedCountry.minLength &&
                  value.length <= _selectedCountry.maxLength
              ? null
              : widget.invalidNumberMessage;
        }

        return validatorMessage;
      },
      maxLength: widget.disableLengthCheck ? null : _selectedCountry.maxLength,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
    );
  }

  Container _buildFlagsButton() {
    return Container(
      margin: widget.flagsButtonMargin,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: InkWell(
          borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
          onTap: widget.enabled ? _changeCountry : null,
          child: Padding(
            padding: widget.flagsButtonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.enabled &&
                    widget.showDropdownIcon &&
                    widget.dropdownIconPosition == IconPosition.leading) ...[
                  widget.dropdownIcon,
                  const SizedBox(width: 4),
                ],
                if (widget.showCountryFlag) ...[
                  Image.asset(
                    'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                    package: 'intl_phone_field',
                    width: 32,
                  ),
                  const SizedBox(width: 8),
                ],
                FittedBox(
                  child: Text(
                    '+${_selectedCountry.dialCode}',
                    style: widget.dropdownTextStyle,
                  ),
                ),
                if (widget.enabled &&
                    widget.showDropdownIcon &&
                    widget.dropdownIconPosition == IconPosition.trailing) ...[
                  const SizedBox(width: 4),
                  widget.dropdownIcon,
                ],
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum IconPosition {
  leading,
  trailing,
}

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;

  const CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    const defaultHorizontalPadding = 40.0;
    const defaultVerticalPadding = 24.0;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        vertical: defaultVerticalPadding,
        horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
            ? (mediaWidth - width) / 2
            : defaultHorizontalPadding,
      ),
      backgroundColor: widget.style?.backgroundColor,
      child: Container(
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  widget.style?.searchFieldPadding ?? const EdgeInsets.all(0),
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                decoration: widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: const Icon(Icons.search),
                      labelText: widget.searchText,
                    ),
                onChanged: (value) {
                  _filteredCountries = isNumeric(value)
                      ? widget.countryList
                          .where((country) => country.dialCode.contains(value))
                          .toList()
                      : widget.countryList
                          .where((country) => country.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                        package: 'intl_phone_field',
                        width: 32,
                      ),
                      contentPadding: widget.style?.listTilePadding,
                      title: Text(
                        _filteredCountries[index].name,
                        style: widget.style?.countryNameStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      trailing: Text(
                        '+${_filteredCountries[index].dialCode}',
                        style: widget.style?.countryCodeStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onTap: () {
                        _selectedCountry = _filteredCountries[index];
                        widget.onCountryChanged(_selectedCountry);
                        Navigator.of(context).pop();
                      },
                    ),
                    widget.style?.listTileDivider ??
                        const Divider(thickness: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;

class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  String get completeNumber {
    return countryCode + number;
  }

  @override
  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
