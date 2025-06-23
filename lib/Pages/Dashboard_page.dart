import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:victor/screen/employee_list_screen.dart';
import 'package:victor/screen/feuille_suivie_page.dart';
 // 🔁 Assure-toi que ce fichier existe

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int totalEmployes = 150;
  int totalAbsences = 45;
  double salaireTotal = 50000;
  int retardsTotal = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau de bord"),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const FeuilleSuiviePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Cartes modifiables
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EditableCard(
                  title: "Total Employés",
                  value: totalEmployes.toString(),
                  color: Colors.blueAccent,
                  onValueChanged: (newValue) {
                    setState(() {
                      totalEmployes = int.tryParse(newValue) ?? totalEmployes;
                    });
                  },
                ),
                EditableCard(
                  title: "Absences",
                  value: totalAbsences.toString(),
                  color: Colors.redAccent,
                  onValueChanged: (newValue) {
                    setState(() {
                      totalAbsences = int.tryParse(newValue) ?? totalAbsences;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EditableCard(
                  title: "Salaire Total",
                  value: salaireTotal.toStringAsFixed(2),
                  color: Colors.green,
                  onValueChanged: (newValue) {
                    setState(() {
                      salaireTotal = double.tryParse(newValue) ?? salaireTotal;
                    });
                  },
                ),
                EditableCard(
                  title: "Retards",
                  value: retardsTotal.toString(),
                  color: Colors.orangeAccent,
                  onValueChanged: (newValue) {
                    setState(() {
                      retardsTotal = int.tryParse(newValue) ?? retardsTotal;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🔘 Bouton pour accéder à la gestion des employés
            ElevatedButton.icon(
              icon: const Icon(Icons.people),
              label: const Text("Gérer les employés"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EmployeeListScreen()),
                );
              },
            ),

            const SizedBox(height: 30),

            // 📊 Graphique
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(blurRadius: 5, color: Colors.grey.shade300)],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Statistiques",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          borderData: FlBorderData(show: false),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text("Employés");
                                    case 1:
                                      return const Text("Absences");
                                    case 2:
                                      return const Text("Salaires");
                                    case 3:
                                      return const Text("Retards");
                                    default:
                                      return const Text("");
                                  }
                                },
                              ),
                            ),
                          ),
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(toY: totalEmployes.toDouble(), color: Colors.blue)
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(toY: totalAbsences.toDouble(), color: Colors.red)
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(toY: salaireTotal / 1000, color: Colors.green)
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(toY: retardsTotal.toDouble(), color: Colors.orange)
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EditableCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Function(String) onValueChanged;

  const EditableCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              onSubmitted: onValueChanged,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                isDense: true,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
