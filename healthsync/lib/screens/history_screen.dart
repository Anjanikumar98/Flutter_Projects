// lib/screens/history_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'health_service.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _startDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _endDate = DateTime.now();
  String _selectedMetric = 'Heart Rate';
  String _selectedPeriod = 'Daily';
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();
    // Load data when the screen is initialized
    _loadHistoryData();
  }

  void _loadHistoryData() {
    // Placeholder for loading history data based on selected date range and metric
    // Implement the logic to fetch and display historical data
  }

  @override
  Widget build(BuildContext context) {
    final healthService = Provider.of<HealthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date range selector
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

            // Metric and time period selectors
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedMetric,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMetric = newValue!;
                    });
                    _loadHistoryData();
                  },
                  items: <String>['Heart Rate', 'Step Count']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: _selectedPeriod,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedPeriod = newValue!;
                    });
                    _loadHistoryData();
                  },
                  items: <String>['Daily', 'Weekly', 'Monthly']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Data visualization section (graphs, progress, etc.)
            if (_selectedMetric == 'Heart Rate') ...[
              Text('Heart Rate Trends'),
              Container(
                height: 200,
                child: charts.TimeSeriesChart(
                  _generateHeartRateData(),
                  animate: true,
                ),
              ),
            ] else if (_selectedMetric == 'Step Count') ...[
              Text('Step Count Trends'),
              Container(
                height: 200,
                child: charts.BarChart(
                  _generateStepCountData(),
                  animate: true,
                ),
              ),
            ],
            SizedBox(height: 16),

            // Progress circles for goal completion
            _buildProgressCircle('Goal Completion', 0.75),
            SizedBox(height: 16),

            // Export data button
            ElevatedButton.icon(
              onPressed: _exportData,
              icon: Icon(Icons.file_download),
              label: Text('Export Data'),
            ),
            SizedBox(height: 16),

            // Detailed list view of records
            Expanded(
              child: _buildRecordsListView(),
            ),
            if (_isOffline) ...[
              // Sync status indicator (Offline mode)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.cloud_off, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Offline. Data not synced.', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  // Date range selection dialog
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
      _loadHistoryData();
    }
  }

  // Generate heart rate data for visualization (sample data)
  List<charts.Series<HeartRateData, DateTime>> _generateHeartRateData() {
    final data = [
      HeartRateData(DateTime.now().subtract(Duration(days: 6)), 70),
      HeartRateData(DateTime.now().subtract(Duration(days: 5)), 72),
      HeartRateData(DateTime.now().subtract(Duration(days: 4)), 68),
      HeartRateData(DateTime.now().subtract(Duration(days: 3)), 75),
      HeartRateData(DateTime.now().subtract(Duration(days: 2)), 80),
      HeartRateData(DateTime.now().subtract(Duration(days: 1)), 78),
      HeartRateData(DateTime.now(), 76),
    ];

    return [
      charts.Series<HeartRateData, DateTime>(
        id: 'Heart Rate',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (HeartRateData heartRate, _) => heartRate.time,
        measureFn: (HeartRateData heartRate, _) => heartRate.bpm,
        data: data,
      )
    ];
  }

  // Generate step count data for visualization (sample data)
  List<charts.Series<StepCountData, String>> _generateStepCountData() {
    final data = [
      StepCountData('Mon', 1200),
      StepCountData('Tue', 1300),
      StepCountData('Wed', 1100),
      StepCountData('Thu', 1500),
      StepCountData('Fri', 1400),
      StepCountData('Sat', 1600),
      StepCountData('Sun', 1800),
    ];

    return [
      charts.Series<StepCountData, String>(
        id: 'Step Count',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (StepCountData stepCount, _) => stepCount.day,
        measureFn: (StepCountData stepCount, _) => stepCount.steps,
        data: data,
      )
    ];
  }

  // Build a progress circle widget for goal completion
  Widget _buildProgressCircle(String label, double progress) {
    return Column(
      children: [
        Text(label),
        SizedBox(height: 8),
        CircularProgressIndicator(
          value: progress,
          strokeWidth: 6,
        ),
      ],
    );
  }

  // Build the records list view
  Widget _buildRecordsListView() {
    // Placeholder for records data
    final records = [
      {'date': '2024-12-20', 'heartRate': 72, 'stepCount': 10000},
      {'date': '2024-12-19', 'heartRate': 75, 'stepCount': 9500},
      {'date': '2024-12-18', 'heartRate': 78, 'stepCount': 8000},
      // Add more data
    ];

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        final record = records[index];
        return Card(
          child: ListTile(
            title: Text(record['date']!),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Heart Rate: ${record['heartRate']} BPM'),
                Text('Step Count: ${record['stepCount']} steps'),
              ],
            ),
          ),
        );
      },
    );
  }

  // Export data (to CSV/PDF - Placeholder for functionality)
  void _exportData() {
    // Implement data export functionality here
  }
}

class HeartRateData {
  final DateTime time;
  final int bpm;

  HeartRateData(this.time, this.bpm);
}

class StepCountData {
  final String day;
  final int steps;

  StepCountData(this.day, this.steps);
}
