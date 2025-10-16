import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/shared/models/activity_log.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/models/chat_conversation.dart';
import 'package:tes/shared/models/chat_message.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/models/announcement.dart';
import 'package:tes/shared/services/auth_service.dart';
import 'package:tes/shared/services/locator.dart';

// Kunci privat yang digunakan untuk menyimpan dan mengambil data dari SharedPreferences.
const String _kRoomsKey = 'rooms_data';
const String _kBillsKey = 'bills_data';
const String _kComplaintsKey = 'complaints_data';
const String _kAnnouncementsKey = 'announcements_data';
const String _kRequestsKey = 'requests_data';
const String _kNotificationsKey = 'notifications_data';
const String _kActivityLogsKey = 'activity_logs_data';
const String _kConversationsKey = 'conversations_data';

/// Service ini bertindak sebagai "otak" dan "database palsu" untuk aplikasi.
/// Semua data (kamar, tagihan, dll.) dikelola di sini dan disimpan secara lokal
/// menggunakan SharedPreferences untuk persistensi antar sesi.
class DummyService {
  final SharedPreferences _prefs;

  // Properti ini menyimpan state data aplikasi saat runtime.
  late List<Room> rooms;
  late List<Bill> bills;
  late List<Complaint> complaints;
  late List<Announcement> announcements;
  late List<Request> requests;
  late List<AppNotification> notifications;
  late List<ActivityLog> activityLogs;
  late List<ChatConversation> conversations;

  DummyService(this._prefs);

  /// Metode inisialisasi utama untuk service. Wajib dipanggil saat aplikasi dimulai.
  Future<void> init() async {
    await _loadData();
  }

  /// Memuat semua data dari SharedPreferences. Jika data tidak ada (misal, saat pertama kali
  /// aplikasi dijalankan), maka akan dibuat data awal dari fungsi `_createInitial...`.
  Future<void> _loadData() async {
    rooms = _loadList(_prefs.getString(_kRoomsKey), (json) => Room.fromJson(json), _createInitialRooms);
    bills = _loadList(_prefs.getString(_kBillsKey), (json) => Bill.fromJson(json), _createInitialBills);
    complaints = _loadList(_prefs.getString(_kComplaintsKey), (json) => Complaint.fromJson(json), _createInitialComplaints);
    announcements = _loadList(_prefs.getString(_kAnnouncementsKey), (json) => Announcement.fromJson(json), _createInitialAnnouncements);
    requests = _loadList(_prefs.getString(_kRequestsKey), (json) => Request.fromJson(json), _createInitialRequests);
    notifications = _loadList(_prefs.getString(_kNotificationsKey), (json) => AppNotification.fromJson(json), _createInitialNotifications);
    activityLogs = _loadList(_prefs.getString(_kActivityLogsKey), (json) => ActivityLog.fromJson(json), _createInitialActivityLogs);
    conversations = _loadList(_prefs.getString(_kConversationsKey), (json) => ChatConversation.fromJson(json), _createInitialConversations);

    // Jika ini adalah pertama kalinya aplikasi dijalankan, simpan data awal.
    if (_prefs.getString(_kRoomsKey) == null) {
      await _saveData();
    }
  }

