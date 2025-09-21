import 'package:tes/shared/models/room.dart';
import 'package:tes/shared/models/bill.dart';
import 'package:tes/shared/models/request.dart';

class DummyService {
  static String? userRoomCode;
  static String? userName;

  // Daftar path gambar lokal
  static const List<String> localImagePaths = [
    'assets/kamar_kost/kamar1.png',
    'assets/kamar_kost/kamar2.png',
    'assets/kamar_kost/kamar3.png',
  ];

  static List<Room> rooms = [
    // Gedung A
    Room(
      code: "A-101", status: "Dihuni", baseRent: 750000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000,
      dimensions: "3x4 m", imageUrls: localImagePaths,
      tenantName: "Budi Santoso", tenantAddress: "Jl. Melati No. 5", tenantPhone: "081234567890", rentStartDate: "2024-07-01",
    ),
    Room(
      code: "A-102", status: "Kosong", baseRent: 700000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000,
      dimensions: "3x3.5 m", imageUrls: localImagePaths,
    ),
    Room(
      code: "A-103", status: "Dihuni", baseRent: 800000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000,
      dimensions: "4x4 m", imageUrls: localImagePaths,
      tenantName: "Siti Aminah", tenantAddress: "Jl. Kenanga No. 12", tenantPhone: "081212345678", rentStartDate: "2024-06-15",
    ),
    Room(
      code: "A-104", status: "Kosong", baseRent: 725000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000,
      dimensions: "3.5x4 m", imageUrls: localImagePaths,
    ),
    // Gedung B
    Room(
      code: "B-201", status: "Dihuni", baseRent: 900000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4x5 m", imageUrls: localImagePaths,
      tenantName: "Joko Susilo", tenantAddress: "Jl. Mawar No. 3", tenantPhone: "081312345678", rentStartDate: "2024-08-01",
    ),
    Room(
      code: "B-202", status: "Kosong", baseRent: 850000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4x4.5 m", imageUrls: localImagePaths,
    ),
    Room(
      code: "B-203", status: "Dihuni", baseRent: 950000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4.5x5 m", imageUrls: localImagePaths,
      tenantName: "Dewi Sartika", tenantAddress: "Jl. Anggrek No. 7", tenantPhone: "081512345678", rentStartDate: "2024-07-20",
    ),
    Room(
      code: "B-204", status: "Kosong", baseRent: 875000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4x5 m", imageUrls: localImagePaths,
    ),
    // Gedung C
    Room(
      code: "C-101", status: "Dihuni", baseRent: 780000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000,
      dimensions: "3x4 m", imageUrls: localImagePaths,
      tenantName: "Rina Putri", tenantAddress: "Jl. Dahlia No. 8", tenantPhone: "081812345678", rentStartDate: "2024-05-10",
    ),
    Room(
      code: "C-102", status: "Kosong", baseRent: 760000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000,
      dimensions: "3x3.5 m", imageUrls: localImagePaths,
    ),
    Room(
      code: "C-103", status: "Kosong", baseRent: 770000, wifi: 100000, water: 50000, electricity: 150000, acCost: 250000,
      dimensions: "4x4 m", imageUrls: localImagePaths,
    ),
    Room(
      code: "C-104", status: "Dihuni", baseRent: 790000, wifi: 100000, water: 50000, electricity: 150000, acCost: 200000,
      dimensions: "3.5x4 m", imageUrls: localImagePaths,
      tenantName: "Agus Wijaya", tenantAddress: "Jl. Kamboja No. 15", tenantPhone: "081912345678", rentStartDate: "2024-04-25",
    ),
    // Gedung D
    Room(
      code: "D-201", status: "Kosong", baseRent: 920000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4x5 m", imageUrls: localImagePaths,
    ),
    Room(
      code: "D-202", status: "Dihuni", baseRent: 930000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4x4.5 m", imageUrls: localImagePaths,
      tenantName: "Lia Amelia", tenantAddress: "Jl. Flamboyan No. 1", tenantPhone: "081712345678", rentStartDate: "2024-03-18",
    ),
    Room(
      code: "D-203", status: "Kosong", baseRent: 910000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4.5x5 m", imageUrls: localImagePaths,
    ),
    Room(
      code: "D-204", status: "Dihuni", baseRent: 940000, wifi: 100000, water: 50000, electricity: 150000, packageFull: true, acCost: 0,
      dimensions: "4x5 m", imageUrls: localImagePaths,
      tenantName: "Tono Martono", tenantAddress: "Jl. Cempaka No. 20", tenantPhone: "081612345678", rentStartDate: "2024-02-01",
    ),
  ];

  static List<Bill> bills = [
    Bill(
      id: "b0", roomCode: "A-101", month: "Juli 2024", dueDate: "2024-07-10",
      total: 750000 + 100000 + 50000 + 150000, status: "Belum Dibayar",
    ),
    Bill(
      id: "b3", roomCode: "A-103", month: "Juli 2024", dueDate: "2024-07-10",
      total: 800000 + 100000 + 50000 + 150000, status: "Belum Dibayar",
    ),
  ];

  static List<Request> requests = [
    Request(
      type: "Kunjungan Ortu", date: "2025-09-10", note: "Ayah Ibu datang jam 10 pagi",
      status: "Pending", roomCode: "A-101", userName: "Budi Santoso",
    ),
  ];

  static void addRoom(Room room) {
    rooms.add(room);
  }

  static void updateRoom(Room updatedRoom) {
    final index = rooms.indexWhere((room) => room.code == updatedRoom.code);
    if (index != -1) {
      rooms[index] = updatedRoom;
    }
  }

  static void deleteRoom(String roomCode) {
    rooms.removeWhere((room) => room.code == roomCode);
  }

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
