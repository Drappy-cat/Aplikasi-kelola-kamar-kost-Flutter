import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

/// Model data untuk merepresentasikan satu pesan tunggal di dalam sebuah percakapan.
@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    // ID unik untuk setiap pesan.
    required String id,
    // ID pengirim pesan, bisa berupa ID pengguna atau string 'admin'.
    required String senderId,
    // Isi teks dari pesan (opsional, karena pesan bisa berupa gambar).
    String? text,
    // URL gambar jika pesan ini adalah gambar (opsional).
    String? imageUrl,
    // Waktu pasti saat pesan dikirim.
    required DateTime timestamp,
  }) = _ChatMessage;

  /// Factory constructor untuk membuat instance ChatMessage dari JSON.
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}
