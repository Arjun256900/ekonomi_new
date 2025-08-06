import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthCalendar extends StatefulWidget {
  final DateTime initialMonth;
  final List<int> highlightedDays; // e.g. [5, 15, 18]

  MonthCalendar({
    Key? key,
    DateTime? initialMonth,
    this.highlightedDays = const [],
  }) : initialMonth = initialMonth ?? DateTime.now(),
       super(key: key);

  @override
  _MonthCalendarState createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.initialMonth.year,
      widget.initialMonth.month,
    );
  }

  void _prevMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month - 1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthLabel = DateFormat.MMMM().format(_displayedMonth);
    final daysInMonth = DateUtils.getDaysInMonth(
      _displayedMonth.year,
      _displayedMonth.month,
    );
    final firstWeekday =
        DateTime(_displayedMonth.year, _displayedMonth.month, 1).weekday %
        7; // Sunday=0

    List<Widget> dayRows = [];

    // Weekday titles
    final weekdayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    dayRows.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: weekdayLabels.map((d) {
          final isSunday = d == 'S' && weekdayLabels.indexOf(d) == 0;
          return Expanded(
            child: Center(
              child: Text(
                d,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSunday ? Colors.black : Colors.grey[600],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );

    int dayCounter = 1;
    for (int week = 0; week < 6; week++) {
      List<Widget> weekDays = [];
      for (int weekday = 0; weekday < 7; weekday++) {
        if (week == 0 && weekday < firstWeekday || dayCounter > daysInMonth) {
          weekDays.add(Expanded(child: SizedBox()));
        } else {
          final isHighlighted = widget.highlightedDays.contains(dayCounter);
          final isSunday = weekday == 0;

          weekDays.add(
            Expanded(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(4),
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 6,
                  ),
                  decoration: isHighlighted
                      ? BoxDecoration(
                          color: Colors.teal[100],
                          borderRadius: BorderRadius.circular(6),
                        )
                      : null,
                  child: Text(
                    dayCounter.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isSunday ? Colors.green : Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
          );
          dayCounter++;
        }
      }
      dayRows.add(Row(children: weekDays));
      if (dayCounter > daysInMonth) break;
    }

    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: _prevMonth,
              ),
              Text(
                monthLabel,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF03969D),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: _nextMonth,
              ),
            ],
          ),
        ),
        // Calendar Container
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: dayRows),
        ),
      ],
    );
  }
}
