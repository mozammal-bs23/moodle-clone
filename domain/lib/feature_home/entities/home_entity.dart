/// Home entity representing the main data structure for home screen
/// 
/// This is a pure Dart object with no dependencies on frameworks.
/// Contains business logic properties and methods.
class HomeEntity {
  /// Unique identifier
  final String id;
  
  /// Title/header text
  final String title;
  
  /// Subtitle or description
  final String? subtitle;
  
  /// Image URL for banner or header
  final String? imageUrl;
  
  /// List of items/data to display
  final List<HomeItemEntity> items;
  
  /// Total count or statistics
  final int totalCount;
  
  /// Last updated timestamp
  final DateTime lastUpdated;
  
  /// Whether the data is cached
  final bool isCached;
  
  const HomeEntity({
    required this.id,
    required this.title,
    this.subtitle,
    this.imageUrl,
    required this.items,
    required this.totalCount,
    required this.lastUpdated,
    this.isCached = false,
  });
  
  /// Creates a copy of this entity with specified attributes replaced
  HomeEntity copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? imageUrl,
    List<HomeItemEntity>? items,
    int? totalCount,
    DateTime? lastUpdated,
    bool? isCached,
  }) {
    return HomeEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isCached: isCached ?? this.isCached,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeEntity &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.imageUrl == imageUrl &&
        listEquals(other.items, items) &&
        other.totalCount == totalCount &&
        other.lastUpdated == lastUpdated &&
        other.isCached == isCached;
  }
  
  @override
  int get hashCode => Object.hash(
    id,
    title,
    subtitle,
    imageUrl,
    items,
    totalCount,
    lastUpdated,
    isCached,
  );
  
  /// Convert entity to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'items': items.map((e) => e.toJson()).toList(),
      'totalCount': totalCount,
      'lastUpdated': lastUpdated.toIso8601String(),
      'isCached': isCached,
    };
  }
  
  /// Create entity from JSON map
  factory HomeEntity.fromJson(Map<String, dynamic> json) {
    return HomeEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      imageUrl: json['imageUrl'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => HomeItemEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      isCached: json['isCached'] as bool? ?? false,
    );
  }
  
  @override
  String toString() {
    return 'HomeEntity{id: $id, title: $title, items: ${items.length}}';
  }
}

/// Home item entity representing individual items within home data
class HomeItemEntity {
  /// Unique identifier for item
  final String id;
  
  /// Item title
  final String title;
  
  /// Item description
  final String? description;
  
  /// Thumbnail or icon URL
  final String? thumbnailUrl;
  
  /// Optional category or tag
  final String? category;
  
  /// Item rank/order
  final int rank;
  
  /// Whether item is featured
  final bool isFeatured;
  
  const HomeItemEntity({
    required this.id,
    required this.title,
    this.description,
    this.thumbnailUrl,
    this.category,
    required this.rank,
    this.isFeatured = false,
  });
  
  HomeItemEntity copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? category,
    int? rank,
    bool? isFeatured,
  }) {
    return HomeItemEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      category: category ?? this.category,
      rank: rank ?? this.rank,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeItemEntity &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.thumbnailUrl == thumbnailUrl &&
        other.category == category &&
        other.rank == rank &&
        other.isFeatured == isFeatured;
  }
  
  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    thumbnailUrl,
    category,
    rank,
    isFeatured,
  );
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'rank': rank,
      'isFeatured': isFeatured,
    };
  }
  
  factory HomeItemEntity.fromJson(Map<String, dynamic> json) {
    return HomeItemEntity(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      category: json['category'] as String?,
      rank: json['rank'] as int,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );
  }
  
  @override
  String toString() {
    return 'HomeItemEntity{id: $id, title: $title, rank: $rank}';
  }
}

/// Helper function to compare lists
bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
