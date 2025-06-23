import 'package:flutter/material.dart';
import 'package:victor/Modèles/employee.dart';
import 'package:victor/service/employee_service.dart';
import 'package:victor/screen/employee_form_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> uniqueEmployees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final employees = await EmployeeService().getAll();

    final seenEmails = <String>{};
    final filtered = employees.where((e) {
      final isNew = !seenEmails.contains(e.email.toLowerCase());
      if (isNew) seenEmails.add(e.email.toLowerCase());
      return isNew;
    }).toList();

    setState(() {
      uniqueEmployees = filtered;
    });

    print(" Employés chargés : ${uniqueEmployees.length}");
  }

  Future<void> _addEmployee(Employee employee) async {
    final alreadyExists = uniqueEmployees.any(
      (e) => e.email.toLowerCase() == employee.email.toLowerCase(),
    );

    if (alreadyExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cet employé existe déjà.")),
      );
    } else {
      await EmployeeService().add(employee);
      await _loadEmployees(); // Recharge la liste
    }
  }

  Future<void> _deleteEmployee(int id) async {
    await EmployeeService().delete(id);
    await _loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des employés"),
      ),
      body: uniqueEmployees.isEmpty
          ? const Center(child: Text("Aucun employé pour le moment"))
          : ListView.builder(
              itemCount: uniqueEmployees.length,
              itemBuilder: (context, index) {
                final e = uniqueEmployees[index];
                return ListTile(
                  title: Text('${e.nom} ${e.prenom}'),
                  subtitle:
                      Text('Email: ${e.email} | Salaire: ${e.salaire}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Confirmer la suppression"),
                          content:
                              Text("Supprimer ${e.nom} ${e.prenom} ?"),
                          actions: [
                            TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false),
                                child: const Text("Annuler")),
                            TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, true),
                                child: const Text("Supprimer")),
                          ],
                        ),
                      );

                      if (confirm == true && e.id != null) {
                        await _deleteEmployee(e.id!);
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EmployeeFormScreen(
                onEmployeeAdded: _addEmployee,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
