import 'package:flutter/material.dart';

/// The main functional screen displaying the monthly calendar and events.
class CalendarScreen extends StatefulWidget {
  /// Creates a [CalendarScreen].
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(2025, 6);
    _selectedDate = DateTime(2025, 6, 27);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _onDaySelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final monthName = _getMonthName(_currentMonth.month);
    final year = _currentMonth.year;

    final daysInMonth = DateUtils.getDaysInMonth(year, _currentMonth.month);
    final firstDayOffset =
        DateTime(year, _currentMonth.month).weekday - 1;

    final totalCells = ((daysInMonth + firstDayOffset) / 7).ceil() * 7;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'Calendar',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black87,
                  ),
                  onPressed: _previousMonth,
                ),
                Text(
                  '$monthName $year',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                    color: Colors.black87,
                  ),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: weekdays.map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
              ),
              itemCount: totalCells,
              itemBuilder: (context, index) {
                final dayNumber = index - firstDayOffset + 1;
                final isValidDay = dayNumber > 0 && dayNumber <= daysInMonth;

                final isSelected = isValidDay &&
                    _selectedDate?.year == year &&
                    _selectedDate?.month == _currentMonth.month &&
                    _selectedDate?.day == dayNumber;

                return GestureDetector(
                  onTap: isValidDay
                      ? () => _onDaySelected(
                    DateTime(year, _currentMonth.month, dayNumber),
                  )
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 0.5,
                      ),
                      color: isValidDay ? Colors.white : Colors.grey.shade50,
                    ),
                    child: isValidDay
                        ? Center(
                      child: isSelected
                          ? Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black87,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$dayNumber',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      )
                          : Text(
                        '$dayNumber',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF8A22),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
