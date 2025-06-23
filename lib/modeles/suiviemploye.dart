import 'package:hive/hive.dart';

part 'suiviemploye.g.dart';

@HiveType(typeId: 2)
class SuiviEmploye {
  @HiveField(0)
  String nom;

  @HiveField(1)
  String matricule;

  @HiveField(2)
  int absences;

  SuiviEmploye({
    required this.nom,
    required this.matricule,
    required this.absences,
  });
}
