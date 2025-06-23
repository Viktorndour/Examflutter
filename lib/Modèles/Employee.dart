class Employee {
  int? id;               // nullable int pour SQLite
  String nom;
  String prenom;
  String email;
  double salaire;
  int absences;
  int retards;
  bool ponctuel;
  String poste;

  Employee({
    this.id,             // id optionnel (auto-généré par SQLite)
    required this.nom,
    required this.prenom,
    required this.email,
    required this.salaire,
    required this.poste,
    this.absences = 0,
    this.retards = 0,
    this.ponctuel = true,
  });

  // Convertir un objet Employee en Map pour SQLite
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'salaire': salaire,
      'absences': absences,
      'retards': retards,
      'ponctuel': ponctuel ? 1 : 0, // bool en int (SQLite)
      'poste': poste,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Créer un Employee depuis un Map (lecture SQLite)
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'] as int?,
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      email: map['email'] ?? '',
      salaire: (map['salaire'] is int)
          ? (map['salaire'] as int).toDouble()
          : (map['salaire'] as double? ?? 0.0),
      absences: map['absences'] ?? 0,
      retards: map['retards'] ?? 0,
      ponctuel: (map['ponctuel'] == 1),
      poste: map['poste'] ?? '',
    );
  }
}
