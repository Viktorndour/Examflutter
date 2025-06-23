import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase
import 'firebase_options.dart'; // Options Firebase générées automatiquement

import 'package:hive_flutter/hive_flutter.dart'; // 🔹 Import Hive
import 'package:victor/modeles/employee.dart'; // 🔹 Modèle Hive: Employee
import 'package:victor/modeles/suiviemploye.dart'; // ✅ Modèle Hive: SuiviEmploye (ajouté)

import 'package:victor/screen/login_screen.dart';
import 'package:victor/Pages/dashboard_page.dart';
import 'package:victor/screen/employee_form_screen.dart';
import 'package:victor/screen/employee_list_screen.dart';
import 'package:victor/service/employee_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Initialisation Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 📦 Initialisation Hive
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  Hive.registerAdapter(SuiviEmployeAdapter()); // ✅ Adapter pour la feuille de suivi
  await Hive.openBox<Employee>('employees');
  await Hive.openBox<SuiviEmploye>('feuille_suivi'); // ✅ Ouverture de la boîte Hive

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
