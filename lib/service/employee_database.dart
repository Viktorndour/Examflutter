/*import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:victor/Modèles/employee.dart';

class EmployeeDatabase {
  static final EmployeeDatabase _instance = EmployeeDatabase._internal();

  factory EmployeeDatabase() => _instance;

  EmployeeDatabase._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('employees.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Création de la table employees
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees (
        Future _createDB(Database db, int version) async {
          await db.execute(''
            CREATE TABLE employees (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nom TEXT NOT NULL,
              prenom TEXT NOT NULL,
              email TEXT NOT NULL,
              salaire REAL NOT NULL,
              poste TEXT NOT NULL,
              absences INTEGER NOT NULL,
              retards INTEGER NOT NULL,
              ponctuel INTEGER NOT NULL
            )
          ');
        }

      )
    ''');
  }

  // Ajouter un employé
  Future<int> insertEmployee(Employee employee) async {
    final db = await database;
    return await db.insert('employees', employee.toMap());
  }

  // Récupérer tous les employés
  Future<List<Employee>> getAllEmployees() async {
    final db = await database;
    final result = await db.query('employees');
    return result.map((json) => Employee.fromMap(json)).toList();
  }

  // Mettre à jour un employé
  Future<int> updateEmployee(Employee employee) async {
    final db = await database;
    return await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  // Supprimer un employé par id
  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
*/