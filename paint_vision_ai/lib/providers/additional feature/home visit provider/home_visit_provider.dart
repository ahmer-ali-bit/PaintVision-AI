import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20color%20consultant/confirm%20appointment/confirm_appointment.dart';

class HomeVisitProvider extends ChangeNotifier {
  // 🎯 Current Step (0, 1, 2)
  int _currentStep = 0;
  int get currentStep => _currentStep;

  // 📌 Form Keys for each step
  final GlobalKey<FormState> detailsFormKey = GlobalKey<FormState>();

  // 🎯 Controllers (Step 2)
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // 📅 Selected Date (Step 1)
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  // 📅 Display Month
  DateTime _displayMonth = DateTime.now();
  DateTime get displayMonth => _displayMonth;

  // 🕐 Selected Time Slot (Step 1)
  String? _selectedTimeSlot;
  String? get selectedTimeSlot => _selectedTimeSlot;

  final List<String> timeSlots = [
    '10:00 AM - 12:00 PM',
    '12:00 PM - 02:00 PM',
    '02:00 PM - 04:00 PM',
    '04:00 PM - 06:00 PM',
  ];

  // ================== STEP NAVIGATION ==================
  void nextStep(BuildContext context) {
    if (_currentStep == 0) {
      if (_selectedTimeSlot == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a time slot')),
        );
        return;
      }
      _currentStep = 1;
      notifyListeners();
    } else if (_currentStep == 1) {
      if (detailsFormKey.currentState!.validate()) {
        _currentStep = 2;
        notifyListeners();
      }
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  // ================== STEP 1: DATE & TIME ==================
  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setTimeSlot(String slot) {
    _selectedTimeSlot = slot;
    notifyListeners();
  }

  void nextMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month + 1);
    notifyListeners();
  }

  void previousMonth() {
    _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1);
    notifyListeners();
  }

  // 📅 Get Month Name
  String get monthName {
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
    return '${months[_displayMonth.month - 1]} ${_displayMonth.year}';
  }

  // 📅 Get Days in Month
  int get daysInMonth =>
      DateTime(_displayMonth.year, _displayMonth.month + 1, 0).day;

  // 📅 Get First Weekday (Monday = 0)
  int get firstWeekday {
    final first = DateTime(_displayMonth.year, _displayMonth.month, 1);
    return (first.weekday - 1) % 7;
  }

  // ================== VALIDATORS (STEP 2) ==================
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter your name';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter phone';
    if (value.length < 10) return 'Enter valid phone number';
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) return 'Please enter address';
    return null;
  }

  // ================== FORMATTED DATE ==================
  String get formattedDate {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[_selectedDate.month - 1]} ${_selectedDate.day}, ${_selectedDate.year}';
  }

  // ================== CONFIRM BOOKING (👇 UPDATED) ==================
  void confirmBooking(BuildContext context) {
    // 🎯 Debug Print
    debugPrint('Date: $formattedDate');
    debugPrint('Time: $_selectedTimeSlot');
    debugPrint('Name: ${fullNameController.text}');
    debugPrint('Phone: ${phoneController.text}');
    debugPrint('Address: ${addressController.text}');
    debugPrint('Notes: ${notesController.text}');

    // 🎯 Save data before clearing (so we can pass to confirmation)
    final visitDate = formattedDate;
    final visitTime = _selectedTimeSlot ?? '';
    final visitLocation = addressController.text;

    // 🎯 Navigate to Confirmation Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmedAppointmentScreen(
          title: 'Visit Confirmed!',
          subtitle: 'Your home visit is scheduled',
          date: visitDate,
          time: visitTime,
          location: visitLocation,
          consultant: 'Ali Raza',
          infoMessage: 'You will receive a call before the visit.',
        ),
      ),
    );

    // 🧹 Clear form after navigation
    clearForm();
  }

  // 🧹 Clear Form
  void clearForm() {
    _currentStep = 0;
    _selectedDate = DateTime.now();
    _selectedTimeSlot = null;
    fullNameController.clear();
    phoneController.clear();
    addressController.clear();
    notesController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
