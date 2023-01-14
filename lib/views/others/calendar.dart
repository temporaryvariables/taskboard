import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/state/app_state.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, required this.item});

  final TBItem item;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List<String> days = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
  ];

  var showingDate = DateTime.now();
  var todaysDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.item.dueDate != null) {
      Provider.of<AppState>(context, listen: false).selectedDate =
          widget.item.dueDate;
      showingDate = widget.item.dueDate!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) {
        return Center(
          child: SizedBox(
            height: 320,
            width: 250,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showingDate = DateTime.now();
                        });
                      },
                      child: const Text("Today"),
                    ),
                    GestureDetector(
                      onTap: () {
                        value.setSelectedDate(null);
                      },
                      child: Icon(
                        Icons.refresh,
                        color: value.selectedDate == null
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 14,
                      ),
                      onPressed: () {
                        setState(() {
                          showingDate =
                              DateTime(showingDate.year, showingDate.month - 1);
                        });
                      },
                    ),
                    const Spacer(),
                    Text(
                        '${months[showingDate.month - 1]} ${showingDate.year}'),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                      ),
                      onPressed: () {
                        setState(() {
                          showingDate =
                              DateTime(showingDate.year, showingDate.month + 1);
                        });
                      },
                    ),
                  ],
                ),
                Expanded(child: getGridView(value)),
              ],
            ),
          ),
        );
      },
    );
  }

  GridView getGridView(AppState value) {
    var daysInMonth = DateTime(showingDate.year, showingDate.month + 1, 0).day;
    var firstDayOfMonth =
        DateTime(showingDate.year, showingDate.month, 1).weekday;
    if (firstDayOfMonth == 7) firstDayOfMonth = 0;
    return GridView.count(
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      crossAxisCount: 7,
      padding: const EdgeInsets.all(0),
      children: [
        for (var i = 0; i < days.length; i++)
          Center(
            child: Text(
              days[i],
              style: const TextStyle(fontSize: 12),
            ),
          ),
        for (var i = 0; i < firstDayOfMonth; i++) const Center(child: Text("")),
        for (var i = 0; i < daysInMonth; i++)
          GestureDetector(
            onTap: () {
              value.setSelectedDate(
                  DateTime(showingDate.year, showingDate.month, i + 1));
            },
            child: Container(
              color: getDayColor(i, value.selectedDate),
              child: Center(
                child: Text(
                  (i + 1).toString(),
                ),
              ),
            ),
          )
      ],
    );
  }

  Color? getDayColor(int i, selectedDate) {
    if (selectedDate != null &&
        (selectedDate!.month == showingDate.month &&
            selectedDate!.year == showingDate.year &&
            selectedDate!.day == i + 1)) {
      return backgroundLightWhite;
    } else if (showingDate.month == todaysDate.month &&
        showingDate.year == todaysDate.year &&
        i == todaysDate.day) {
      return backgroundTodayWhite;
    } else {
      return null;
    }
  }
}
