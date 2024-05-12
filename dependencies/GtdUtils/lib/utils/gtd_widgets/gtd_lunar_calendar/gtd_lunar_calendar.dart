import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_lunar_calendar/gtd_luna_converter/gtd_lunar_converter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:gtd_utils/data/configuration/color_config/colors_extension.dart';
import 'package:gtd_utils/helpers/extension/build_context_extension.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';

enum GtdLunarDayType { start, end, inRange, invisible, visible, currentDate }

enum GtdLunaDayBehavior { both, onlyStart, onlyEnd }

enum GtdLunarDateMode { single, range }

typedef GtdRangeDate = ({DateTime? startDate, DateTime? endDate});

class GtdLunarCalendar extends StatefulWidget {
  final String startDateLabel;
  final String endDateLabel;
  late final DateTime? minDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final GtdLunarDateMode lunarDateMode;
  final GtdLunaDayBehavior lunaDayBehavior;
  final Widget Function(BuildContext context, {DateTime? startDate, DateTime? endDate})? headerBuilder;
  final Widget Function(BuildContext context, {DateTime? startDate, DateTime? endDate, Sink<bool>? resetSink})?
      bottomBuilder;
  // final StatefulBuilder? bottomBuilder;
  GtdLunarCalendar(
      {super.key,
      this.headerBuilder,
      required this.bottomBuilder,
      this.startDate,
      this.endDate,
      DateTime? minDate,
      this.lunarDateMode = GtdLunarDateMode.range,
      this.lunaDayBehavior = GtdLunaDayBehavior.both,
      this.startDateLabel = "Vào",
      this.endDateLabel = "Ra"}) {
    if (lunaDayBehavior == GtdLunaDayBehavior.onlyEnd) {
      this.minDate = startDate;
    } else {
      this.minDate = minDate;
    }
  }

  @override
  State<GtdLunarCalendar> createState() => _GtdLunarCalendarState();
}

class _GtdLunarCalendarState extends State<GtdLunarCalendar> {
  DateTime? _startDate;
  DateTime? _endDate;
  StreamController<bool> resetController = StreamController();
  DateRangePickerView viewType = DateRangePickerView.month;
  final DateRangePickerController _controller = DateRangePickerController();

