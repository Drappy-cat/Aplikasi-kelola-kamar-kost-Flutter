import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/shared/models/activity_log.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/models/announcement.dart';

// Kunci untuk menyimpan data di SharedPreferences
const String _kRoomsKey = 'rooms_data';
const String _kBillsKey = 'bills_data';
const String _kComplaintsKey = 'complaints_data';
const String _kAnnouncementsKey = 'announcements_data';
const String _kRequestsKey = 'requests_data';
const String _kNotificationsKey = 'notifications_data';
const String _kActivityLogsKey = 'activity_logs_data';

class DummyService {
  final SharedPreferences _prefs;

  late List<Room> rooms;
  late List<Bill> bills;
  late List<Complaint> complaints;
  late List<Announcement> announcements;
  late List<Request> requests;
  late List<AppNotification> notifications;
  late List<ActivityLog> activityLogs;

  DummyService(this._prefs);

  Future<void> init() async {
    await _loadData();
  }

  Future<void> _loadData() async {
    rooms = _loadList(_prefs.getString(_kRoomsKey), (json) => Room.fromJson(json), _createInitialRooms);
    bills = _loadList(_prefs.getString(_kBillsKey), (json) => Bill.fromJson(json), _createInitialBills);
    complaints = _loadList(_prefs.getString(_kComplaintsKey), (json) => Complaint.fromJson(json), _createInitialComplaints);
    announcements = _loadList(_prefs.getString(_kAnnouncementsKey), (json) => Announcement.fromJson(json), _createInitialAnnouncements);
    requests = _loadList(_prefs.getString(_kRequestsKey), (json) => Request.fromJson(json), _createInitialRequests);
    notifications = _loadList(_prefs.getString(_kNotificationsKey), (json) => AppNotification.fromJson(json), _createInitialNotifications);
    activityLogs = _loadList(_prefs.getString(_kActivityLogsKey), (json) => ActivityLog.fromJson(json), _createInitialActivityLogs);

    if (_prefs.getString(_kRoomsKey) == null) {
      await _saveData();
    }
  }

