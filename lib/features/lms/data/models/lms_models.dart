class LmsItem {
  final String id;
  final String sectionId;
  final int orderNum;
  final String itemType; // 'material' | 'video' | 'quiz'
  final String title;
  final String? duration;
  final String? pdfUrl;
  final String? videoUrl;

  // diisi dari user_item_progress
  bool isCompleted;

  LmsItem({
    required this.id,
    required this.sectionId,
    required this.orderNum,
    required this.itemType,
    required this.title,
    this.duration,
    this.pdfUrl,
    this.videoUrl,
    this.isCompleted = false,
  });

  factory LmsItem.fromMap(Map<String, dynamic> map) {
    return LmsItem(
      id: map['id'] as String,
      sectionId: map['section_id'] as String,
      orderNum: map['order_num'] as int,
      itemType: map['item_type'] as String,
      title: map['title'] as String,
      duration: map['duration'] as String?,
      pdfUrl: map['pdf_url'] as String?,
      videoUrl: map['video_url'] as String?,
    );
  }
}

class LmsSection {
  final String id;
  final String stageId;
  final int orderNum;
  final String title;
  final List<LmsItem> items;

  LmsSection({
    required this.id,
    required this.stageId,
    required this.orderNum,
    required this.title,
    this.items = const [],
  });

  factory LmsSection.fromMap(Map<String, dynamic> map, List<LmsItem> items) {
    return LmsSection(
      id: map['id'] as String,
      stageId: map['stage_id'] as String,
      orderNum: map['order_num'] as int,
      title: map['title'] as String,
      items: items,
    );
  }

  /// Total items selesai di section ini
  int get completedCount => items.where((i) => i.isCompleted).length;

  /// Section dianggap selesai kalau semua item-nya selesai
  bool get isCompleted => items.isNotEmpty && completedCount == items.length;
}

class LmsStage {
  final String id;
  final int orderNum;
  final String title;
  final String? subtitle;
  final bool requiresPremium;
  final List<LmsSection> sections;

  LmsStage({
    required this.id,
    required this.orderNum,
    required this.title,
    this.subtitle,
    this.requiresPremium = false,
    this.sections = const [],
  });

  factory LmsStage.fromMap(
    Map<String, dynamic> map,
    List<LmsSection> sections,
  ) {
    return LmsStage(
      id: map['id'] as String,
      orderNum: map['order_num'] as int,
      title: map['title'] as String,
      subtitle: map['subtitle'] as String?,
      requiresPremium: map['requires_premium'] as bool? ?? false,
      sections: sections,
    );
  }

  /// Total item di seluruh stage
  int get totalItems => sections.fold(0, (sum, sec) => sum + sec.items.length);

  /// Total item yang sudah selesai
  int get completedItems =>
      sections.fold(0, (sum, sec) => sum + sec.completedCount);

  /// Progress 0.0 – 1.0
  double get progress => totalItems > 0 ? completedItems / totalItems : 0.0;
}
