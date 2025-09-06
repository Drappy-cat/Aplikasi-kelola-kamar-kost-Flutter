import '../models/room.dart';
import '../models/bill.dart';
import '../models/request.dart';

class DummyService {
  // ==== ROOMS ====
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

  // ==== BILLS (tiap bill dikaitkan ke roomCode) ====
  static List<Bill> bills = [
    Bill(
      id: "b1",
      roomCode: "A-101",
      month: "September 2025",
      total: 750000 + 100000 + 50000 + 150000,
      status: "Lunas",
      method: "Transfer",
      channel: "QRIS",
    ),
    Bill(
      id: "b2",
      roomCode: "A-101",
      month: "Agustus 2025",
      total: 750000 + 100000 + 50000 + 150000,
      status: "Lunas",
      method: "Cash",
    ),
  ];

  static List<Request> requests = [
    Request(
      type: "Kunjungan Ortu",
      date: "2025-09-10",
      note: "Ayah Ibu datang jam 10 pagi",
      status: "Pending",
    ),
  ];

  // ==== UTIL ====

  /// Hitung total tagihan untuk sebuah kamar (paket lengkap = utilitas 0)
  static int computeTotalForRoom(Room r) {
    if (r.packageFull) return r.baseRent;
    return r.baseRent + r.wifi + r.water + r.electricity;
  }

  /// Generate bill untuk kamar & bulan tertentu, lalu push ke list.
  static Bill generateBillForRoom(Room r, String monthLabel) {
    final bill = Bill(
      id: "bill_${DateTime.now().millisecondsSinceEpoch}",
      roomCode: r.code,
      month: monthLabel,
      total: computeTotalForRoom(r),
      status: "Belum Dibayar",
    );
    bills.insert(0, bill); // paling baru di atas
    return bill;
  }

  /// Ambil tagihan TERBARU untuk roomCode tertentu (jika ada)
  static Bill? latestBillForRoom(String roomCode) {
    for (final b in bills) {
      if (b.roomCode == roomCode) return b;
    }
    return null;
  }
}
