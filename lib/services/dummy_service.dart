import '../models/room.dart';
import '../models/bill.dart';
import '../models/request.dart';

class DummyService {
  // ====== STATE SEDERHANA UNTUK "USER" TANPA BACKEND ======
  static String? userRoomCode; // kamar yang dimiliki user saat ini (jika ada)
  static String? userName;     // nama user (diambil saat booking)

  // ---------- ROOMS ----------
  static List<Room> rooms = [
    Room(
      code: "A-101",
      status: "Dihuni",
      baseRent: 750000,
      wifi: 100000,
      water: 50000,
      electricity: 150000,
      packageFull: false,
      tenantName: "Budi Santoso",
      tenantAddress: "Jl. Melati No. 5, Surabaya",
      tenantPhone: "081234567890",
      rentStartDate: "2024-07-01", // DIUBAH: Tambah tanggal sewa
    ),
    Room(
      code: "A-102",
      status: "Kosong",
      baseRent: 700000,
      wifi: 100000,
      water: 50000,
      electricity: 150000,
      packageFull: true,
    ),
  ];

  // ---------- BILLS ----------
  static List<Bill> bills = [
    // DIUBAH: Tambah tagihan yang sudah telat
    Bill(
      id: "b0",
      roomCode: "A-101",
      month: "Juli 2024",
      dueDate: "2024-07-10", // Jatuh tempo sudah lewat
      total: 750000 + 100000 + 50000 + 150000,
      status: "Belum Dibayar",
    ),
    Bill(
      id: "b1",
      roomCode: "A-101",
      month: "September 2025",
      dueDate: "2025-09-10",
      total: 750000 + 100000 + 50000 + 150000,
      status: "Lunas",
      method: "Transfer",
      channel: "QRIS",
    ),
    Bill(
      id: "b2",
      roomCode: "A-101",
      month: "Agustus 2025",
      dueDate: "2025-08-10",
      total: 750000 + 100000 + 50000 + 150000,
      status: "Lunas",
      method: "Cash",
    ),
  ];

  // ---------- REQUESTS ----------
  static List<Request> requests = [
    Request(
      type: "Kunjungan Ortu",
      date: "2025-09-10",
      note: "Ayah Ibu datang jam 10 pagi",
      status: "Pending",
      roomCode: "A-101",
      userName: "Budi Santoso",
    ),
  ];

  // ---------- UTIL ----------
  static int computeTotalForRoom(Room r) {
    if (r.packageFull) return r.baseRent;
    return r.baseRent + r.wifi + r.water + r.electricity;
  }

  // DIUBAH: Logika pembuatan tagihan sekarang menyertakan dueDate
  static Bill generateBillForRoom(Room r, String monthLabel, String dueDate) {
    final bill = Bill(
      id: "bill_${DateTime.now().millisecondsSinceEpoch}",
      roomCode: r.code,
      month: monthLabel,
      dueDate: dueDate,
      total: computeTotalForRoom(r),
      status: "Belum Dibayar",
    );
    bills.insert(0, bill);
    return bill;
  }

  static Bill? latestBillForRoom(String roomCode) {
    for (final b in bills) {
      if (b.roomCode == roomCode) return b;
    }
    return null;
  }

  static Room? findRoom(String code) {
    try {
      return rooms.firstWhere((r) => r.code == code);
    } catch (_) {
      return null;
    }
  }
}
