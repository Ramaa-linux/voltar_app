import 'dart:convert';
import 'dart:io';

/// Ekstrak semua string terjemahan dari JSON materi dan tulis ke ARB +
/// localization_helper.dart.
///
/// Jalankan:  dart run tool/extract_materi_strings.dart

final _dataDir = 'assets/data';
final _arbId = File('lib/l10n/app_id.arb');
final _arbEn = File('lib/l10n/app_en.arb');
final _helper = File('lib/utils/localization_helper.dart');

// camelCase helper untuk step id (l1_kom_led -> L1KomLed)
String _toCamel(String s) {
  return s.split('_').map((p) {
    if (p.isEmpty) return p;
    return p[0].toUpperCase() + p.substring(1);
  }).join();
}

final _entries = <String, String>{}; // key -> Indonesian value

void _extractStep(String levelNum, String stepId, Map<String, dynamic> step) {
  final idCamel = _toCamel(stepId);
  final prefix = 'materiL$levelNum$idCamel';

  _entries['${prefix}Title'] = step['title'] as String? ?? '';
  _entries['${prefix}Description'] = step['description'] as String? ?? '';

  final et = step['estimatedTime'] as String?;
  if (et != null && et.isNotEmpty) {
    _entries['${prefix}EstimatedTime'] = et;
  }

  final content = step['content'] as List<dynamic>?;
  if (content != null) {
    for (var i = 0; i < content.length; i++) {
      final block = content[i] as Map<String, dynamic>;
      final type = block['type'] as String? ?? '';
      final data = block['data'] as String? ?? '';
      if (data.isNotEmpty && type != 'code') {
        final typeCamel = _toCamel(type);
        _entries['${prefix}Content$i$typeCamel'] = data;
      }
    }
  }

  final vs = step['videoSummary'] as List<dynamic>?;
  if (vs != null) {
    for (var i = 0; i < vs.length; i++) {
      final block = vs[i] as Map<String, dynamic>;
      final type = block['type'] as String? ?? '';
      final data = block['data'] as String? ?? '';
      if (data.isNotEmpty) {
        final typeCamel = _toCamel(type);
        _entries['${prefix}VideoSummary$i$typeCamel'] = data;
      }
    }
  }

  final questions = step['questions'] as List<dynamic>?;
  if (questions != null) {
    for (var qi = 0; qi < questions.length; qi++) {
      final q = questions[qi] as Map<String, dynamic>;
      final qId = q['id'] as String? ?? 'q$qi';
      final qCamel = _toCamel(qId);
      final question = q['question'] as String? ?? '';
      if (question.isNotEmpty) {
        _entries['${prefix}Q${qCamel}Question'] = question;
      }
      final options = q['options'] as List<dynamic>?;
      if (options != null) {
        for (var oi = 0; oi < options.length; oi++) {
          final opt = options[oi] as String? ?? '';
          if (opt.isNotEmpty) {
            _entries['${prefix}Q${qCamel}Option$oi'] = opt;
          }
        }
      }
    }
  }

  final sub = step['subMateri'] as List<dynamic>?;
  if (sub != null) {
    for (final s in sub) {
      _extractStep(levelNum, (s as Map)['id'] as String, s as Map<String, dynamic>);
    }
  }
}

void _processFile(String fileName, {String? levelNum}) {
  final jsonString = File('$_dataDir/$fileName').readAsStringSync();
  final List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
  for (final item in list) {
    final step = item as Map<String, dynamic>;
    final id = step['id'] as String;
    if (levelNum != null) {
      _extractStep(levelNum, id, step);
    } else {
      final idCamel = _toCamel(id);
      final prefix = 'materiKomponen$idCamel';
      _entries['${prefix}Title'] = step['title'] as String? ?? '';
      _entries['${prefix}Description'] = step['description'] as String? ?? '';
      final et = step['estimatedTime'] as String?;
      if (et != null && et.isNotEmpty) {
        _entries['${prefix}EstimatedTime'] = et;
      }
      final content = step['content'] as List<dynamic>?;
      if (content != null) {
        for (var i = 0; i < content.length; i++) {
          final block = content[i] as Map<String, dynamic>;
          final type = block['type'] as String? ?? '';
          final data = block['data'] as String? ?? '';
          if (data.isNotEmpty && type != 'code') {
            final typeCamel = _toCamel(type);
            _entries['${prefix}Content$i$typeCamel'] = data;
          }
        }
      }
      final vs = step['videoSummary'] as List<dynamic>?;
      if (vs != null) {
        for (var i = 0; i < vs.length; i++) {
          final block = vs[i] as Map<String, dynamic>;
          final type = block['type'] as String? ?? '';
          final data = block['data'] as String? ?? '';
          if (data.isNotEmpty) {
            final typeCamel = _toCamel(type);
            _entries['${prefix}VideoSummary$i$typeCamel'] = data;
          }
        }
      }
    }
  }
}

String _insertArbEntries(File arbFile, Map<String, String> entries, {bool isEn = false}) {
  var content = arbFile.readAsStringSync();
  content = content.trimRight();
  if (!content.endsWith('}')) throw Exception('ARB file does not end with }');

  final buffer = StringBuffer();
  buffer.writeln(content.substring(0, content.length - 1));
  buffer.writeln(',');

  final sortedKeys = entries.keys.toList()..sort();
  final totalLines = sortedKeys.length * 2;
  var lineIdx = 0;
  for (final key in sortedKeys) {
    final enValue = isEn ? '' : entries[key]!;
    final hasNext = lineIdx < totalLines - 1;
    buffer.writeln('  "$key": ${jsonEncode(enValue)}${hasNext ? ',' : ''}');
    lineIdx++;
    final hasNext2 = lineIdx < totalLines - 1;
    buffer.writeln('  "@$key": {"description": ""}${hasNext2 ? ',' : ''}');
    lineIdx++;
  }

  buffer.writeln('}');
  return buffer.toString();
}

String _generateSwitchCases(Map<String, String> entries) {
  final buffer = StringBuffer();
  final sortedKeys = entries.keys.toList()..sort();
  for (final key in sortedKeys) {
    buffer.writeln("      case '$key': return l10n.$key;");
  }
  return buffer.toString();
}

void main() {
  for (var i = 1; i <= 5; i++) {
    _processFile('level_$i.json', levelNum: i.toString());
  }
  _processFile('materi_komponen_level_1.json');

  print('Total unique strings extracted: ${_entries.length}');

  final idContent = _insertArbEntries(_arbId, _entries, isEn: false);
  _arbId.writeAsStringSync(idContent);

  final enContent = _insertArbEntries(_arbEn, _entries, isEn: true);
  _arbEn.writeAsStringSync(enContent);

  var helperContent = _helper.readAsStringSync();
  final defaultIdx = helperContent.indexOf('    default:');
  if (defaultIdx == -1) {
    throw Exception('Could not find default case in localization_helper.dart');
  }
  final switchCases = _generateSwitchCases(_entries);
  helperContent = helperContent.substring(0, defaultIdx) +
      switchCases +
      helperContent.substring(defaultIdx);
  _helper.writeAsStringSync(helperContent);

  print('ARB files updated.');
  print('localization_helper.dart updated with ${_entries.length} cases.');
  print('');
  print('NEXT STEPS:');
  print('  1. flutter gen-l10n');
  print('  2. flutter analyze');
  print('  3. Review app_en.arb - English values are placeholders (kosong), perlu diterjemahkan.');
}