import 'package:budget_management/constant/style.dart';
import 'package:budget_management/db/daily_expense.dart';
import 'package:budget_management/domain/expense_data.dart';
import 'package:budget_management/presentation/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalanceDetailPage extends ConsumerStatefulWidget {
  const BalanceDetailPage({super.key});

  @override
  ConsumerState<BalanceDetailPage> createState() => _BalanceDetailPageState();
}

class _BalanceDetailPageState extends ConsumerState<BalanceDetailPage> {
  var config = Configuration.local([DailyExpense.schema]);

  @override
  Widget build(BuildContext context) {
    var realm = Realm(config);
    final expense = ref.watch(expenseProvider);
    var exp = realm.all<DailyExpense>();
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
              const SizedBox(
                width: 10,
              ),
              const Text(
                "Balance Detail",
                style: TextStyle(color: white),
              )
            ],
          ),
        ),
        body: SfCartesianChart(
            enableAxisAnimation: true,
            onDataLabelRender: (dataLabelArgs) => Text('$dataLabelArgs M'),
            primaryXAxis: const CategoryAxis(
              labelStyle: TextStyle(
                fontSize: 15,
              ),
              // labelRotation: 30,
              tickPosition: TickPosition.inside,
              labelPlacement: LabelPlacement.betweenTicks,
              maximumLabelWidth: 60,
              maximumLabels: 2,
              autoScrollingDelta: 15,
              majorGridLines: MajorGridLines(width: 0.5),
              majorTickLines: MajorTickLines(width: 0.5),
            ),
            primaryYAxis: const NumericAxis(
                labelFormat: '{value} Ks',
                minimum: 
                0,
                maximum: 50000,
                interval: 5000),
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
            ),
            // title: const ChartTitle(text: 'Half yearly sales analysis'),

            // Enable legend
            // legend: const Legend(isVisible: true),
            //enableAxisAnimation: false,
            // Enable tooltip
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries<ExpenseData, String>>[
              AreaSeries<ExpenseData, String>(
                  //SplineSeries
                  dataSource: [
                    for (var i in exp) ...[
                      ExpenseData(i.name, i.amount),
                    ]
                    // ExpenseData('Mon', 5000),
                    // ExpenseData('Tue', 3000),
                    // ExpenseData('Wed', 20000),
                    // ExpenseData('Thu', 8000),
                    // ExpenseData('Sat', 15000),
                    // ExpenseData('Sun', 4000),
                  ],
                  xValueMapper: (ExpenseData data, _) => data.amount,
                  yValueMapper: (ExpenseData data, _) => data.date,
                  name: 'Gold',
                  // borderColor: Colors.blue,
                  // borderGradient: const LinearGradient(colors: [MyTheme.secondaryColor, MyTheme.pinkpurple]),
                  markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 2,
                      width: 2,
                      shape: DataMarkerType.circle,
                      borderWidth: 3,
                      borderColor: Colors.blue),
                  legendIconType: LegendIconType.circle,
                  color: const Color.fromARGB(255, 231, 241, 248)),
              ColumnSeries<ExpenseData, String>(
                  dataSource: [
                    for (var i in exp) ...[
                      ExpenseData(i.name, i.amount),
                    ]
                    // ExpenseData('Mon', 5000),
                    // ExpenseData('Tue', 3000),
                    // ExpenseData('Wed', 20000),
                    // ExpenseData('Thu', 8000),
                    // ExpenseData('Sat', 15000),
                    // ExpenseData('Sun', 4000),
                  ],
                  xValueMapper: (ExpenseData data, _) => data.amount,
                  yValueMapper: (ExpenseData data, _) => data.date,
                  name: 'Expense',
                  trackPadding: 15,
                  spacing: 0.08,
                  color: const Color.fromRGBO(8, 142, 255, 1)),
              // ColumnSeries<ExpenseData, String>(
              //     dataSource: [
              //       ExpenseData('Mon', 5000),
              //       ExpenseData('Tue', 3000),
              //       ExpenseData('Wed', 20000),
              //       ExpenseData('Thu', 8000),
              //       ExpenseData('Sat', 15000),
              //       ExpenseData('Sun', 4000),
              //     ],
              //     trackPadding: 8,
              //     spacing: 0.08,
              //     xValueMapper: (ExpenseData data, _) => data.amount,
              //     yValueMapper: (ExpenseData data, _) => data.date,
              //     name: 'Gold',
              //     color: Colors.amber),
            ])

        // SfCartesianChart(
        //   primaryYAxis: NumericAxis(
        //     title: AxisTitle(text: 'Amount'),
        //     interval: 5,
        //   ),
        //   primaryXAxis: CategoryAxis(), // Initialize category axis.
        //   series: <BarSeries<ExpenseData, String>>[
        //     // Initialize line series.
        //     BarSeries<ExpenseData, String>(
        //       dataSource: [
        //         ExpenseData('Jan', "1"),
        //         ExpenseData('Feb', "6"),
        //         ExpenseData('Mar', '3'),
        //         ExpenseData('Apr', "7"),
        //         ExpenseData('May', "5"),
        //         ExpenseData('Jun', "2"),
        //         ExpenseData('July', "8"),
        //         ExpenseData('Aug', '0'),
        //         ExpenseData('Sep', "9"),
        //         ExpenseData('Oct', "5")
        //       ],
        //       yValueMapper: (ExpenseData data, _) => int.tryParse(data.amount),
        //       xValueMapper: (ExpenseData data, _) => data.date,
        //       dataLabelSettings: DataLabelSettings(isVisible: true),
        //     )
        //   ],
        // ),

        );
  }
}
