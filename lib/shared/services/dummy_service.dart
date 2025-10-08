import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/models/announcement.dart';

// Kunci untuk menyimpan data di SharedPreferences
const String _kRoomsKey = 'rooms_data';
const String _kBillsKey = 'bills_data';
const String _kRequestsKey = 'requests_data';
const String _kNotificationsKey = 'notifications_data';

class DummyService {
  final SharedPreferences _prefs;

  late List<Room> rooms;
  late List<Bill> bills;
  late List<Request> requests;
  late List<AppNotification> notifications;
  late List<Complaint> complaints;
  late List<Announcement> announcements;

  DummyService(this._prefs);

  Future<void> init() async {
    await _loadData();
  }

  Future<void> _loadData() async {
    rooms = _loadList(_prefs.getString(_kRoomsKey), (json) => Room.fromJson(json), _createInitialRooms);
    bills = _loadList(_prefs.getString(_kBillsKey), (json) => Bill.fromJson(json), _createInitialBills);
    requests = _loadList(_prefs.getString(_kRequestsKey), (json) => Request.fromJson(json), _createInitialRequests);
    notifications = _loadList(_prefs.getString(_kNotificationsKey), (json) => AppNotification.fromJson(json), _createInitialNotifications);

    complaints = _createInitialComplaints();
    announcements = _createInitialAnnouncements();

    if (_prefs.getString(_kRoomsKey) == null) {
      await _saveData();
    }
  }

  Future<void> _saveData() async {
    await _prefs.setString(_kRoomsKey, jsonEncode(rooms.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kBillsKey, jsonEncode(bills.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kRequestsKey, jsonEncode(requests.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kNotificationsKey, jsonEncode(notifications.map((e) => e.toJson()).toList()));
  }

  List<T> _loadList<T>(String? jsonString, T Function(Map<String, dynamic>) fromJson, List<T> Function() defaultCreator) {
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        return defaultCreator();
      }
    } else {
      return defaultCreator();
    }
  }

  List<Bill> getBillsForUser(String userId) => bills.where((b) => b.userId == userId).toList();
  List<Bill> getPendingConfirmationBills() => bills.where((b) => b.status == 'Menunggu Konfirmasi').toList();

  Future<void> confirmCashPayment(String billId) async {
    final index = bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      bills[index] = bills[index].copyWith(status: 'Menunggu Konfirmasi', paymentMethod: 'Tunai', paymentProofUrl: null);
      await _saveData();
    }
  }

