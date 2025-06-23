import 'package:flutter/material.dart';
import 'package:victor/Modèles/employee.dart';
import 'package:victor/service/employee_service.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Function(Employee) onEmployeeAdded;

  const EmployeeFormScreen({super.key, required this.onEmployeeAdded});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String nom, prenom, email, poste;
  late double salaire;

  @override
  void initState() {
    super.initState();
    nom = '';
    prenom = '';
    email = '';
    poste = 'Agent';
    salaire = 0.0;
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newEmployee = Employee(
        nom: nom,
        prenom: prenom,
        email: email,
        poste: poste,
        salaire: salaire,
        absences: 0,
        retards: 0,
        ponctuel: true,
      );

      // Ajout dans la base SQLite via le service
      //await EmployeeService().add(newEmployee);

      // Puis notifier la page précédente (ex: EmployeeListScreen)
      widget.onEmployeeAdded(newEmployee);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un employé')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom'),
                onSaved: (val) => nom = val!,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Prénom'),
                onSaved: (val) => prenom = val!,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Champ requis' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (val) => email = val!,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Champ requis';
                  final emailRegex =
                      RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,4}$');
                  if (!emailRegex.hasMatch(val)) return 'Email invalide';
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: poste,
                items: ['Agent', 'Manager', 'Comptable', 'Secrétaire']
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (value) => setState(() => poste = value!),
                decoration: const InputDecoration(labelText: 'Poste'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Salaire'),
                onSaved: (val) => salaire = double.tryParse(val!) ?? 0.0,
                validator: (val) =>
                    val == null || val.isEmpty ? 'Champ requis' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                child: const Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
