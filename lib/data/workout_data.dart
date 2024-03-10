import 'package:fitness_tracker/data/hive_database.dart';
import 'package:fitness_tracker/dateTime/date_time.dart';
import 'package:fitness_tracker/models/Excercise.dart';
import 'package:flutter/cupertino.dart';

import '../models/Workout.dart';

class WorkoutData extends ChangeNotifier{
  final db = HiveDatabase();

  List<Workout> workoutList = [
    Workout(
        name: "Upper Body",
        exercises: [
      Exercise(
          name: "Bicep Curls",
          weight: "10",
          reps: "10",
          sets: "3"
      )
    ]),
    Workout(
        name: "Lower Body",
        exercises: [
      Exercise(
          name: "Squats",
          weight: "10",
          reps: "10",
          sets: "3"
      )
    ]),
  ];

  void initializeWorkoutList(){
    if(db.previousDataExists()){
      workoutList = db.readFromDatabase();
    }
    else{
      db.saveToDatabase(workoutList);
    }

    loadHeatMap();
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
      Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );

    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void checkoffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
    db.saveToDatabase(workoutList);

    loadHeatMap();
  }

  int numberOfExerciseInWorkout(String workoutName){
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  Workout getRelevantWorkout(String workoutName){
    Workout relevantWorkout =
    workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName){
    Workout relevantWorkout =
    workoutList.firstWhere((workout) => workout.name == workoutName);

    Exercise relevantExercise = relevantWorkout.exercises.firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }

  String getStartDate(){
    return db.getStartDate();
  }


  Map<DateTime, int> heatMapDataSet = {};
  void loadHeatMap(){
    DateTime startDate = createDateTimeObject(getStartDate());

    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for(int i=0 ; i<daysInBetween+1 ; i++){
      String yyyymmdd = convertDateTimeToYYYYMMDD(startDate.add(const Duration(days: 1)));

      int completionStatus = db.getCompletionStatus(yyyymmdd);

      int year = startDate.add(const Duration(days: 1)).year;

      int month = startDate.add(const Duration(days: 1)).month;

      int days = startDate.add(const Duration(days: 1)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, days): completionStatus
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
