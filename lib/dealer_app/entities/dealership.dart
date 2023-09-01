// Constructor for Dealership object
class Dealership {
  final int? id;
  final int cnpj;
  final String name;
  final int autonomyLevelId;
  final String password;

  Dealership({
    this.id,
    required this.cnpj,
    required this.name,
    required this.autonomyLevelId,
    required this.password,
  });

  @override
  String toString() {
    return name;
  }
}
