import 'package:flutter/material.dart';

class YearSelector extends StatelessWidget {
  final List<int> years;
  final int selectedYear;
  final Function(int) onYearSelected;

  const YearSelector({
    super.key,
    required this.years,
    required this.selectedYear,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select year',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                years.map((year) {
                  final isSelected = year == selectedYear;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isSelected ? Colors.grey[800] : Colors.grey[200],
                        foregroundColor:
                            isSelected ? Colors.white : Colors.black,
                      ),
                      onPressed: () => onYearSelected(year),
                      child: Text('$year'),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}
