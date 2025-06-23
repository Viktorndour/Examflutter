import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  int? id; // facultatif avec Hive

  @HiveField(1)
  String nom;

  @HiveField(2)
  String prenom;

  @HiveField(3)
  String email;

  @HiveField(4)
  double salaire;

  @HiveField(5)
  int absences;

  @HiveField(6)
  int retards;

  @HiveField(7)
  bool ponctuel;

  @HiveField(8)
  String poste;

  Employee({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.salaire,
    required this.poste,
    this.absences = 0,
    this.retards = 0,
    this.ponctuel = true,
  });
}
