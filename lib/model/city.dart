class City{
  final int id;
  final String title;
  final String value;

  City({
    required this.id,
    required this.title,
    required this.value
  });

  factory City.fromSqliteDatabase(Map<String, dynamic> map) => City(
    id: map['id'] ?? 0,
    title: map['title'] ?? '',
    value: map['value'] ?? ''
  );
}