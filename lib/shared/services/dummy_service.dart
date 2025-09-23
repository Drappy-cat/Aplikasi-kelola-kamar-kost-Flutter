import 'package:flutter/material.dart';
import 'package:tes/shared/models/app_notification.dart';
import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';
import 'package:tes/shared/models/app_user.dart'; // Assuming user model exists

class DummyService {
  static String? userRoomCode;
  static String? userName;

  // Dummy Bills Data
  static final List<Bill> _bills = [
    Bill(
      id: 'bill-001',
      userId: 'user1', // Corresponds to a user from AuthService
      roomId: 'A-101',
      period: 'Juli 2024',
      amount: 1150000,
      status: 'Belum Lunas',
      createdAt: DateTime(2024, 7, 1),
    ),
    Bill(
      id: 'bill-002',
      userId: 'user1',
      roomId: 'A-101',
      period: 'Juni 2024',
      amount: 1150000,
      status: 'Lunas',
      createdAt: DateTime(2024, 6, 1),
    ),
    Bill(
      id: 'bill-003',
      userId: 'user2', // Corresponds to another user
      roomId: 'A-103',
      period: 'Juli 2024',
      amount: 1200000,
      status: 'Menunggu Konfirmasi',
      paymentProofUrl: 'assets/kamar_kost/bukti_tf.png', // Example proof
      createdAt: DateTime(2024, 7, 2),
    ),
    Bill(
      id: 'bill-004',
      userId: 'user2',
      roomId: 'A-103',
      period: 'Juni 2024',
      amount: 1200000,
      status: 'Lunas',
      createdAt: DateTime(2024, 6, 2),
    ),
  ];

  // --- Bill Management Functions ---

  static List<Bill> getBillsForUser(String userId) {
    return _bills.where((bill) => bill.userId == userId).toList();
  }

  static List<Bill> getPendingConfirmationBills() {
    return _bills.where((bill) => bill.status == 'Menunggu Konfirmasi').toList();
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
        status: 'Menunggu Konfirmasi', // Update status
        paymentProofUrl: proofUrl, // Add proof URL
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
        status: 'Lunas', // Update status
        paymentProofUrl: oldBill.paymentProofUrl,
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
        status: 'Belum Lunas', // Revert status
        paymentProofUrl: null, // Clear proof URL
        createdAt: oldBill.createdAt,
      );
    }
  }


  // --- Existing Dummy Data and Functions ---

  static List<AppNotification> notifications = [
    AppNotification(
      title: 'Selamat Datang di Ri-Kost!',
      subtitle: 'Jelajahi semua fitur yang tersedia untuk Anda.',
      date: DateTime.now().subtract(const Duration(days: 2)),
      icon: Icons.waving_hand,
      iconColor: Colors.orange,
    ),
    AppNotification(
      title: 'Tagihan Sewa Mendekati Jatuh Tempo',
      subtitle: 'Tagihan kamar A-101 untuk bulan Juli 2024 akan jatuh tempo pada 10 Juli 2024.',
      date: DateTime.now().subtract(const Duration(hours: 5)),
      icon: Icons.receipt_long,
      iconColor: Colors.blue,
    ),
  ];

  static const List<String> localImagePaths = [
    'assets/kamar_kost/kamar1.png',
    'assets/kamar_kost/kamar2.png',
    'assets/kamar_kost/kamar3.png',
  ];

  static List<Room> rooms = [
    Room(
      code: "A-101", status: "Dihuni", baseRent: 750000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000,
      dimensions: "3x4 m", imageUrls: localImagePaths,
      tenantName: "Budi Santoso", tenantAddress: "Jl. Melati No. 5", tenantPhone: "081234567890", rentStartDate: "2024-07-01",
    ),
    Room(
      code: "A-103", status: "Dihuni", baseRent: 800000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000,
      dimensions: "4x4 m", imageUrls: localImagePaths,
      tenantName: "Siti Aminah", tenantAddress: "Jl. Kenanga No. 12", tenantPhone: "081212345678", rentStartDate: "2024-06-15",
    ),
    // ... other rooms
  ];

  static List<Request> requests = [
    Request(
      type: "Kunjungan Ortu", date: "2025-09-10", note: "Ayah Ibu datang jam 10 pagi",
      status: "Pending", roomCode: "A-101", userName: "Budi Santoso",
    ),
  ];

  // ... other existing functions
}
