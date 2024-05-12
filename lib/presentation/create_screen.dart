import 'dart:async';
import 'dart:developer';

import 'package:budget_management/constant/style.dart';
import 'package:budget_management/db/daily_expense.dart';
import 'package:budget_management/widget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';

final realmProvider = Provider<Realm>((ref) {
  var config = Configuration.local([DailyExpense.schema]);
  return Realm(config);
});

final expenseProvider = StreamProvider<List<DailyExpense>>((ref) {
  final realm = ref.watch(realmProvider);
  final tasks = realm.all<DailyExpense>();
  //
  

  final controller = StreamController<List<DailyExpense>>.broadcast();

  final subscription = tasks.changes.listen((changes) {
    final updatedTasks = tasks.toList();
    controller.add(updatedTasks);
  });

   ref.onDispose(() {
    controller.close();
    subscription.cancel();
  });

  // Add the initial data to the stream
  controller.add(tasks.toList());

  return controller.stream;
});

Stream<List<DailyExpense>> dataStream(DailyExpense data) async* {
  List<DailyExpense> counterList = [];

  while (true) {
    await Future.delayed(Duration(seconds: 1));
    counterList.add(data);
    yield counterList.toList();
  }
}

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  // CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  final TextEditingController expenseAmountController = TextEditingController();
  final TextEditingController expenseNameController = TextEditingController();

  late Realm realm;
  int id = 0;
  String name = "";
  //DateTime _selectedDay;

  @override
  Widget build(BuildContext context) {
    var config = Configuration.local([DailyExpense.schema]);

    var realm = Realm(config);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Your Expense",
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            // height: 300,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expense Name",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: expenseNameController,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    labelText: "Expense Name",
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(),
                    ),

                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.text,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Amount",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: expenseAmountController,
                  textAlign: TextAlign.start,
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  onChanged: (val) {},
                  decoration: InputDecoration(
                    labelText: "Amount",
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(),
                    ),

                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          name = expenseNameController.text;
                        });
                        log("Name = $name");
                        DateTime now = DateTime.now();
                        String formattedDateTime =
                            DateFormat('yyyy-MM-dd | HH:mm:ss a').format(now);

                        var item = DailyExpense(
                            ObjectId(),
                            int.tryParse(expenseAmountController.text) ?? 0,
                            name,
                            formattedDateTime);
                        realm.write(() {
                          realm.add(item);
                        });
                        dataStream(item);
                        setState(() {});
                        Navigator.pop(context);

                        // var cars = realm.all<Car>();
                        // Car myCar = cars[0];
                        // print("My car is ${myCar.make} model ${myCar.model}");

                        // cars = realm.all<Car>().query("make == 'Tesla'");
                      },
                      child: Material(
                        elevation: 2,
                        child: SizedBox(
                            height: 50,
                            width: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: b4Color,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(child: Text("Save")),
                            )),
                      ),
                    )

                    // TableCalendar(focusedDay: _focusedDay, firstDay: firstDay, lastDay: lastDay)
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