  Future<void> submitPaymentProof(String billId, String proofUrl) async {
    final index = bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      bills[index] = bills[index].copyWith(status: 'Menunggu Konfirmasi', paymentMethod: 'Transfer', paymentProofUrl: proofUrl);
      await _saveData();
    }
  }

  Future<void> approveBill(String billId) async {
    final index = bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      bills[index] = bills[index].copyWith(status: 'Lunas');
      await _saveData();
    }
  }

  Future<void> rejectBill(String billId) async {
    final index = bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      bills[index] = bills[index].copyWith(status: 'Belum Lunas', paymentMethod: null, paymentProofUrl: null);
      await _saveData();
    }
  }

  void addComplaint({ required String userId, required String roomId, required String title, required String description, required String category, List<String> imageUrls = const [], }) {
    final newComplaint = Complaint(id: 'comp-${DateTime.now().millisecondsSinceEpoch}', userId: userId, roomId: roomId, title: title, description: description, category: category, status: 'Pending', imageUrls: imageUrls, createdAt: DateTime.now());
    complaints.insert(0, newComplaint);
  }

  void updateComplaintStatus(String complaintId, String newStatus) {
    final index = complaints.indexWhere((c) => c.id == complaintId);
    if (index != -1) {
      final oldComplaint = complaints[index];
      complaints[index] = Complaint(id: oldComplaint.id, userId: oldComplaint.userId, roomId: oldComplaint.roomId, title: oldComplaint.title, description: oldComplaint.description, category: oldComplaint.category, status: newStatus, imageUrls: oldComplaint.imageUrls, createdAt: oldComplaint.createdAt);
    }
  }

  List<Complaint> getAllComplaints() => complaints;

  List<Announcement> getLatestAnnouncements() {
    announcements.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return announcements.where((a) => a.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)))).toList();
  }

  void addAnnouncement({required String title, required String content}) {
    final newAnnouncement = Announcement(id: 'ann-${DateTime.now().millisecondsSinceEpoch}', title: title, content: content, createdAt: DateTime.now());
    announcements.insert(0, newAnnouncement);
  }

  Room? findRoom(String code) {
    try {
      return rooms.firstWhere((r) => r.code == code);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateRoom(Room updatedRoom) async {
    final index = rooms.indexWhere((room) => room.code == updatedRoom.code);
    if (index != -1) {
      rooms[index] = updatedRoom;
      await _saveData();
    }
  }
}

List<AppNotification> _createInitialNotifications() => [AppNotification(title: 'Selamat Datang di Ri-Kost!', subtitle: 'Jelajahi semua fitur yang tersedia untuk Anda.', date: DateTime.now().subtract(const Duration(days: 2)), icon: Icons.waving_hand, iconColor: Colors.orange)];
List<Request> _createInitialRequests() => [];
List<Bill> _createInitialBills() => [
  Bill(id: 'bill-001', userId: 'user1', roomId: 'A-101', period: 'Juli 2024', amount: 1150000, status: 'Belum Lunas', createdAt: DateTime(2024, 7, 1)),
  Bill(id: 'bill-002', userId: 'user1', roomId: 'A-101', period: 'Juni 2024', amount: 1150000, status: 'Lunas', paymentMethod: 'Transfer', createdAt: DateTime(2024, 6, 1)),
  Bill(id: 'bill-003', userId: 'user2', roomId: 'A-103', period: 'Juli 2024', amount: 1200000, status: 'Menunggu Konfirmasi', paymentProofUrl: 'https://picsum.photos/seed/bill-003/400/600', paymentMethod: 'Transfer', createdAt: DateTime(2024, 7, 2)),
  Bill(id: 'bill-004', userId: 'user2', roomId: 'A-103', period: 'Juni 2024', amount: 1200000, status: 'Lunas', paymentMethod: 'Tunai', createdAt: DateTime(2024, 6, 2)),
  Bill(id: 'bill-005', userId: 'user3', roomId: 'B-201', period: 'Juli 2024', amount: 950000, status: 'Lunas', paymentMethod: 'Tunai', createdAt: DateTime(2024, 7, 3)),
  Bill(id: 'bill-006', userId: 'user4', roomId: 'B-202', period: 'Juli 2024', amount: 950000, status: 'Belum Lunas', createdAt: DateTime(2024, 7, 4)),
];
List<Complaint> _createInitialComplaints() => [Complaint(id: 'comp-001', userId: 'user1', roomId: 'A-101', title: 'Keran Bocor', description: 'Keran di kamar mandi bocor terus.', category: 'Kerusakan Fasilitas', status: 'In Progress', createdAt: DateTime.now().subtract(const Duration(days: 2)), imageUrls: ['https://picsum.photos/seed/comp-001/200/300'])];
List<Announcement> _createInitialAnnouncements() => [Announcement(id: 'ann-001', title: 'Perbaikan Listrik', content: 'Akan ada pemadaman listrik sementara pada hari Sabtu, 20 Juli 2024.', createdAt: DateTime.now().subtract(const Duration(days: 1)))];

// --- PERBAIKAN: MENGEMBALIKAN DATA 16 KAMAR ---
List<Room> _createInitialRooms() {
  final localImagePaths = [
    'assets/kamar_kost/kamar1.png',
    'assets/kamar_kost/kamar2.png',
    'assets/kamar_kost/kamar3.png',
    'assets/kamar_kost/kamar 4.png',
  ];

  return [
    // Lantai 1
    Room(code: "A-101", status: "Dihuni", baseRent: 750000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000, dimensions: "3x4 m", imageUrls: [localImagePaths[0]], tenantName: "Budi Santoso", rentStartDate: "2024-07-01"),
    Room(code: "A-102", status: "Kosong", baseRent: 700000, wifi: 100000, water: 50000, electricity: 150000, acCost: 0, dimensions: "3x3.5 m", imageUrls: [localImagePaths[1]]),
    Room(code: "A-103", status: "Dihuni", baseRent: 800000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000, dimensions: "4x4 m", imageUrls: [localImagePaths[2]], tenantName: "Siti Aminah", rentStartDate: "2024-06-15"),
    Room(code: "A-104", status: "Kosong", baseRent: 725000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000, dimensions: "3.5x4 m", imageUrls: [localImagePaths[3]]),
    Room(code: "A-105", status: "Booked", baseRent: 700000, wifi: 100000, water: 50000, electricity: 150000, acCost: 0, dimensions: "3x3.5 m", imageUrls: [localImagePaths[0]]),
    Room(code: "A-106", status: "Kosong", baseRent: 850000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000, dimensions: "4x4.5 m", imageUrls: [localImagePaths[1]]),
    Room(code: "A-107", status: "Kosong", baseRent: 750000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000, dimensions: "3x4 m", imageUrls: [localImagePaths[2]]),
    Room(code: "A-108", status: "Booked", baseRent: 700000, wifi: 100000, water: 50000, electricity: 150000, acCost: 0, dimensions: "3x3.5 m", imageUrls: [localImagePaths[3]]),
    // Lantai 2
    Room(code: "B-201", status: "Dihuni", baseRent: 950000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000, dimensions: "4x5 m", imageUrls: [localImagePaths[0]], tenantName: "Charlie", rentStartDate: "2024-05-20"),
    Room(code: "B-202", status: "Dihuni", baseRent: 950000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000, dimensions: "4x5 m", imageUrls: [localImagePaths[1]], tenantName: "Diana", rentStartDate: "2024-06-10"),
    Room(code: "B-203", status: "Kosong", baseRent: 900000, wifi: 100000, water: 50000, electricity: 150000, acCost: 0, dimensions: "4x4.5 m", imageUrls: [localImagePaths[2]]),
    Room(code: "B-204", status: "Kosong", baseRent: 900000, wifi: 100000, water: 50000, electricity: 150000, acCost: 0, dimensions: "4x4.5 m", imageUrls: [localImagePaths[3]]),
    Room(code: "B-205", status: "Booked", baseRent: 1000000, wifi: 100000, water: 50000, electricity: 150000, acCost: 300000, dimensions: "5x5 m", imageUrls: [localImagePaths[0]]),
    Room(code: "B-206", status: "Kosong", baseRent: 925000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000, dimensions: "4.5x4.5 m", imageUrls: [localImagePaths[1]]),
    Room(code: "B-207", status: "Kosong", baseRent: 925000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000, dimensions: "4.5x4.5 m", imageUrls: [localImagePaths[2]]),
    Room(code: "B-208", status: "Kosong", baseRent: 880000, wifi: 100000, water: 50000, electricity: 150000, acCost: 0, dimensions: "4x4 m", imageUrls: [localImagePaths[3]]),
  ];
}
