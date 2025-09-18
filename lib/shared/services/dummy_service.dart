import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';

class DummyService {
  static String? userRoomCode;
  static String? userName;

  // DIUBAH: Menambahkan 14 kamar dengan variasi harga dan status
  static List<Room> rooms = [
    Room(
      code: "A-101", status: "Dihuni", baseRent: 750000, wifi: 100000, water: 50000, electricity: 150000,
      tenantName: "Budi Santoso", tenantAddress: "Jl. Melati No. 5", tenantPhone: "081234567890", rentStartDate: "2024-07-01",
    ),
    Room(
      code: "A-102", status: "Kosong", baseRent: 700000, wifi: 100000, water: 50000, electricity: 150000,
    ),
    Room(
      code: "A-103", status: "Dihuni", baseRent: 800000, wifi: 100000, water: 50000, electricity: 150000,
      tenantName: "Siti Aminah", tenantAddress: "Jl. Kenanga No. 12", tenantPhone: "081212345678", rentStartDate: "2024-06-15",
    ),
    Room(
      code: "A-104", status: "Kosong", baseRent: 725000, wifi: 100000, water: 50000, electricity: 150000,
    ),
    Room(
      code: "B-201", status: "Dihuni", baseRent: 900000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true,
      tenantName: "Joko Susilo", tenantAddress: "Jl. Mawar No. 3", tenantPhone: "081312345678", rentStartDate: "2024-08-01",
    ),
    Room(
      code: "B-202", status: "Kosong", baseRent: 850000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true,
    ),
    Room(
      code: "B-203", status: "Dihuni", baseRent: 950000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true,
      tenantName: "Dewi Sartika", tenantAddress: "Jl. Anggrek No. 7", tenantPhone: "081512345678", rentStartDate: "2024-07-20",
    ),
    Room(
      code: "B-204", status: "Kosong", baseRent: 875000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true,
    ),
    Room(
      code: "C-301", status: "Kosong", baseRent: 650000, wifi: 75000, water: 40000, electricity: 120000,
    ),
    Room(
      code: "C-302", status: "Dihuni", baseRent: 680000, wifi: 75000, water: 40000, electricity: 120000,
      tenantName: "Agus Salim", tenantAddress: "Jl. Dahlia No. 2", tenantPhone: "081712345678", rentStartDate: "2024-09-01",
    ),
    Room(
      code: "C-303", status: "Kosong", baseRent: 670000, wifi: 75000, water: 40000, electricity: 120000,
    ),
    Room(
      code: "C-304", status: "Kosong", baseRent: 690000, wifi: 75000, water: 40000, electricity: 120000,
    ),
    Room(
      code: "D-401", status: "Kosong", baseRent: 1000000, wifi: 120000, water: 60000, electricity: 180000, packageFull: true,
    ),
    Room(
      code: "D-402", status: "Kosong", baseRent: 1100000, wifi: 120000, water: 60000, electricity: 180000, packageFull: true,
    ),
  ];

  // ---------- BILLS ----------
  static List<Bill> bills = [
    Bill(
      id: "b0", roomCode: "A-101", month: "Juli 2024", dueDate: "2024-07-10",
      total: 750000 + 100000 + 50000 + 150000, status: "Belum Dibayar",
    ),
    Bill(
      id: "b1", roomCode: "A-101", month: "September 2025", dueDate: "2025-09-10",
      total: 750000 + 100000 + 50000 + 150000, status: "Lunas", method: "Transfer", channel: "QRIS",
    ),
    Bill(
      id: "b2", roomCode: "A-101", month: "Agustus 2025", dueDate: "2025-08-10",
      total: 750000 + 100000 + 50000 + 150000, status: "Lunas", method: "Cash",
    ),
    Bill(
      id: "b3", roomCode: "A-103", month: "Juli 2024", dueDate: "2024-07-10",
      total: 800000 + 100000 + 50000 + 150000, status: "Belum Dibayar",
    ),
  ];

  // ---------- REQUESTS ----------
  static List<Request> requests = [
    Request(
      type: "Kunjungan Ortu", date: "2025-09-10", note: "Ayah Ibu datang jam 10 pagi",
      status: "Pending", roomCode: "A-101", userName: "Budi Santoso",
    ),
  ];

  // ---------- UTIL ----------
  static int computeTotalForRoom(Room r) {
    if (r.packageFull) return r.baseRent;
    return r.baseRent + r.wifi + r.water + r.electricity;
  }

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
