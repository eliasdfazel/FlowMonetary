class FinancialReports {
  final int id;

  final String name;
  final int type;

  FinancialReports({
    required this.id,
    required this.name,
    required this.type,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'FinancialReports{id: $id, name: $name, age: $type}';
  }
}
