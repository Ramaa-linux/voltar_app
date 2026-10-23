import 'dart:typed_data';

/// Program AVR hasil kompilasi (file Intel HEX) dalam bentuk memori flash.
///
/// Parser ditulis sendiri supaya tidak menambah dependency: hanya record
/// 00/01/02/04 yang dipakai, dan checksum salah langsung ditolak.
class AvrProgram {
  const AvrProgram._(this.words);

  /// Flash ATmega328P (Arduino Uno) = 32 KiB.
  static const int flashBytes = 0x8000;

  /// Jumlah word 16-bit di flash.
  static const int flashWords = flashBytes ~/ 2;

  /// Isi flash dalam word 16-bit - format yang diminta `CPU` avr8_dart.
  final Uint16List words;

  /// Parse teks Intel HEX.
  ///
  /// Melempar [FormatException] bila ada baris rusak, checksum salah, alamat
  /// melewati flash, atau record EOF (`:00000001FF`) tidak ditemukan.
  static AvrProgram parseIntelHex(String source) {
    final Uint8List flash = Uint8List(flashBytes);
    final List<String> lines = source.split('\n');
    int base = 0;
    bool eof = false;

    for (int i = 0; i < lines.length; i++) {
      final String line = lines[i].trim();
      if (line.isEmpty) {
        continue;
      }
      final int lineNumber = i + 1;
      if (!line.startsWith(':')) {
        throw FormatException('Baris $lineNumber: record harus diawali ":"');
      }
      // Panjang baris selalu ganjil: ":" + 4 byte header + data + checksum.
      if (line.length < 11) {
        throw FormatException('Baris $lineNumber: panjang record tidak valid');
      }

      final int byteCount = _byteAt(line, 1, lineNumber);
      if (line.length != 11 + byteCount * 2) {
        throw FormatException('Baris $lineNumber: jumlah byte tidak cocok');
      }

      // Header 4 byte + data + checksum; totalnya harus 0 mod 256.
      int sum = 0;
      for (int b = 0; b <= byteCount + 4; b++) {
        sum += _byteAt(line, 1 + b * 2, lineNumber);
      }
      if ((sum & 0xff) != 0) {
        throw FormatException('Baris $lineNumber: checksum salah');
      }

      final int type = _byteAt(line, 7, lineNumber);
      final int address =
          (_byteAt(line, 3, lineNumber) << 8) | _byteAt(line, 5, lineNumber);

      switch (type) {
        case 0x00:
          for (int b = 0; b < byteCount; b++) {
            final int target = base + address + b;
            if (target >= flash.length) {
              throw FormatException(
                'Baris $lineNumber: alamat melewati batas flash',
              );
            }
            flash[target] = _byteAt(line, 9 + b * 2, lineNumber);
          }
          break;
        case 0x01:
          eof = true;
          break;
        case 0x02:
          base = ((_byteAt(line, 9, lineNumber) << 8) |
                  _byteAt(line, 11, lineNumber)) <<
              4;
          break;
        case 0x04:
          base = ((_byteAt(line, 9, lineNumber) << 8) |
                  _byteAt(line, 11, lineNumber)) <<
              16;
          break;
        default:
          // 03/05 (start address) tidak dipakai simulator.
          break;
      }

      if (eof) {
        break;
      }
    }

    if (!eof) {
      throw const FormatException('Intel HEX tanpa record EOF');
    }

    final Uint16List words = Uint16List(flashWords);
    for (int i = 0; i < words.length; i++) {
      words[i] = flash[i * 2] | (flash[i * 2 + 1] << 8);
    }
    return AvrProgram._(words);
  }

  static int _byteAt(String line, int offset, int lineNumber) {
    return (_hexDigit(line, offset, lineNumber) << 4) |
        _hexDigit(line, offset + 1, lineNumber);
  }

  static int _hexDigit(String line, int index, int lineNumber) {
    final int code = line.codeUnitAt(index);
    if (code >= 0x30 && code <= 0x39) {
      return code - 0x30;
    }
    if (code >= 0x41 && code <= 0x46) {
      return code - 0x41 + 10;
    }
    if (code >= 0x61 && code <= 0x66) {
      return code - 0x61 + 10;
    }
    throw FormatException('Baris $lineNumber: karakter bukan hex');
  }
}
