import 'package:flutter/material.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/app_user.dart';
import 'package:tes/shared/models/complaint.dart';
import 'package:tes/shared/models/announcement.dart';

class DummyService {
  static String? userRoomCode;
  static String? userName;

  // --- Data Repositories ---
  static final List<Room> rooms = _createInitialRooms();
  static final List<Bill> _bills = _createInitialBills();
  static final List<Complaint> _complaints = _createInitialComplaints();
  static final List<Announcement> _announcements = _createInitialAnnouncements();
  static List<Request> requests = _createInitialRequests();
  static List<AppNotification> notifications = _createInitialNotifications();

  // --- Bill Management ---
  static List<Bill> getBillsForUser(String userId) => _bills.where((b) => b.userId == userId).toList();
  static List<Bill> getPendingConfirmationBills() => _bills.where((b) => b.status == 'Menunggu Konfirmasi').toList();

  static void confirmCashPayment(String billId) {
    final index = _bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      final oldBill = _bills[index];
      _bills[index] = Bill(
        id: oldBill.id,
        userId: oldBill.userId,
        roomId: oldBill.roomId,
        period: oldBill.period,
        amount: oldBill.amount,
        status: 'Menunggu Konfirmasi',
        paymentProofUrl: null,
        paymentMethod: 'Tunai',
        createdAt: oldBill.createdAt,
      );
    }
  }

  static void submitPaymentProof(String billId, String proofUrl) {
    final index = _bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      final oldBill = _bills[index];
      _bills[index] = Bill(
        id: oldBill.id,
        userId: oldBill.userId,
        roomId: oldBill.roomId,
        period: oldBill.period,
        amount: oldBill.amount,
        status: 'Menunggu Konfirmasi',
        paymentProofUrl: proofUrl,
        paymentMethod: 'Transfer',
        createdAt: oldBill.createdAt,
      );
    }
  }

  static void approveBill(String billId) {
    final index = _bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      final oldBill = _bills[index];
      _bills[index] = Bill(
        id: oldBill.id,
        userId: oldBill.userId,
        roomId: oldBill.roomId,
        period: oldBill.period,
        amount: oldBill.amount,
        status: 'Lunas',
        paymentProofUrl: oldBill.paymentProofUrl,
        paymentMethod: oldBill.paymentMethod,
        createdAt: oldBill.createdAt,
      );
    }
  }

  static void rejectBill(String billId) {
    final index = _bills.indexWhere((bill) => bill.id == billId);
    if (index != -1) {
      final oldBill = _bills[index];
      _bills[index] = Bill(
        id: oldBill.id,
        userId: oldBill.userId,
        roomId: oldBill.roomId,
        period: oldBill.period,
        amount: oldBill.amount,
        status: 'Belum Lunas',
        paymentProofUrl: null,
        paymentMethod: null,
        createdAt: oldBill.createdAt,
      );
    }
  }

  // --- Request Management ---
  static Future<void> submitAndAutoApproveRentalRequest({
    required AppUser user,
    required Room room,
  }) async {
    final requestId = 'req-${DateTime.now().millisecondsSinceEpoch}';
    final newRequest = Request(
      id: requestId, 
      type: "Pengajuan Sewa",
      date: DateTime.now().toIso8601String().substring(0, 10),
      note: "Pengajuan sewa oleh ${user.name}",
      status: "Pending",
      roomCode: room.code,
      userName: user.name,
    );
    requests.insert(0, newRequest);

    await Future.delayed(const Duration(seconds: 3));

    final requestIndex = requests.indexWhere((req) => req.id == requestId);
    if (requestIndex != -1) {
      final oldRequest = requests[requestIndex];
      requests[requestIndex] = Request(
        id: oldRequest.id,
        type: oldRequest.type,
        date: oldRequest.date,
        note: oldRequest.note,
        status: "Approved",
        roomCode: oldRequest.roomCode,
        userName: oldRequest.userName,
      );

      final roomIndex = rooms.indexWhere((r) => r.code == room.code);
      if (roomIndex != -1) {
        final oldRoom = rooms[roomIndex];
        final now = DateTime.now();
        rooms[roomIndex] = Room(
          code: oldRoom.code,
          status: "Dihuni",
          baseRent: oldRoom.baseRent,
          wifi: oldRoom.wifi,
          water: oldRoom.water,
          electricity: oldRoom.electricity,
          acCost: oldRoom.acCost,
          dimensions: oldRoom.dimensions,
          imageUrls: oldRoom.imageUrls,
          tenantName: user.name,
          tenantAddress: "Jl. Baru No. 1",
          tenantPhone: "08123456789",
          rentStartDate: now.toIso8601String().substring(0, 10),
        );
        
        final totalRent = computeTotalForRoom(rooms[roomIndex]);
        final billPeriod = "${_getMonthName(now.month)} ${now.year}";

        final firstBill = Bill(
          id: 'bill-${now.millisecondsSinceEpoch}',
          userId: user.id,
          roomId: room.code,
          period: billPeriod,
          amount: totalRent.toDouble(),
          status: 'Belum Lunas',
          createdAt: now,
        );
        _bills.insert(0, firstBill);

        notifications.insert(0, AppNotification(
          title: 'Pengajuan Sewa Disetujui!',
          subtitle: 'Pengajuan sewa untuk kamar ${room.code} telah disetujui. Tagihan pertama telah dibuat.',
          date: now,
          icon: Icons.check_circle,
          iconColor: Colors.green,
        ));
      }
    }
  }

  //  Complaint Management
  static List<Complaint> getComplaintsForUser(String userId) => _complaints.where((c) => c.userId == userId).toList();
  static List<Complaint> getAllComplaints() => _complaints;

  static void addComplaint({
    required String userId,
    required String roomId,
    required String title,
    required String description,
    required String category,
    List<String> imageUrls = const [],
  }) {
    final newComplaint = Complaint(
      id: 'comp-${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      roomId: roomId,
      title: title,
      description: description,
      category: category,
      status: 'Pending',
      imageUrls: imageUrls,
      createdAt: DateTime.now(),
    );
    _complaints.insert(0, newComplaint);
  }

  static void updateComplaintStatus(String complaintId, String newStatus) {
    final index = _complaints.indexWhere((c) => c.id == complaintId);
    if (index != -1) {
      final old = _complaints[index];
      _complaints[index] = Complaint(
        id: old.id,
        userId: old.userId,
        roomId: old.roomId,
        title: old.title,
        description: old.description,
        category: old.category,
        status: newStatus,
        imageUrls: old.imageUrls,
        createdAt: old.createdAt,
      );
    }
  }

  static List<Announcement> getLatestAnnouncements() {
    _announcements.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return _announcements.where((a) => a.createdAt.isAfter(DateTime.now().subtract(const Duration(days: 30)))).toList();
  }

  static void addAnnouncement({required String title, required String content}) {
    final newAnnouncement = Announcement(
      id: 'ann-${DateTime.now().millisecondsSinceEpoch}',
      title: title, content: content, createdAt: DateTime.now(),
    );
    _announcements.insert(0, newAnnouncement);
  }

  static Room? findRoom(String code) {
    try {
      return rooms.firstWhere((r) => r.code == code);
    } catch (_) {
      return null;
    }
  }

  static void addRoom(Room room) => rooms.add(room);

  static void updateRoom(Room updatedRoom) {
    final index = rooms.indexWhere((room) => room.code == updatedRoom.code);
    if (index != -1) {
      rooms[index] = updatedRoom;
    }
  }

  static int computeTotalForRoom(Room r) {
    if (r.packageFull) return r.baseRent;
    return r.baseRent + r.wifi + r.water + r.electricity;
  }

  static List<AppNotification> _createInitialNotifications() => [
    AppNotification(title: 'Selamat Datang di Ri-Kost!', subtitle: 'Jelajahi semua fitur yang tersedia untuk Anda.', date: DateTime.now().subtract(const Duration(days: 2)), icon: Icons.waving_hand, iconColor: Colors.orange),
    AppNotification(title: 'Tagihan Sewa Mendekati Jatuh Tempo', subtitle: 'Tagihan kamar A-101 untuk bulan Juli 2024 akan jatuh tempo pada 10 Juli 2024.', date: DateTime.now().subtract(const Duration(hours: 5)), icon: Icons.receipt_long, iconColor: Colors.blue),
  ];

  static List<Request> _createInitialRequests() => [
    Request(id: 'req-001', type: "Kunjungan Ortu", date: "2025-09-10", note: "Ayah Ibu datang jam 10 pagi", status: "Pending", roomCode: "A-101", userName: "Budi Santoso"),
  ];

  static List<Bill> _createInitialBills() => [
    Bill(id: 'bill-001', userId: 'user1', roomId: 'A-101', period: 'Juli 2024', amount: 1150000, status: 'Belum Lunas', createdAt: DateTime(2024, 7, 1)),
    Bill(id: 'bill-002', userId: 'user1', roomId: 'A-101', period: 'Juni 2024', amount: 1150000, status: 'Lunas', paymentMethod: 'Transfer', createdAt: DateTime(2024, 6, 1)),
    Bill(id: 'bill-003', userId: 'user2', roomId: 'A-103', period: 'Juli 2024', amount: 1200000, status: 'Menunggu Konfirmasi', paymentProofUrl: 'https://picsum.photos/seed/bill-003/400/600', paymentMethod: 'Transfer', createdAt: DateTime(2024, 7, 2)),
    Bill(id: 'bill-004', userId: 'user2', roomId: 'A-103', period: 'Juni 2024', amount: 1200000, status: 'Lunas', paymentMethod: 'Tunai', createdAt: DateTime(2024, 6, 2)),
  ];

  static List<Complaint> _createInitialComplaints() => [
    Complaint(id: 'comp-001', userId: 'user1', roomId: 'A-101', title: 'Keran Bocor', description: 'Keran di kamar mandi bocor terus.', category: 'Kerusakan Fasilitas', status: 'In Progress', createdAt: DateTime.now().subtract(const Duration(days: 2)), imageUrls: ['https://picsum.photos/seed/comp-001/200/300']),
    Complaint(id: 'comp-002', userId: 'user2', roomId: 'A-103', title: 'AC tidak dingin', description: 'AC sudah dinyalakan lama tapi tidak terasa dingin sama sekali.', category: 'Kerusakan Fasilitas', status: 'Pending', createdAt: DateTime.now().subtract(const Duration(hours: 5))),
  ];

  static List<Announcement> _createInitialAnnouncements() => [
    Announcement(id: 'ann-001', title: 'Perbaikan Listrik', content: 'Akan ada pemadaman listrik sementara pada hari Sabtu, 20 Juli 2024 dari jam 10:00 - 12:00 untuk perbaikan instalasi. Mohon maaf atas ketidaknyamanannya.', createdAt: DateTime.now().subtract(const Duration(days: 1))),
  ];

  static List<Room> _createInitialRooms() {
    // Menggunakan URL gambar dari internet
    final networkImagePaths = {
      "A-101": ['https://picsum.photos/seed/A-101-1/800/600', 'https://picsum.photos/seed/A-101-2/800/600', 'https://picsum.photos/seed/A-101-3/800/600'],
      "A-102": ['https://picsum.photos/seed/A-102-1/800/600', 'https://picsum.photos/seed/A-102-2/800/600', 'https://picsum.photos/seed/A-102-3/800/600'],
      "A-103": ['https://picsum.photos/seed/A-103-1/800/600', 'https://picsum.photos/seed/A-103-2/800/600', 'https://picsum.photos/seed/A-103-3/800/600'],
      "A-104": ['https://picsum.photos/seed/A-104-1/800/600', 'https://picsum.photos/seed/A-104-2/800/600', 'https://picsum.photos/seed/A-104-3/800/600'],
    };

    return [
      Room(code: "A-101", status: "Dihuni", baseRent: 750000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000, dimensions: "3x4 m", imageUrls: networkImagePaths["A-101"]!, tenantName: "Budi Santoso", tenantAddress: "Jl. Melati No. 5", tenantPhone: "081234567890", rentStartDate: "2024-07-01"),
      Room(code: "A-102", status: "Kosong", baseRent: 700000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000, dimensions: "3x3.5 m", imageUrls: networkImagePaths["A-102"]!),
      Room(code: "A-103", status: "Dihuni", baseRent: 800000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000, dimensions: "4x4 m", imageUrls: networkImagePaths["A-103"]!, tenantName: "Siti Aminah", tenantAddress: "Jl. Kenanga No. 12", tenantPhone: "081212345678", rentStartDate: "2024-06-15"),
      Room(code: "A-104", status: "Kosong", baseRent: 725000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000, dimensions: "3.5x4 m", imageUrls: networkImagePaths["A-104"]!),
    ];
  }

  static String _getMonthName(int month) {
    const monthNames = [
      "Januari", "Februari", "Maret", "April", "Mei", "Juni",
      "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    ];
    if (month < 1 || month > 12) {
      return "";
    }
    return monthNames[month - 1];
  }
}
