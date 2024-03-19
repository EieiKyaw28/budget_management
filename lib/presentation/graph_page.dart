import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: 
       Center(
        child :  PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (touchedIndex,pieTouchResponse) {
                setState(() {
          if (pieTouchResponse!.touchedSection is FlLongPressEnd ||
              pieTouchResponse!.touchedSection is FlPanEndEvent) {
            touchedIndex = (-1) as FlTouchEvent;
          } else {
           // touchedIndex = pieTouchResponse.touchedSectionIndex;
          }
        });
              },
            ),
            borderData: FlBorderData(
              show: false
            )
          )
        )
    )
    );
  }
}