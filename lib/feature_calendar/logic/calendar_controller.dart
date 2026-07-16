import 'package:flutter/material.dart';

/// Controller to manage state and logic for the calendar.
class CalendarController extends ChangeNotifier {
  DateTime _currentMonth = DateTime(2025, 6);
  DateTime? _selectedDate = DateTime(2025, 6, 27);

  /// Getter for the current month.
  DateTime get currentMonth => _currentMonth;
  /// Getter for the selected date.
  DateTime? get selectedDate => _selectedDate;

  /// Navigates to the previous month.
  void previousMonth() {
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    notifyListeners();
  }

  /// Navigates to the next month.
  void nextMonth() {
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    notifyListeners();
  }

  /// Updates the selected date.
  void onDaySelected(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
