import 'package:fitness_tracker/data/workout_data.dart';
import 'package:fitness_tracker/pages/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Components/heat_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  final newWorkoutController = TextEditingController();

  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white,
        title: const Text(
            "Create new workout",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
        ),
        content: TextField(
          decoration: const InputDecoration(
            label: Text("Workout Name"),
            labelStyle: TextStyle(color: Colors.grey),
          ),
          controller: newWorkoutController,
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

  goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutPage(
            workoutName: workoutName,
          ),
        ));
  }

  save() {
    String newWorkoutName = newWorkoutController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
    clear();
  }

  cancel() {
    Navigator.pop(context);
    clear();
  }

  clear() {
    newWorkoutController.clear();
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
          title: const Text(
              "Fitness Tracker",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white30,
          foregroundColor: Colors.white,
          onPressed: createNewWorkout,
          label: const Text(
            'Add Workout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          icon: const Icon(Icons.fitness_center_rounded,size: 30,),
        ),
        body: ListView(children: [
          MyHeatMap(
              datasets: value.heatMapDataSet,
              startDateYYYYMMDD: value.getStartDate()),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.all(3),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white30, width: 5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      selectedColor: Colors.white,
                      title: Text(
                        value.getWorkoutList()[index].name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: IconButton(
                        padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                        splashColor: Colors.white,
                        splashRadius: 100,
                        color: Colors.white,
                        style: const ButtonStyle(),
                        icon: const Icon(
                            size: 30,
                            Icons.arrow_forward_ios_rounded),
                            onPressed: () =>
                            goToWorkoutPage(value.getWorkoutList()[index].name),
                      ),
                    ),
                  )),
        ]),
      ),
    );
  }
}
