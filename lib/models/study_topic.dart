import 'package:flutter/material.dart';

class StudyTopic {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final List<ContentSection> sections;

  StudyTopic({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.sections,
  });
}

class ContentSection {
  final String title;
  final String content;
  final List<String> points;
  final String? note;

  ContentSection({
    required this.title,
    required this.content,
    required this.points,
    this.note,
  });
}
