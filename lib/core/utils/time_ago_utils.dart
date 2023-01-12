import 'package:elearning/core/l10n/strings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class TimeAgoUtils {
  static String? timeAgo({
    bool numericDates = true,
    required BuildContext context,
    required DateTime time,
  }) {
    final date2 = DateTime.now();
    final difference = date2.difference(time);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates)
          ? Strings.of(context)!.oneWeekAgo
          : Strings.of(context)!.lastWeek;
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} ${Strings.of(context)!.daysAgo}';
    } else if (difference.inDays >= 1) {
      return (numericDates)
          ? Strings.of(context)!.oneDayAgo
          : Strings.of(context)!.yesterday;
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} ${Strings.of(context)!.hoursAgo}';
    } else if (difference.inHours >= 1) {
      return (numericDates)
          ? Strings.of(context)!.oneHourAgo
          : Strings.of(context)!.anHourAgo;
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} ${Strings.of(context)!.minutesAgo}';
    } else if (difference.inMinutes >= 1) {
      return (numericDates)
          ? Strings.of(context)!.oneMinuteAgo
          : Strings.of(context)!.aMinuteAgo;
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} ${Strings.of(context)!.minutesAgo}';
    } else {
      return Strings.of(context)!.justNow;
    }
  }

  static String? dateFormat(DateTime? createdAt, BuildContext context) {
    if (createdAt != null) {
      Duration difference = DateTime.now().difference(createdAt);
      if (difference.inSeconds < 3) {
        return Strings.of(context)!.justNow;
      } else if (difference.inMinutes == 1) {
        return Strings.of(context)!.titleMinuteNotification;
      } else if (difference.inMinutes < 1) {
        return Strings.of(context)!
            .titleSecondsNotification("${difference.inSeconds}");
      } else if (difference.inHours < 1) {
        return Strings.of(context)!
            .titleMinutesNotification("${difference.inMinutes}");
      } else if (difference.inHours == 1) {
        return Strings.of(context)!.titleHourNotification;
      } else if (difference.inHours < 24) {
        return Strings.of(context)!
            .titleHoursNotification("${difference.inHours}");
      } else if (difference.inDays == 1) {
        return Strings.of(context)!
            .titleOneDayNotification(DateFormat('hh:mm a').format(createdAt));
      } else if (difference.inDays < 7) {
        return Strings.of(context)!
            .titleDaysNotification("${difference.inDays}");
      } else if ((difference.inDays / 7).floor() == 1) {
        return Strings.of(context)!.titleWeekNotification;
      } else if ((difference.inDays / 7).floor() > 1 &&
          (difference.inDays / 7).floor() <= 4) {
        return Strings.of(context)!
            .titleWeeksNotification("${(difference.inDays / 7).floor()}");
      } else {
        return DateFormat(DateFormat.YEAR_MONTH_WEEKDAY_DAY).format(createdAt);
      }
    }

    return null;
  }
}
