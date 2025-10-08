import 'package:flutter/material.dart';

class Complaint {
  final String id;
  final String userId;
  final String roomId;
  final String title;
  final String description;
  final String category;
  final String status;
  final List<String> imageUrls;
  final DateTime createdAt;

  Complaint({
    required this.id,
    required this.userId,
    required this.roomId,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    this.imageUrls = const [],
    required this.createdAt,
  });

  // PERBAIKAN: Menambahkan metode copyWith secara manual
  Complaint copyWith({
    String? id,
    String? userId,
    String? roomId,
    String? title,
    String? description,
    String? category,
    String? status,
    List<String>? imageUrls,
    DateTime? createdAt,
  }) {
    return Complaint(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      roomId: roomId ?? this.roomId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
