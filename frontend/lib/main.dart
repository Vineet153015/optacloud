import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/blocs/dahboard_bloc/dashboard_bloc.dart';
import 'package:frontend/firebase_options.dart';
import 'package:frontend/screens/dashboard_screen.dart';
import 'package:frontend/utils/mock_bluethooth_sdk.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(
            create: (_) => DashboardBloc(
                MockBluetoothSDK())), // Provide DashboardBloc globally
      ],
      child: MaterialApp(
        title: 'Smartwatch Companion App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const LoginScreen(),
        routes: {
          '/dashboard': (context) => const DashboardScreen(),
        },
      ),
    );
  }
}
