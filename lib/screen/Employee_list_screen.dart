import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:victor/modeles/employee.dart';
import 'package:victor/screen/employee_form_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Box<Employee> employeeBox;

  @override
  void initState() {
    super.initState();
    employeeBox = Hive.box<Employee>('employees');
  }

  Future<void> _deleteEmployee(int index) async {
    await employeeBox.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste des employés"),
      ),
      body: ValueListenableBuilder(
        valueListenable: employeeBox.listenable(),
        builder: (context, Box<Employee> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("Aucun employé pour le moment"));
          }

          // Pour éviter doublons par email (optionnel)
          final uniqueEmployees = <String, Employee>{};
          for (var e in box.values) {
            uniqueEmployees[e.email.toLowerCase()] = e;
          }
          final employees = uniqueEmployees.values.toList();

          return ListView.builder(
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final e = employees[index];
              final realIndex = box.values.toList().indexOf(e);
              return ListTile(
                title: Text('${e.nom} ${e.prenom}'),
                subtitle: Text('Email: ${e.email} | Salaire: ${e.salaire}'),
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

                    if (confirm == true) {
                      await _deleteEmployee(realIndex);
                    }
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EmployeeFormScreen(
                onEmployeeAdded: (_) {},
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
