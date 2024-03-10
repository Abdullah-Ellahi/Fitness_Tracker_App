import 'package:fitness_tracker/dateTime/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDateYYYYMMDD;

  const MyHeatMap({
    super.key,
    required this.datasets,
    required this.startDateYYYYMMDD,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: HeatMap(
        startDate: createDateTimeObject("20240101"),
        endDate: DateTime.now().add(const Duration(days: 0)),
        // datasets: datasets,
        datasets: {
          DateTime(2024, 2, 18): 3,
          DateTime(2024, 2, 19): 4,
          DateTime(2024, 2, 20): 5,
          DateTime(2024, 2, 21): 6,
          DateTime(2024, 2, 22): 6,
          DateTime(2024, 2, 25): 6,
          DateTime(2024, 2, 28): 8,
          DateTime(2024, 3, 1): 10,
          DateTime(2024, 3, 3): 7,
          DateTime(2024, 3, 4): 10,
          DateTime(2024, 3, 5): 6,
          DateTime(2024, 3, 6): 8,
          DateTime(2024, 3, 8): 5,
          DateTime(2024, 3, 9): 9,
          DateTime(2024, 3, 10): 10,
        },
        colorMode: ColorMode.color,
        defaultColor: Colors.white30,
        textColor: Colors.white,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        colorsets: const {
          1: Color.fromARGB(20, 2, 179, 8),
          2: Color.fromARGB(40, 2, 179, 8),
          3: Color.fromARGB(60, 2, 179, 8),
          4: Color.fromARGB(80, 2, 179, 8),
          5: Color.fromARGB(100, 2, 179, 8),
          6: Color.fromARGB(120, 2, 179, 8),
          7: Color.fromARGB(140, 2, 179, 8),
          8: Color.fromARGB(160, 2, 179, 8),
          9: Color.fromARGB(180, 2, 179, 8),
          10: Color.fromARGB(200, 2, 179, 8),
        },
      ),
    );
  }
}
