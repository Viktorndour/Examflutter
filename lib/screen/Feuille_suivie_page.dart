import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:victor/Pages/dashboard_page.dart';
import 'package:victor/modeles/suiviemploye.dart';

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
  void initState() {
    super.initState();
    chargerDonneesEnregistrees(); // ✅ charge les données à l’ouverture
  }

  void chargerDonneesEnregistrees() {
    final box = Hive.box<SuiviEmploye>('feuille_suivi');

    for (int i = 0; i < box.length && i < 31; i++) {
      final suivi = box.getAt(i);
      if (suivi != null) {
        nomsControllers[i].text = suivi.nom;
        matriculesControllers[i].text = suivi.matricule;
        absencesControllers[i].text = suivi.absences.toString();
      }
    }
  }

  void saveData() async {
    final box = Hive.box<SuiviEmploye>('feuille_suivi');
    await box.clear();

    for (int i = 0; i < 31; i++) {
      final nom = nomsControllers[i].text.trim();
      final matricule = matriculesControllers[i].text.trim();
      final abs = int.tryParse(absencesControllers[i].text) ?? 0;

      if (nom.isNotEmpty || matricule.isNotEmpty || abs > 0) {
        box.add(SuiviEmploye(
          nom: nom,
          matricule: matricule,
          absences: abs,
        ));
      }
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Données enregistrées avec succès ✅'),
        backgroundColor: Colors.teal,
      ),
    );
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: saveData,
        child: const Icon(Icons.save),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
