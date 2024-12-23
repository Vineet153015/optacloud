import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/utils/mock_bluethooth_sdk.dart';
import 'package:frontend/data/local/sqlite_services.dart';
import 'package:frontend/data/remote/api_services.dart';
import 'package:frontend/blocs/dahboard_bloc/dahboard_event.dart';
import 'package:frontend/blocs/dahboard_bloc/dahboard_state.dart';
import 'dart:async';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final MockBluetoothSDK _bluetoothSDK;
  final SQLiteService _sqliteService = SQLiteService();
  final ApiService _apiService = ApiService();
  StreamSubscription<int>? _heartRateSubscription;
  StreamSubscription<int>? _stepCountSubscription;

  DashboardBloc(this._bluetoothSDK) : super(DashboardLoading()) {
    on<LoadDashboardEvent>((event, emit) async {
      emit(DashboardLoading());

      // Subscribe to heart rate stream
      _heartRateSubscription =
          _bluetoothSDK.getHeartRateStream().listen((heartRate) {
        add(UpdateHeartRateEvent(heartRate));
      });

      // Subscribe to step count stream
      _stepCountSubscription =
          _bluetoothSDK.getStepCountStream().listen((stepCount) {
        add(UpdateStepCountEvent(stepCount));
      });
    });

    on<UpdateHeartRateEvent>((event, emit) {
      if (state is DashboardLoaded) {
        final currentState = state as DashboardLoaded;
        emit(currentState.copyWith(heartRate: event.heartRate));

        // Save heart rate to the local database
        _saveToLocalDatabase(event.heartRate, currentState.stepCount);
      }
    });

    on<UpdateStepCountEvent>((event, emit) {
      if (state is DashboardLoaded) {
        final currentState = state as DashboardLoaded;
        emit(currentState.copyWith(stepCount: event.stepCount));

        // Save steps to the local database
        _saveToLocalDatabase(currentState.heartRate, event.stepCount);
      }
    });
  }

  /// Syncs local data with the backend
  void _syncDataWithBackend() async {
    try {
      final localRecords = await _sqliteService.getAllRecords();
      await _apiService.syncHealthData(localRecords);
      print("Data synced successfully with backend");
    } catch (e) {
      print("Failed to sync data: $e");
    }
  }

  /// Saves heart rate and steps to the local database
  void _saveToLocalDatabase(int heartRate, int steps) async {
    final timestamp = DateTime.now().toIso8601String();
    await _sqliteService.insertRecord(heartRate, steps, timestamp);
    _syncDataWithBackend(); // Sync with backend after saving
  }

  @override
  Future<void> close() {
    _heartRateSubscription?.cancel();
    _stepCountSubscription?.cancel();
    return super.close();
  }
}
