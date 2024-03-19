import 'package:budget_management/constant/style.dart';
import 'package:budget_management/domain/expense_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalanceDetailPage extends StatefulWidget {
  const BalanceDetailPage({super.key});

  @override
  State<BalanceDetailPage> createState() => _BalanceDetailPageState();
}

class _BalanceDetailPageState extends State<BalanceDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the next 6 days
    List<DateTime> next6Days =
        List.generate(6, (index) => currentDate.add(Duration(days: index + 1)));
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios)),
              SizedBox(
                width: 10,
              ),
              Text(
                "Balance Detail",
                style: TextStyle(color: white),
              )
            ],
          ),
        ),
        body: SfCartesianChart(
            primaryXAxis: CategoryAxis(), // Initialize category axis.
            series: <LineSeries<ExpenseData, String>>[
              // Initialize line series.
              LineSeries<ExpenseData, String>(
                  dataSource: [
                    ExpenseData('Jan', "1"),
                    ExpenseData('Feb', "6"),
                    ExpenseData('Mar', '3'),
                    ExpenseData('Apr', "7"),
                    ExpenseData('May', "5"),
                    ExpenseData('Jun', "2"),
                    ExpenseData('July', "8"),
                    ExpenseData('Aug', '0'),
                    ExpenseData('Sep', "9"),
                    ExpenseData('Oct', "5")
                  ],
                  xValueMapper: (ExpenseData data, _) => data.amount,
                  yValueMapper: (ExpenseData data, _) =>
                      int.tryParse(data.date))
            ]));
  }
}
