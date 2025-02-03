import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/providers/userdata_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/custom_snakbar.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class AgeSelectorScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const AgeSelectorScreen({required this.onContinue, super.key});

  @override
  State<AgeSelectorScreen> createState() => _AgeSelectorScreenState();
}

class _AgeSelectorScreenState extends State<AgeSelectorScreen> {
  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = 2018;

  final List<int> days = List.generate(31, (index) => index + 1);
  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 
    'August', 'September', 'October', 'November', 'December'
  ];
  final List<int> years = List.generate(100, (index) => 2023 - index);

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your age?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: context.watch<ColorProvider>().headingColor,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.55,
            decoration: BoxDecoration(
              gradient: containerGardient,
              border: GradientBoxBorder(
                gradient: containerBorderGardient,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPicker(
                      context: context,
                      items: days.map((day) => day.toString()).toList(),
                      selectedIndex: selectedDay - 1,
                      onChanged: (index) {
                        setState(() {
                          selectedDay = days[index];
                        });
                      },
                    ),
                    _buildPicker(
                      context: context,
                      items: months,
                      selectedIndex: selectedMonth,
                      onChanged: (index) {
                        setState(() {
                          selectedMonth = index;
                        });
                      },
                    ),
                    _buildPicker(
                      context: context,
                      items: years.map((year) => year.toString()).toList(),
                      selectedIndex: years.indexOf(selectedYear),
                      onChanged: (index) {
                        setState(() {
                          selectedYear = years[index];
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: buttonGardient),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: buttonBorderGardient,
                        ),
                        child: TextButton(
                          onPressed: () {
                            _validateAndProceed();
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Broken.arrow_right_2,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPicker({
    required BuildContext context,
    required List<String> items,
    required int selectedIndex,
    required ValueChanged<int> onChanged,
  }) {
    return SizedBox(
      width: 100,
      height: 200,
      child: CupertinoPicker(
        scrollController:
            FixedExtentScrollController(initialItem: selectedIndex),
        itemExtent: 50,
        diameterRatio: 1.2,
        selectionOverlay: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal:
                  BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
            ),
          ),
        ),
        onSelectedItemChanged: onChanged,
        children: items
            .map(
              (item) => Center(
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _validateAndProceed() {
    final selectedDate = DateTime(selectedYear, selectedMonth + 1, selectedDay);
    final currentDate = DateTime.now();
    final age = currentDate.year - selectedDate.year - 
        ((currentDate.month < selectedDate.month ||
                (currentDate.month == selectedDate.month &&
                    currentDate.day < selectedDate.day))
            ? 1
            : 0);

    if (age < 10) {
      setState(() {
        errorMessage = null;
      });
      _showSnackbar(
        context: context,
        message: "You must be at least 10 years old to continue.",
        isSuccess: false,
      );
    } else {
      setState(() {
        errorMessage = null;
      });
      _showSnackbar(
        context: context,
        message: "Age validated successfully!",
        isSuccess: true,
      );

      // Access UserDataProvider and update both age and birthdate
      var userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      userDataProvider.setAge(age); // Set the age in the provider
      userDataProvider.setBirthdate(selectedDate); // Set the birthdate in the provider
      widget.onContinue();
    }
  }

  void _showSnackbar({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    SlidingSnackbar(
      context: context,
      message: message,
      isSuccess: isSuccess,
    ).show();
  }
}