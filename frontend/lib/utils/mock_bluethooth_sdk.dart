import 'dart:async';
import 'dart:math';

class MockBluetoothSDK {
  // Simulate heart rate updates
  Stream<int> getHeartRateStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      yield 60 + Random().nextInt(20); // Random heart rate between 60-80
    }
  }

  // Simulate step count updates
  Stream<int> getStepCountStream() async* {
    int steps = 0;
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      steps += Random().nextInt(10); // Increment steps by a random value
      yield steps;
    }
  }
}
