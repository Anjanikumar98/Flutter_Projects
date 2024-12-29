import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  // Import fl_chart
import 'package:intl/intl.dart';  // To use DateFormat

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _selectedMetric = 'Heart Rate';
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    // Initialize any data or settings
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _selectDateRange,
                  icon: Icon(Icons.date_range),
                  label: Text('Select Date Range'),
                ),
                Text('From: ${DateFormat('yyyy-MM-dd').format(_startDate)} To: ${DateFormat('yyyy-MM-dd').format(_endDate)}'),
              ],
            ),
            SizedBox(height: 16),

            // Metric Selector
            DropdownButton<String>(
              value: _selectedMetric,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMetric = newValue!;
                });
              },
              items: <String>['Heart Rate', 'Step Count']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Chart Display (Heart Rate or Step Count)
            if (_selectedMetric == 'Heart Rate') ...[
              Text('Heart Rate Trends'),
              Container(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _generateHeartRateData(),
                        isCurved: true,
                        color: Colors.blue,
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (_selectedMetric == 'Step Count') ...[
              Text('Step Count Trends'),
              Container(
                height: 200,
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(show: true),
                    barGroups: _generateStepCountData(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Date Range Selection
  void _selectDateRange() async {
    final DateTimeRange? selectedRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
    );

    if (selectedRange != null) {
      setState(() {
        _startDate = selectedRange.start;
        _endDate = selectedRange.end;
      });
    }
  }

  // Heart Rate Data for Line Chart
  List<FlSpot> _generateHeartRateData() {
    return [
      FlSpot(0, 70),
      FlSpot(1, 72),
      FlSpot(2, 68),
      FlSpot(3, 75),
      FlSpot(4, 80),
      FlSpot(5, 78),
      FlSpot(6, 76),
    ];
  }

  // Step Count Data for Bar Chart
  List<BarChartGroupData> _generateStepCountData() {
    return [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 1200, color: Colors.green)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 1300, color: Colors.green)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 1100, color: Colors.green)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 1500, color: Colors.green)]),
      BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 1400, color: Colors.green)]),
      BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 1600, color: Colors.green)]),
      BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 1800, color: Colors.green)]),
    ];
  }
}
