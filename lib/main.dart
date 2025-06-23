import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'firebase_options.dart'; // Import des options Firebase générées automatiquement

import 'package:victor/screen/login_screen.dart';
import 'package:victor/Pages/dashboard_page.dart';
import 'package:victor/screen/employee_form_screen.dart';
import 'package:victor/screen/employee_list_screen.dart';
import 'package:victor/service/employee_service.dart';
import 'package:victor/Modèles/employee.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Utilisation des options générées
  );
  runApp(const JobSeriousApp());
}

class JobSeriousApp extends StatelessWidget {
  const JobSeriousApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JobSerious',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardPage(),
        '/register': (context) => EmployeeFormScreen(
          onEmployeeAdded: (Employee employee) {
            EmployeeService().add(employee);
            Navigator.pushNamed(context, '/employees');
          },
        ),
        '/employees': (context) => const EmployeeListScreen(),
      },
    );
  }
}
