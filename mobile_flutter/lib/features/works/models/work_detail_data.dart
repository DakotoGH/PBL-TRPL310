import 'package:flutter/material.dart';

class WorkDetailData {
  final String title;
  final String owner;
  final int year;
  final String category;
  final List<String> tags;
  final String description;
  final IconData previewIcon;
  final String previewLabel;
  final int viewCount;
  final String roomStatus;
  final String roomDescription;

  const WorkDetailData({
    required this.title,
    required this.owner,
    this.year = 2026,
    required this.category,
    required this.tags,
    required this.description,
    required this.previewIcon,
    required this.previewLabel,
    this.viewCount = 0,
    this.roomStatus = 'Segera Hadir',
    this.roomDescription = 'Pratinjau ruang karya sedang dikembangkan.',
  });
}

class WorkDetailResult {
  final bool isSaved;
  final bool isLiked;

  const WorkDetailResult({required this.isSaved, required this.isLiked});
}