  @override
  void initState() {
    _startDate = widget.startDate;
    _endDate = widget.endDate;
    super.initState();
    resetController.stream.listen((event) {
      if (event == true) {
        setState(() {
          _startDate = null;
          _endDate = null;
        });
      }
    });
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _startDate = args.value.startDate;
        _endDate = args.value.endDate;
      } else if (args.value is DateTime) {
        switch (widget.lunaDayBehavior) {
          case GtdLunaDayBehavior.onlyStart:
            _startDate = args.value;
            break;
          case GtdLunaDayBehavior.onlyEnd:
            if (_startDate != null && (args.value as DateTime).isBefore(_startDate!)) {
              _endDate = null;
            } else {
              _endDate = args.value;
            }

            break;
          default:
            _startDate = args.value;
            break;
        }
      } else if (args.value is List<DateTime>) {
        // _dateCount = args.value.length.toString();
      } else {
        // _rangeCount = args.value.length.toString();
      }
    });
  }

  Widget rightShapeSide() {
    return Center(
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          Expanded(
            child: ColoredBox(
              color: (_endDate != null && _startDate != _endDate) ? AppColors.lightMainColor : Colors.transparent,
              child: const SizedBox(
                height: 48,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftShapeSide() {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: ColoredBox(
              color: (_endDate != null && _startDate != _endDate) ? AppColors.lightMainColor : Colors.transparent,
              child: const SizedBox(
                height: 48,
                width: double.infinity,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  Widget subLabel(Alignment alignment, String label) {
    return Align(
      alignment: alignment,
      child: Material(
        color: CustomColors.mainOrange,
        shape: const CircleBorder(side: BorderSide(color: CustomColors.mainOrange)),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            label,
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget customDayView(
      {required String sunDay,
      required DateTime lunarDay,
      bool hasCircleRound = false,
      bool isVisible = true,
      bool iSelected = false}) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          sunDay,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: isVisible ? (iSelected ? AppColors.mainColor : Colors.grey.shade900) : Colors.grey.shade400),
        ),
        Text(
          lunarDay.localDate(lunarDay.day != 1 ? "d" : "d/M"),
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: lunarDay.day == 1
                  ? Colors.red
                  : isVisible
                      ? (iSelected ? Colors.grey.shade900 : Colors.grey.shade600)
                      : Colors.grey.shade400),
        ),
      ],
    );
  }

  Widget buildDayView(
      {required DateTime sunDay, required DateTime lunarDay, GtdLunarDayType lunarDayType = GtdLunarDayType.visible}) {
    if (lunarDayType == GtdLunarDayType.currentDate) {
      return Stack(
        children: [
          const SizedBox(),
          Center(
            child: ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Colors.grey.shade200), borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
    if (lunarDayType == GtdLunarDayType.invisible) {
      return Center(
        child: ColoredBox(
          color: Colors.transparent,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay, isVisible: false),
          ),
        ),
      );
    }
    if (lunarDayType == GtdLunarDayType.inRange) {
      return Center(
        child: ColoredBox(
          color: AppColors.lightMainColor,
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay),
          ),
        ),
      );
    }
    if (lunarDayType == GtdLunarDayType.start) {
      return Stack(
        children: [
          rightShapeSide(),
          Center(
            child: ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Card(
                  elevation: 1,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: AppColors.mainColor), borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay, iSelected: true),
                  ),
                ),
              ),
            ),
          ),
          subLabel(Alignment.topLeft, widget.startDateLabel),
        ],
      );
    }

    if (lunarDayType == GtdLunarDayType.end) {
      return Stack(
        children: [
          leftShapeSide(),
          Center(
            child: ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                width: 48,
                child: Card(
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: AppColors.mainColor), borderRadius: BorderRadius.circular(24)),
                  child: Center(
                    child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay, iSelected: true),
                  ),
                ),
              ),
            ),
          ),
          subLabel(Alignment.bottomRight, widget.endDateLabel),
        ],
      );
    }
    return Center(
      child: ColoredBox(
        color: Colors.transparent,
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: customDayView(sunDay: sunDay.day.toString(), lunarDay: lunarDay),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.headerBuilder?.call(context, startDate: _startDate, endDate: _endDate) ?? const SizedBox(),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return SizedBox(
                height: context.mediaQuery.size.height - 140,
                child: SfDateRangePicker(
                  controller: _controller,
                  onSelectionChanged: _onSelectionChanged,
                  initialSelectedDate: DateTime.now(),
                  initialSelectedDates: [_startDate, _endDate].whereType<DateTime>().toList(),
                  selectionMode: (switch (widget.lunarDateMode) {
                    GtdLunarDateMode.range => DateRangePickerSelectionMode.range,
                    GtdLunarDateMode.single => DateRangePickerSelectionMode.single
                  }),
                  minDate: widget.minDate ?? DateTime.now().subtract(const Duration(days: 7)),
                  enableMultiView: true,
                  enablePastDates: false,
                  extendableRangeSelectionDirection: ExtendableRangeSelectionDirection.both,
                  toggleDaySelection: true,
                  viewSpacing: 0,
                  selectionRadius: -1,
                  allowViewNavigation: true,
                  navigationDirection: DateRangePickerNavigationDirection.vertical,
                  showNavigationArrow: false,
                  navigationMode: DateRangePickerNavigationMode.scroll,
                  selectionShape: DateRangePickerSelectionShape.circle,
                  selectionTextStyle: const TextStyle(color: Colors.white),
                  selectionColor: Colors.transparent,
                  startRangeSelectionColor: Colors.transparent,
                  endRangeSelectionColor: Colors.transparent,
                  rangeSelectionColor: Colors.transparent,
                  onViewChanged: (dateRangePickerViewChangedArgs) {
                    viewType = dateRangePickerViewChangedArgs.view;
                  },
                  headerHeight: 30,
                  headerStyle: DateRangePickerHeaderStyle(
                      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                  monthFormat: "MMMM",
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    viewHeaderStyle: DateRangePickerViewHeaderStyle(
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600, fontSize: 12),
                    ),
                  ),
                  cellBuilder: (context, cellDetails) {
                    return cellBuilder(context, cellDetails);
                  },
                  initialSelectedRange: PickerDateRange(DateTime.now(), DateTime.now().add(const Duration(days: 3))),
                ),
              );
            },
          ),
        ),
        // widget.bottomBuilder?.builder(context, setState) ?? const SizedBox(),
        widget.bottomBuilder
                ?.call(context, startDate: _startDate, endDate: _endDate, resetSink: resetController.sink) ??
            const SizedBox(),
      ],
    );
  }

  Widget cellBuilder(BuildContext context, DateRangePickerCellDetails cellDetails) {
    var lunarDate = GtdLunarConverter.convertSolar2Lunar(cellDetails.date);
    if (_controller.view == DateRangePickerView.month) {
      if (cellDetails.date.isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
        return buildDayView(sunDay: cellDetails.date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.invisible);
      }
      if (cellDetails.date.isSameDate(_startDate)) {
        return buildDayView(sunDay: cellDetails.date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.start);
      }

      if (cellDetails.date.isSameDate(_endDate)) {
        return buildDayView(sunDay: cellDetails.date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.end);
      }
      if (_startDate != null &&
          _endDate != null &&
          cellDetails.date.isAfter(_startDate!) &&
          cellDetails.date.isBefore(_endDate!)) {
        return buildDayView(sunDay: cellDetails.date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.inRange);
      }

      if (cellDetails.date.day == DateTime.now().day &&
          cellDetails.date.month == DateTime.now().month &&
          cellDetails.date.year == DateTime.now().year) {
        return buildDayView(sunDay: cellDetails.date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.currentDate);
      }
      return buildDayView(sunDay: cellDetails.date, lunarDay: lunarDate, lunarDayType: GtdLunarDayType.visible);
    } else if (_controller.view == DateRangePickerView.year) {
      return Column(
        children: [
          const SizedBox(
            child: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
          ),
          SizedBox(
            child: Text(DateFormat('MMMM', "vi").format(cellDetails.date)),
          )
        ],
      );
    } else if (_controller.view == DateRangePickerView.decade) {
      return Column(
        children: [
          const SizedBox(
            child: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
          ),
          SizedBox(
            child: Text(DateFormat('yyyy').format(cellDetails.date)),
          )
        ],
      );
    } else {
      final int yearValue = cellDetails.date.year;
      return Column(
        children: [
          const SizedBox(
            child: Icon(
              Icons.wb_sunny,
              color: Colors.yellow,
            ),
          ),
          SizedBox(
            child: Text('$yearValue - ${yearValue + 9}'),
          )
        ],
      );
    }
  }

  @override
  void dispose() {
    resetController.close();
    super.dispose();
  }
}
