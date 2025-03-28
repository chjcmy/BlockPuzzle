import 'package:flutter/material.dart';

class SeasonSelector extends StatelessWidget {
  final List<String> seasons;
  final List<String> selectedSeasons;
  final Function(String) onSeasonSelected;

  const SeasonSelector({
    super.key,
    required this.seasons,
    required this.selectedSeasons,
    required this.onSeasonSelected,
  });

  String _getDisplayName(String season) {
    switch (season) {
      case 'SPRING':
        return 'Spring';
      case 'SUMMER':
        return 'Summer';
      case 'AUTUMN':
        return 'Autumn';
      case 'WINTER':
        return 'Winter';
      default:
        return season;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Season',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: seasons.map((season) {
              final isSelected = selectedSeasons.contains(season);
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.grey[800] : Colors.grey[200],
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                  ),
                  onPressed: () => onSeasonSelected(season),
                  child: Text(_getDisplayName(season)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}