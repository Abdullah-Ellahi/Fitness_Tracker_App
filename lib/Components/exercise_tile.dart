import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;

  ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black,
      margin: const EdgeInsets.fromLTRB(3, 5, 3, 0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white30, width: 5),
          borderRadius: BorderRadius.circular(25),
        ),
        selectedColor: Colors.white,
        title: Text(
          exerciseName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        subtitle: Row(
          children: [
            Chip(
              backgroundColor: Colors.black
              ,
              label: Text("$weight kg",
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white30, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Chip(
              backgroundColor: Colors.black
              ,
              label: Text("$reps reps",
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white30, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Chip(
              backgroundColor: Colors.black
              ,
              label: Text("$sets sets",
                style: const TextStyle(
                    color: Colors.white
                ),
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white30, width: 2),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          activeColor: Colors.white,
          checkColor: Colors.black,
          value: isCompleted,
          onChanged: (value) => onCheckBoxChanged!(value),
        ),
      ),
    );
  }
}