  /// Menyimpan semua state data saat ini ke SharedPreferences dengan mengubahnya menjadi string JSON.
  Future<void> _saveData() async {
    await _prefs.setString(_kRoomsKey, jsonEncode(rooms.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kBillsKey, jsonEncode(bills.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kComplaintsKey, jsonEncode(complaints.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kAnnouncementsKey, jsonEncode(announcements.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kRequestsKey, jsonEncode(requests.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kNotificationsKey, jsonEncode(notifications.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kActivityLogsKey, jsonEncode(activityLogs.map((e) => e.toJson()).toList()));
    await _prefs.setString(_kConversationsKey, jsonEncode(conversations.map((e) => e.toJson()).toList()));
  }

  /// Helper method generik untuk memuat list data dari string JSON.
  List<T> _loadList<T>(String? jsonString, T Function(Map<String, dynamic>) fromJson, List<T> Function() defaultCreator) {
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString);
        return decoded.map((e) => fromJson(e as Map<String, dynamic>)).toList();
      } catch (e) {
        // Jika terjadi error saat parsing, kembalikan data default.
        return defaultCreator();
      }
    } else {
      // Jika tidak ada data tersimpan, buat data default.
      return defaultCreator();
    }
  }

  // --- METODE LAPORAN ---
  /// Menghitung dan mengembalikan ringkasan data untuk halaman laporan admin.
  Map<String, dynamic> getAdminReportSummary() {
    // Laporan Keuangan
    final double totalRevenue = bills.where((b) => b.status == 'Lunas').fold(0.0, (prev, bill) => prev + bill.amount);
    final double pendingRevenue = bills.where((b) => b.status == 'Belum Lunas').fold(0.0, (prev, bill) => prev + bill.amount);

    // Laporan Okupansi
    final int totalRooms = rooms.length;
    final int occupiedRooms = rooms.where((r) => r.status == 'Dihuni').length;
    final int vacantRooms = rooms.where((r) => r.status == 'Kosong').length;
    final double occupancyRate = totalRooms > 0 ? (occupiedRooms / totalRooms) * 100 : 0;

    // Laporan Aktivitas
    final int pendingComplaints = complaints.where((c) => c.status == 'Pending').length;
    final int pendingRequests = requests.where((r) => r.status == 'Menunggu Persetujuan' || r.status == 'Menunggu Pembayaran').length;

    return {
      'totalRevenue': totalRevenue,
      'pendingRevenue': pendingRevenue,
      'totalRooms': totalRooms,
      'occupiedRooms': occupiedRooms,
      'vacantRooms': vacantRooms,
      'occupancyRate': occupancyRate,
      'pendingComplaints': pendingComplaints,
      'pendingRequests': pendingRequests,
    };
  }

  // --- METODE CRUD (Create, Read, Update, Delete) ---

  /// Membuat tagihan bulanan untuk semua penghuni aktif.
  /// Mengembalikan jumlah tagihan baru yang berhasil dibuat.
  Future<int> generateMonthlyBills() async {
    final authService = getIt<AuthService>();
    final tenants = authService.allUsers.where((user) => user.role == 'tenant' && user.roomId != null).toList();
    final currentPeriod = DateFormat('MMMM yyyy', 'id_ID').format(DateTime.now());
    int newBillsCount = 0;

    for (final tenant in tenants) {
      // Cek apakah tagihan untuk periode ini sudah ada untuk pengguna ini.
      final billExists = bills.any((bill) => bill.userId == tenant.id && bill.period == currentPeriod);

      if (!billExists) {
        final room = findRoom(tenant.roomId!);
        if (room != null) {
          final newBill = Bill(
            id: 'bill-${DateTime.now().millisecondsSinceEpoch}-${tenant.id}',
            userId: tenant.id,
            roomId: tenant.roomId!,
            period: currentPeriod,
            amount: room.totalPrice.toDouble(),
            status: 'Belum Lunas',
            createdAt: DateTime.now(),
          );
          bills.add(newBill);
          newBillsCount++;
        }
      }
    }

    if (newBillsCount > 0) {
      await _saveData();
    }
    return newBillsCount;
  }

  // Metode untuk Chat
  ChatConversation getConversationForUser(String userId, String userName) {
    try {
      return conversations.firstWhere((c) => c.userId == userId);
    } catch (e) {
      final newConversation = ChatConversation(id: userId, userId: userId, userName: userName, messages: []);
      conversations.add(newConversation);
      return newConversation;
    }
  }

  Future<void> addMessage(String userId, ChatMessage message) async {
    final convIndex = conversations.indexWhere((c) => c.userId == userId);
    if (convIndex != -1) {
      conversations[convIndex].messages.insert(0, message);
      await _saveData();
    }
  }

  // Metode untuk Request
  Future<void> addRequest({
    required String type,
    required String note,
    required String status,
    String? roomCode,
    String? paymentMethod,
    DateTime? paymentDueDate,
    String? virtualAccountNumber,
  }) async {
    final authService = getIt<AuthService>();
    final newRequest = Request(
      id: 'req-${DateTime.now().millisecondsSinceEpoch}',
      type: type,
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      note: note,
      status: status,
      roomCode: roomCode,
      userName: authService.currentUser?.fullName ?? 'System',
      paymentMethod: paymentMethod,
      paymentDueDate: paymentDueDate,
      virtualAccountNumber: virtualAccountNumber,
    );
    requests.insert(0, newRequest);
    await _saveData();
  }

  // Metode untuk Notifikasi
  Future<void> addNotification({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) async {
    final newNotification = AppNotification(title: title, subtitle: subtitle, date: DateTime.now(), icon: icon, iconColor: iconColor);
    notifications.insert(0, newNotification);
    await _saveData();
  }

  Future<void> updateNotification(int index, AppNotification notification) async {
    if (index >= 0 && index < notifications.length) {
      notifications[index] = notification;
      await _saveData();
    }
  }

  // Metode untuk Log Aktivitas
  Future<void> addActivityLog({required String userId, required String userName, required String action}) async {
    final newLog = ActivityLog(id: 'log-${DateTime.now().millisecondsSinceEpoch}', userId: userId, userName: userName, action: action, timestamp: DateTime.now());
    activityLogs.insert(0, newLog);
    await _saveData();
  }

  // Metode untuk Tagihan (Bill)
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

  // Metode untuk Pengaduan (Complaint)
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

  // Metode untuk Pengumuman
  List<Announcement> getLatestAnnouncements() {
    announcements.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return announcements.where((a) => a.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)))).toList();
  }

  Future<void> addAnnouncement({required String title, required String content}) async {
    final newAnnouncement = Announcement(id: 'ann-${DateTime.now().millisecondsSinceEpoch}', title: title, content: content, createdAt: DateTime.now());
    announcements.insert(0, newAnnouncement);
    await _saveData();
  }

  // Metode untuk Kamar (Room)
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

// --- FUNGSI UNTUK MEMBUAT DATA AWAL (INITIAL DATA) ---
// Fungsi-fungsi ini hanya dijalankan sekali saat aplikasi pertama kali diinstal
// untuk mengisi aplikasi dengan data contoh.

List<ChatConversation> _createInitialConversations() => [];
List<ActivityLog> _createInitialActivityLogs() => [];
List<AppNotification> _createInitialNotifications() => [AppNotification(title: 'Selamat Datang di Ri-Kost!', subtitle: 'Jelajahi semua fitur yang tersedia untuk Anda.', date: DateTime.now().subtract(const Duration(days: 2)), icon: Icons.waving_hand, iconColor: Colors.orange)];
List<Request> _createInitialRequests() => [];
List<Bill> _createInitialBills() => [Bill(id: 'bill-001', userId: 'user1', roomId: 'A-101', period: 'Juli 2024', amount: 1150000, status: 'Belum Lunas', createdAt: DateTime(2024, 7, 1))];
List<Complaint> _createInitialComplaints() => [Complaint(id: 'comp-001', userId: 'user1', roomId: 'A-101', title: 'Keran Bocor', description: 'Keran di kamar mandi bocor terus.', category: 'Kerusakan Fasilitas', status: 'In Progress', createdAt: DateTime.now().subtract(const Duration(days: 2)), imageUrls: ['https://picsum.photos/seed/comp-001/200/300'])];
List<Announcement> _createInitialAnnouncements() => [Announcement(id: 'ann-001', title: 'Perbaikan Listrik', content: 'Akan ada pemadaman listrik sementara pada hari Sabtu, 20 Juli 2024.', createdAt: DateTime.now().subtract(const Duration(days: 1)))];
List<Room> _createInitialRooms() {
  final localImagePaths = [
    'assets/kamar_kost/kamar1.png',
    'assets/kamar_kost/kamar2.png',
    'assets/kamar_kost/kamar3.png',
    'assets/kamar_kost/kamar4.png',
    'assets/kamar_kost/kamar5.png',
    'assets/kamar_kost/kamar6.png',
    'assets/kamar_kost/kamar7.png',
    'assets/kamar_kost/kamar8.png',
    'assets/kamar_kost/kamar9.png',
    'assets/kamar_kost/kamar10.png',
    'assets/kamar_kost/kamar11.png',
    'assets/kamar_kost/kamar12.png',
    'assets/kamar_kost/kamar13.png',
    'assets/kamar_kost/kamar14.png',
    'assets/kamar_kost/kamar15.png',
    'assets/kamar_kost/kamar16.png',
  ];
  final List<Room> initialRooms = [];

  for (int i = 1; i <= 16; i++) {
    final String roomCode = 'A-${i.toString().padLeft(2, '0')}';
    final bool isOccupied = i % 3 == 0;
    final String status = isOccupied ? 'Dihuni' : 'Kosong';
    final String? tenantName = isOccupied ? 'Tenant ${i}' : null;
    final String? rentStartDate = isOccupied ? '2024-07-01' : null;

    String fasilitasTambahan;
    bool isFurnished;
    int jumlahKasur;

    if (i % 2 == 0) {
      fasilitasTambahan = 'Meja belajar, Lemari pakaian';
      isFurnished = true;
      jumlahKasur = 1;
    } else if (i % 3 == 0) {
      fasilitasTambahan = 'Meja belajar, Lemari pakaian, Kulkas mini';
      isFurnished = true;
      jumlahKasur = 2;
    } else {
      fasilitasTambahan = 'Lemari pakaian';
      isFurnished = false;
      jumlahKasur = 1;
    }

    initialRooms.add(
      Room(
        code: roomCode,
        status: status,
        baseRent: 700000 + (i * 10000),
        wifi: 100000,
        water: 50000,
        electricity: 150000,
        acCost: i % 2 == 0 ? 200000 : 0,
        packageFull: i % 4 == 0,
        dimensions: i % 4 == 0 ? "3x4 m" : "3x3.5 m",
        imageUrls: [localImagePaths[i - 1]], // Menggunakan indeks i-1 untuk gambar berurutan
        tenantName: tenantName,
        tenantAddress: isOccupied ? 'Jl. Contoh No. ${i}' : null,
        tenantPhone: isOccupied ? '0812345678${i.toString().padLeft(2, '0')}' : null,
        rentStartDate: rentStartDate,
        fasilitasTambahan: fasilitasTambahan,
        isFurnished: isFurnished,
        jumlahKasur: jumlahKasur,
      ),
    );
  }
  return initialRooms;
}
