part of 'index.dart';
class Owner {
  final int id;
  final String avatarUrl;
  final String url;

  Owner({
    required this.id,
    required this.avatarUrl,
    required this.url,
  });

  // Factory constructor to create an instance from a map
  factory Owner.fromMap(Map<String, dynamic> map) {
    return Owner(
      id: map['id'] as int,
      avatarUrl: map['avatar_url'] as String,
      url: map['url'] as String,
    );
  }

  // Convert an instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avatar_url': avatarUrl,
      'url': url,
    };
  }

  // Method to generate SQL CREATE TABLE statement for the Owner table
  static String createTableSQL(String tableName) {
    return '''
      CREATE TABLE IF NOT EXISTS $tableName (
        id INTEGER PRIMARY KEY,
        avatar_url TEXT NOT NULL,
        html_url TEXT NOT NULL
      );
    ''';
  }
}
