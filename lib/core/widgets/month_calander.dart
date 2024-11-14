import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/text_styles.dart';
import 'package:school_of_future/core/widgets/text.dart';

class AppMonthChanger extends StatefulWidget {
  const AppMonthChanger({
    super.key,
    required this.getMonthChange,
    this.selectedDay,
    this.canGoToFutureMonth = true,
  });

  final Function(DateTime) getMonthChange;
  final DateTime? selectedDay;
  final bool canGoToFutureMonth;

  @override
  AppMonthChangerState createState() => AppMonthChangerState();
}

class AppMonthChangerState extends State<AppMonthChanger> {
  late DateTime currentDate;

  var isFutureArrowDisable = false;

  @override
  void didUpdateWidget(covariant AppMonthChanger oldWidget) {
    if (widget.selectedDay != null) {
      currentDate = widget.selectedDay!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    currentDate = widget.selectedDay ?? DateTime.now();
    if (!widget.canGoToFutureMonth &&
        currentDate.month == DateTime.now().month) {
      isFutureArrowDisable = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              iconSize: 48,
              onPressed: () {
                setState(() {
                  currentDate =
                      DateTime(currentDate.year, currentDate.month - 1);
                  widget.getMonthChange(currentDate);
                  isFutureArrowDisable = false;
                });
              },
              icon: Icon(
                Icons.arrow_left_sharp,
                color: kPrimaryColor.withOpacity(0.52),
              )),
          TextB(
            text:
                '${getMonthName(currentDate)}, ${DateFormat('yyyy').format(currentDate)}',
            textStyle: bHead6B,
            fontColor: bGray100,
          ),
          IconButton(
              iconSize: 48,
              onPressed: () {
                setState(() {
                  if (widget.canGoToFutureMonth ||
                      currentDate.month != DateTime.now().month) {
                    currentDate =
                        DateTime(currentDate.year, currentDate.month + 1);
                    widget.getMonthChange(currentDate);

                    if (!widget.canGoToFutureMonth &&
                        currentDate.month == DateTime.now().month) {
                      isFutureArrowDisable = true;
                    } else {
                      isFutureArrowDisable = false;
                    }
                  }
                });
              },
              icon: Icon(
                Icons.arrow_right_sharp,
                color: isFutureArrowDisable
                    ? kTextDefaultColor.withOpacity(0.52)
                    : kPrimaryColor.withOpacity(0.52),
              )),
        ],
      ),
    );
  }

  String getMonthName(DateTime date, {String locale = 'en'}) {
    return DateFormat.MMMM(locale).format(date);
  }
}
