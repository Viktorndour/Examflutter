import 'package:flutter/material.dart';
import 'package:victor/modeles/employee.dart';
import 'package:victor/service/employee_service.dart';
import 'package:victor/screen/employee_list_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController salaireController = TextEditingController();

  String poste = 'Agent'; // Valeur par défaut
  final List<String> postes = ['Agent', 'Comptable', 'Secrétaire', 'Manager'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un compte")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) => value!.isEmpty ? 'Entrez un nom' : null,
              ),
              TextFormField(
                controller: prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) => value!.isEmpty ? 'Entrez un prénom' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Entrez un email' : null,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) =>
                    value!.length < 6 ? 'Minimum 6 caractères' : null,
              ),
              DropdownButtonFormField<String>(
                value: poste,
                items: postes
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    poste = value!;
                  });
                },
                decoration: const InputDecoration(labelText: 'Poste'),
              ),
              TextFormField(
                controller: salaireController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Salaire de base'),
                validator: (value) => value!.isEmpty ? 'Entrez un salaire' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final employeeService = EmployeeService();

                    // Création sans id, SQLite le génèrera
                    final newEmployee = Employee(
                      id: null,
                      nom: nomController.text,
                      prenom: prenomController.text,
                      email: emailController.text,
                      poste: poste,
                      salaire: double.tryParse(salaireController.text) ?? 0.0,
                      absences: 0,
                      retards: 0,
                      ponctuel: true,
                    );

                    await employeeService.add(newEmployee);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Compte créé avec succès")),
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EmployeeListScreen(),
                      ),
                    );
                  }
                },
                child: const Text("Créer le compte"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
