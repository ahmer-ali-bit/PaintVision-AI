import 'package:flutter/material.dart';
import 'package:paint_vision_ai/providers/additional%20feature/home%20visit%20provider/home_visit_provider.dart';
import 'package:provider/provider.dart';
import 'package:paint_vision_ai/core/constants/app_colors.dart';

class Step1Schedule extends StatelessWidget {
  const Step1Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final provider = context.watch<HomeVisitProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 📅 SELECT DATE
        Text(
          'Select Date',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04),
        ),
        SizedBox(height: height * 0.015),

        // 📅 CALENDAR
        Container(
          padding: EdgeInsets.all(width * 0.03),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              // Month Navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: provider.previousMonth,
                    child: Icon(
                      Icons.chevron_left,
                      size: width * 0.06,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    provider.monthName,
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: provider.nextMonth,
                    child: Icon(
                      Icons.chevron_right,
                      size: width * 0.06,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.015),

              // Weekday Headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .map(
                      (day) => Text(
                        day,
                        style: TextStyle(
                          fontSize: width * 0.028,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    .toList(),
              ),

              SizedBox(height: height * 0.01),

              // Days Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemCount: provider.daysInMonth + provider.firstWeekday,
                itemBuilder: (context, index) {
                  if (index < provider.firstWeekday) {
                    return const SizedBox();
                  }

                  final day = index - provider.firstWeekday + 1;
                  final date = DateTime(
                    provider.displayMonth.year,
                    provider.displayMonth.month,
                    day,
                  );
                  final isSelected =
                      provider.selectedDate.year == date.year &&
                      provider.selectedDate.month == date.month &&
                      provider.selectedDate.day == date.day;

                  return GestureDetector(
                    onTap: () => provider.setDate(date),
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$day',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        SizedBox(height: height * 0.025),

        // 🕐 SELECT TIME SLOT
        Text(
          'Select Time Slot',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: width * 0.04),
        ),
        SizedBox(height: height * 0.015),

        // Time Slots Grid (2 columns)
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: width * 0.03,
            mainAxisSpacing: width * 0.03,
            childAspectRatio: 2.8,
          ),
          itemCount: provider.timeSlots.length,
          itemBuilder: (context, index) {
            final slot = provider.timeSlots[index];
            final isSelected = provider.selectedTimeSlot == slot;

            return GestureDetector(
              onTap: () => provider.setTimeSlot(slot),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    slot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: width * 0.032,
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        SizedBox(height: height * 0.02),
      ],
    );
  }
}
