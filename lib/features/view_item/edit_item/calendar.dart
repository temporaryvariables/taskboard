import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskboard/constants.dart';
import 'package:taskboard/helper.dart';
import 'package:taskboard/models/isar_models/tb_item.dart';
import 'package:taskboard/app_state.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key, required this.item});

  final TBItem item;

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  var showingDate = DateTime.now();
  var todaysDate = DateTime.now();
  DateTime? dueDate;
  DateTime? endDate;
  DateType mode = DateType.single;
  bool settingEndDate = false;
  TBItem get item => widget.item;

  @override
  void initState() {
    super.initState();
    if (item.dueDate != null && item.endDate != null) {
      mode = DateType.range;
      dueDate = item.dueDate;
      endDate = item.endDate;
    } else if (item.dueDate != null) {
      mode = DateType.single;
      dueDate = item.dueDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) {
        return Center(
          child: SizedBox(
            height: 500,
            width: 500,
            child: Card(
              elevation: 1,
              borderOnForeground: true,
              child: Column(
                children: [
                  Text("Mode: ${mode.toString()}"),
                  Text(
                      "start: ${dueDate != null ? getFormatedDate(dueDate!) : "null"}"),
                  Text(
                      "end: ${endDate != null ? getFormatedDate(endDate!) : "null"}"),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (mode == DateType.single) {
                          mode = DateType.range;
                        } else {
                          mode = DateType.single;
                        }
                      });
                    },
                    child: Text("Current mode $mode"),
                  ),
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
                          setState(() {
                            dueDate = null;
                            endDate = null;
                          });
                        },
                        child: Icon(
                          Icons.refresh,
                          color: dueDate == null ? disabledGray : enabledBlack,
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
                            showingDate = DateTime(
                                showingDate.year, showingDate.month - 1);
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
                            showingDate = DateTime(
                                showingDate.year, showingDate.month + 1);
                          });
                        },
                      ),
                    ],
                  ),
                  Expanded(child: getGridView(value)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Cancel"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          var i = item;
                          i.dueDate = dueDate;
                          if (mode == DateType.range) {
                            i.endDate = endDate;
                          } else {
                            i.endDate = null;
                          }
                          value.addItem(i);
                          Navigator.pop(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Done"),
                        ),
                      )
                    ],
                  )
                ],
              ),
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
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        for (var i = 0; i < firstDayOfMonth; i++)
          const Center(
            child: Text(""),
          ),
        for (var i = 0; i < daysInMonth; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                if (mode == DateType.range) {
                  if (settingEndDate) {
                    endDate =
                        DateTime(showingDate.year, showingDate.month, i + 1);
                    settingEndDate = false;
                    if (endDate!.isBefore(dueDate!)) {
                      var temp = dueDate;
                      dueDate = endDate;
                      endDate = temp;
                    }
                  } else {
                    dueDate =
                        DateTime(showingDate.year, showingDate.month, i + 1);
                    settingEndDate = true;
                    endDate = null;
                  }
                } else {
                  dueDate =
                      DateTime(showingDate.year, showingDate.month, i + 1);
                }
              });
            },
            child: Container(
              color: getDayColor(
                  DateTime(showingDate.year, showingDate.month, i + 1),
                  dueDate,
                  endDate),
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

  Color? getDayColor(
      DateTime i, DateTime? selectedDate, DateTime? selectedEndDate) {
    if (selectedDate != null && selectedDate == i) {
      return accent2;
    } else if (mode == DateType.range &&
        selectedDate != null &&
        selectedEndDate != null &&
        i.isAfter(selectedDate) &&
        i.isBefore(selectedEndDate.add(const Duration(days: 1)))) {
      return accent2;
    } else if (showingDate == i) {
      return accent;
    }
    return null;
  }
}
