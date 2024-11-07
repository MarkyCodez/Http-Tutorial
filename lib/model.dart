class DataModel {
  final int id;
  final String name;
  final String comments;
  final bool deleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int creator;

  DataModel({
    required this.id,
    required this.name,
    required this.comments,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.creator,
  });

  // api se aya hua data(map ki form me) ko class(model) me convert kr raha hai.
  factory DataModel.fromJson(Map<String, dynamic> map) {
    return DataModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      comments: map['comments'] ?? '',
      deleted: map['deleted'] ?? false,
      createdAt: map['createdAt'] ?? DateTime.now(),
      updatedAt: map['updatedAt'] ?? DateTime.now(),
      creator: map['creator'] ?? 0,
    );
  }

  // class(model) ko map me covert krega api ko bhejne keliye.

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'comments': comments,
      'deleted': deleted,
      // 'created_at': createdAt.toIso8601String(),
      // 'updated_at': updatedAt.toIso8601String(),
      'creator': creator,
    };
  }
}
