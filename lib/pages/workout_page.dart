import 'package:fitness_tracker/Components/exercise_tile.dart';
import 'package:fitness_tracker/data/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _workout_pageState();
}

class _workout_pageState extends State<WorkoutPage> {
  onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkoffExercise(workoutName, exerciseName);
  }

  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add a new exercise"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: exerciseNameController,
              decoration: const InputDecoration(
                label: Text("Exercise Name"),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(
                label: Text("Weight (in Kg)"),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextField(
              controller: repsController,
              decoration: const InputDecoration(
                label: Text("Number of reps"),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            TextField(
              controller: setsController,
              decoration: const InputDecoration(
                label: Text("Number of sets"),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: cancel,
            child: const Text("Cancel"),
          ),
          MaterialButton(
            onPressed: save,
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  save() {
    Provider.of<WorkoutData>(context, listen: false).addExercise(
      widget.workoutName,
      exerciseNameController.text,
      weightController.text,
      repsController.text,
      setsController.text,
    );
    Navigator.pop(context);
    clear();
  }

  cancel() {
    Navigator.pop(context);
    clear();
  }

  clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.white30,
          centerTitle: true,
          title: Text(
            widget.workoutName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white30,
          foregroundColor: Colors.white,
          onPressed: createNewExercise,
          label: const Text(
            'Add Exercise',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          icon: const Icon(
            Icons.fitness_center_rounded,
            size: 30,
          ),
        ),
        body: Container(
          // color: Colors.black,
          // margin: const EdgeInsets.all(5),
          // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: ListView.builder(
              itemCount: value.numberOfExerciseInWorkout(widget.workoutName),
              itemBuilder: (context, index) => Container(
                    padding: const EdgeInsets.all(5),
                    child: ExerciseTile(
                      exerciseName: value
                          .getRelevantWorkout(widget.workoutName)
                          .exercises[index]
                          .name,
                      weight: value
                          .getRelevantWorkout(widget.workoutName)
                          .exercises[index]
                          .weight,
                      reps: value
                          .getRelevantWorkout(widget.workoutName)
                          .exercises[index]
                          .reps,
                      sets: value
                          .getRelevantWorkout(widget.workoutName)
                          .exercises[index]
                          .sets,
                      isCompleted: value
                          .getRelevantWorkout(widget.workoutName)
                          .exercises[index]
                          .isCompleted,
                      onCheckBoxChanged: (val) => onCheckBoxChanged(
                        widget.workoutName,
                        value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .name,
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
