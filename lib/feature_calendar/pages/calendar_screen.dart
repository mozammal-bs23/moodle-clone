import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/feature_calendar/logic/calendar_controller.dart';
import 'package:flutter_boilerplate/feature_calendar/widgets/calendar_grid.dart';
import 'package:flutter_boilerplate/feature_calendar/widgets/calendar_header.dart';

/// The main functional screen displaying the monthly calendar.
class CalendarScreen extends StatefulWidget {
  /// Creates a [CalendarScreen].
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final CalendarController _controller = CalendarController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleStateChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleStateChange);
    super.dispose();
  }

  /// Updates the UI when the controller notifies of changes.
  void _handleStateChange() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Calendar'),
        centerTitle: false,
        actions: [
          IconButton(icon: const Icon(Icons.filter_alt), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          CalendarHeader(
            currentMonth: _controller.currentMonth,
            onPrevious: _controller.previousMonth,
            onNext: _controller.nextMonth,
          ),
          Expanded(
            child: CalendarGrid(
              currentMonth: _controller.currentMonth,
              selectedDate: _controller.selectedDate,
              onDaySelected: _controller.onDaySelected,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFFFF8A22),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.black, size: 28),
      ),
    );
  }
}
