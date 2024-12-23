import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/dahboard_bloc/dahboard_state.dart';
import 'package:frontend/blocs/dahboard_bloc/dashboard_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Heart Rate: ${state.heartRate} bpm",
                    style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                Text("Steps: ${state.stepCount}",
                    style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                Text(
                  "Bluetooth Status: ${state.isBluetoothConnected ? 'Connected' : 'Disconnected'}",
                  style: TextStyle(
                    fontSize: 20,
                    color:
                        state.isBluetoothConnected ? Colors.green : Colors.red,
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text("Error loading data"));
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:frontend/blocs/dahboard_bloc/dahboard_state.dart';
// import 'package:frontend/blocs/dahboard_bloc/dashboard_bloc.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings),
//             onPressed: () {
//               // Navigate to settings page
//               Navigator.pushNamed(context, '/settings');
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<DashboardBloc, DashboardState>(
//         builder: (context, state) {
//           if (state is DashboardLoading) {
//             // Show loading indicator while fetching data
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is DashboardLoaded) {
//             // Show dashboard data when loaded
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Heart Rate: ${state.heartRate} bpm",
//                   style: const TextStyle(fontSize: 24),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Steps: ${state.stepCount}",
//                   style: const TextStyle(fontSize: 24),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   "Bluetooth Status: ${state.isBluetoothConnected ? 'Connected' : 'Disconnected'}",
//                   style: TextStyle(
//                     fontSize: 20,
//                     color:
//                         state.isBluetoothConnected ? Colors.green : Colors.red,
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             // Fallback for unknown states
//             return const Center(
//               child: Text("Unexpected error occurred"),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
