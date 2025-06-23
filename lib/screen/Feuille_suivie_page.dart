import 'package:flutter/material.dart';
import 'package:victor/Pages/dashboard_page.dart';

class FeuilleSuiviePage extends StatefulWidget {
  const FeuilleSuiviePage({super.key});

  @override
  State<FeuilleSuiviePage> createState() => _FeuilleSuiviePageState();
}

class _FeuilleSuiviePageState extends State<FeuilleSuiviePage> {
  final List<TextEditingController> nomsControllers =
      List.generate(31, (_) => TextEditingController());
  final List<TextEditingController> matriculesControllers =
      List.generate(31, (_) => TextEditingController());
  final List<TextEditingController> absencesControllers =
      List.generate(31, (_) => TextEditingController(text: '0'));

  @override
  void dispose() {
    for (final controller in [
      ...nomsControllers,
      ...matriculesControllers,
      ...absencesControllers
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feuille de Suivie'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const DashboardPage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: 800,
          child: ListView.builder(
            itemCount: 31,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: TextField(
                        controller: nomsControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Nom ${index + 1}',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: absencesControllers[index],
                        decoration: const InputDecoration(
                          labelText: 'Absences',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: matriculesControllers[index],
                        decoration: const InputDecoration(
                          labelText: 'Matricule',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
