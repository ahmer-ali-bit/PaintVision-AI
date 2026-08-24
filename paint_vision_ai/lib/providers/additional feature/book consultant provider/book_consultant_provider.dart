import 'package:flutter/material.dart';
import 'package:paint_vision_ai/Screens/additional%20features/book%20color%20consultant/confirm%20appointment/confirm_appointment.dart';

class BookConsultantProvider extends ChangeNotifier {
  // 🎯 Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // 📌 Form Key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 📅 Selected Date
  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  String get formattedDate {
    if (_selectedDate == null) return '';
    return '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}';
  }

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  // 🕐 Time Dropdown
  String? _selectedTime;
  String? get selectedTime => _selectedTime;

  final List<String> timeSlots = [
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 01:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
    '04:00 PM - 05:00 PM',
    '05:00 PM - 06:00 PM',
  ];

  void setTime(String? time) {
    _selectedTime = time;
    notifyListeners();
  }

  // 📅 Date Picker
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2563EB),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setDate(picked);
    }
  }

  // ✅ Validators
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }
    if (value.length < 10) {
      return 'Enter valid phone number';
    }
    return null;
  }

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your location';
    }
    return null;
  }

  // 💾 Book Appointment (👇 UPDATED - Navigate to Confirmation)
  void bookAppointment(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a date')));
        return;
      }

      if (_selectedTime == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select a time')));
        return;
      }

      // 🎯 Debug Print
      debugPrint('Full Name: ${fullNameController.text}');
      debugPrint('Phone: ${phoneController.text}');
      debugPrint('Date: $formattedDate');
      debugPrint('Time: $_selectedTime');
      debugPrint('Location: ${locationController.text}');
      debugPrint('Notes: ${notesController.text}');

      // 🎯 Save data before clearing (so we can pass to confirmation)
      final appointmentDate = formattedDate;
      final appointmentTime = _selectedTime!;
      final appointmentLocation = locationController.text;

      // 🎯 Navigate to Confirmation Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ConfirmedAppointmentScreen(
            title: 'Appointment Confirmed!',
            subtitle: 'Your consultation is scheduled',
            date: appointmentDate,
            time: appointmentTime,
            location: appointmentLocation,
            consultant: 'Ali Raza',
            infoMessage: 'You will receive a call before the appointment.',
          ),
        ),
      );

      // 🧹 Clear form after navigation
      clearForm();
    }
  }

  // 🧹 Clear Form
  void clearForm() {
    fullNameController.clear();
    phoneController.clear();
    locationController.clear();
    notesController.clear();
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    locationController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