  Future<void> _saveData() async {
    await _prefs.setString(_kRoomsKey, jsonEncode(rooms.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kBillsKey, jsonEncode(bills.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kComplaintsKey, jsonEncode(complaints.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kAnnouncementsKey, jsonEncode(announcements.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kRequestsKey, jsonEncode(requests.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kNotificationsKey, jsonEncode(notifications.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kActivityLogsKey, jsonEncode(activityLogs.map((e) => e.toJson()).toList()));
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

  // --- Metode Terpusat untuk Notifikasi ---
  Future<void> addNotification({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) async {
    final newNotification = AppNotification(
      title: title,
      subtitle: subtitle,
      date: DateTime.now(),
      icon: icon,
      iconColor: iconColor,
    );
    notifications.insert(0, newNotification);
    await _saveData();
  }

  Future<void> updateNotification(int index, AppNotification notification) async {
    if (index >= 0 && index < notifications.length) {
      notifications[index] = notification;
      await _saveData();
    }
  }

  // ... (metode-metode lain)

  Future<void> addActivityLog({required String userId, required String userName, required String action}) async {
    final newLog = ActivityLog(
      id: 'log-${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      userName: userName,
      action: action,
      timestamp: DateTime.now(),
    );
    activityLogs.insert(0, newLog);
    await _saveData();
  }

  List<Bill> getBillsForUser(String userId) {
    final userBills = bills.where((b) => b.userId == userId).toList();
    userBills.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return userBills;
  }

  List<Bill> getPendingConfirmationBills() => bills.where((b) => b.status == 'Menunggu Konfirmasi').toList();

  Bill? getLatestBillForUser(String userId) {
    final userBills = getBillsForUser(userId);
    return userBills.isNotEmpty ? userBills.first : null;
  }

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

  Future<void> addComplaint({ required String userId, required String roomId, required String title, required String description, required String category, List<String> imageUrls = const [], }) async {
    final newComplaint = Complaint(id: 'comp-${DateTime.now().millisecondsSinceEpoch}', userId: userId, roomId: roomId, title: title, description: description, category: category, status: 'Pending', imageUrls: imageUrls, createdAt: DateTime.now());
    complaints.insert(0, newComplaint);
    await _saveData();
  }

  Future<void> updateComplaintStatus(String complaintId, String newStatus) async {
    final index = complaints.indexWhere((c) => c.id == complaintId);
    if (index != -1) {
      complaints[index] = complaints[index].copyWith(status: newStatus);
      await _saveData();
    }
  }

  List<Complaint> getAllComplaints() => complaints;
  List<Complaint> getComplaintsForUser(String userId) => complaints.where((c) => c.userId == userId).toList();

  List<Announcement> getLatestAnnouncements() {
    announcements.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return announcements.where((a) => a.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)))).toList();
  }

  Future<void> addAnnouncement({required String title, required String content}) async {
    final newAnnouncement = Announcement(id: 'ann-${DateTime.now().millisecondsSinceEpoch}', title: title, content: content, createdAt: DateTime.now());
    announcements.insert(0, newAnnouncement);
    await _saveData();
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

  Future<void> addRoom(Room newRoom) async {
    rooms.add(newRoom);
    await _saveData();
  }
}

// Data awal untuk setiap list
List<ActivityLog> _createInitialActivityLogs() => [];
List<AppNotification> _createInitialNotifications() => [AppNotification(title: 'Selamat Datang di Ri-Kost!', subtitle: 'Jelajahi semua fitur yang tersedia untuk Anda.', date: DateTime.now().subtract(const Duration(days: 2)), icon: Icons.waving_hand, iconColor: Colors.orange)];
List<Request> _createInitialRequests() => [];
List<Bill> _createInitialBills() => [Bill(id: 'bill-001', userId: 'user1', roomId: 'A-101', period: 'Juli 2024', amount: 1150000, status: 'Belum Lunas', createdAt: DateTime(2024, 7, 1))];
List<Complaint> _createInitialComplaints() => [Complaint(id: 'comp-001', userId: 'user1', roomId: 'A-101', title: 'Keran Bocor', description: 'Keran di kamar mandi bocor terus.', category: 'Kerusakan Fasilitas', status: 'In Progress', createdAt: DateTime.now().subtract(const Duration(days: 2)), imageUrls: ['https://picsum.photos/seed/comp-001/200/300'])];
List<Announcement> _createInitialAnnouncements() => [Announcement(id: 'ann-001', title: 'Perbaikan Listrik', content: 'Akan ada pemadaman listrik sementara pada hari Sabtu, 20 Juli 2024.', createdAt: DateTime.now().subtract(const Duration(days: 1)))];
List<Room> _createInitialRooms() {
  final localImagePaths = ['assets/kamar_kost/kamar1.png', 'assets/kamar_kost/kamar2.png', 'assets/kamar_kost/kamar3.png', 'assets/kamar_kost/kamar 4.png'];
  final List<Room> initialRooms = [];

  for (int i = 1; i <= 16; i++) {
    final String roomCode = 'A-${i.toString().padLeft(2, '0')}';
    final bool isOccupied = i % 3 == 0;
    final String status = isOccupied ? 'Dihuni' : 'Kosong';
    final String? tenantName = isOccupied ? 'Tenant ${i}' : null;
    final String? rentStartDate = isOccupied ? '2024-07-01' : null;

    initialRooms.add(
      Room(
        code: roomCode,
        status: status,
        baseRent: 700000 + (i * 10000),
        wifi: 100000,
        water: 50000,
        electricity: 150000,
        acCost: i % 2 == 0 ? 200000 : 0,
        dimensions: i % 4 == 0 ? "3x4 m" : "3x3.5 m",
        imageUrls: [localImagePaths[i % localImagePaths.length]],
        tenantName: tenantName,
        tenantAddress: isOccupied ? 'Jl. Contoh No. ${i}' : null,
        tenantPhone: isOccupied ? '0812345678${i.toString().padLeft(2, '0')}' : null,
        rentStartDate: rentStartDate,
      ),
    );
  }
  return initialRooms;
}
