import 'package:flutter/material.dart';
import 'package:frontend/data/local/sqlite_services.dart';
import 'package:frontend/data/remote/api_services.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final SQLiteService _sqliteService = SQLiteService();
  final ApiService _apiService = ApiService();

  List<Map<String, dynamic>> _historyData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHistory();
  }

  /// Fetch history data from the local SQLite database
  Future<void> _fetchHistory() async {
    final data = await _sqliteService.getAllRecords();
    setState(() {
      _historyData = data;
      _isLoading = false;
    });
  }

  /// Fetch history data from the backend API
  Future<void> _fetchFromBackend() async {
    try {
      final remoteData = await _apiService.fetchHealthData();
      setState(() {
        _historyData = remoteData;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: _fetchFromBackend, // Fetch data from backend
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _historyData.isEmpty
              ? const Center(child: Text("No records found"))
              : ListView.builder(
                  itemCount: _historyData.length,
                  itemBuilder: (context, index) {
                    final record = _historyData[index];
                    return ListTile(
                      title: Text("Heart Rate: ${record['heartRate']} bpm"),
                      subtitle: Text("Steps: ${record['steps']}"),
                      trailing: Text(record['timestamp']),
                    );
                  },
                ),
    );
  }
}
