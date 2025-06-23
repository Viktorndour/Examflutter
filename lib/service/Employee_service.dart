import 'package:victor/modeles/employee.dart';

class EmployeeService {
  static final EmployeeService _instance = EmployeeService._internal();

  factory EmployeeService() => _instance;

  EmployeeService._internal();

  final List<Employee> _memoryList = [];

  Future<List<Employee>> getAll() async => _memoryList;

  Future<int> add(Employee employee) async {
    final id = _memoryList.length + 1;
    employee.id = id;
    _memoryList.add(employee);
    return id;
  }

  Future<void> delete(int id) async {
    _memoryList.removeWhere((e) => e.id == id);
  }

  Future<void> update(Employee employee) async {
    final index = _memoryList.indexWhere((e) => e.id == employee.id);
    if (index != -1) _memoryList[index] = employee;
  }
}
