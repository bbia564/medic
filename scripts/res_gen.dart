// ignore_for_file: uri_does_not_exist, undefined_function, depend_on_referenced_packages, avoid_print
import 'dart:io';

import 'package:path/path.dart';
import 'package:validators/validators.dart';

// 测试图片加解密
// void main() {
//   final file = File("/Users/yohom/Downloads/elephant_encrypted.png");
//   final bytes = file.readAsBytesSync().toList();
//   bytes.replaceRange(0, 8, [
//     for (var i = 0; i < 8; i++) ~bytes[i],
//   ]);
//   file.writeAsBytesSync(bytes);
// }

void main(List<String> args) {
  final result = StringBuffer("part of 'R.dart';\n\n");

  result.writeln('// ignore_for_file: non_constant_identifier_names');
  result.writeln('class _DrawableReference {');
  result.writeln('  _DrawableReference();\n');

  final allImages = <String>[];
  for (final arg in ['assets/images']) {
    if (arg.startsWith('-')) continue;

    final dir = Directory(arg);
    for (final file in dir.listSync()) {
      if (file is File && allowedFileType.contains(extension(file.path))) {
        var nameWithoutSuffix = basenameWithoutExtension(file.path);
        final extension_ = extension(file.path);
        if (reserved.contains(nameWithoutSuffix)) {
          nameWithoutSuffix = '${nameWithoutSuffix}_';
        }
        var path = file.absolute.path.replaceAll(r'\', r'/');
        if (!path.startsWith('/')) {
          path = '/$path';
        }
        result.writeln('  /// ![preview](file://$path)');

        var folder = 'images';
        if (extension_.endsWith('png') ||
            extension_.endsWith('jpg') ||
            extension_.endsWith('webp') ||
            extension_.endsWith('gif') ||
            extension_.endsWith('svg')) {
          folder = 'images';
        } else if (extension_.endsWith('ttf')) {
          folder = 'fonts';
        } else {
          folder = 'raw';
        }
        final varName = camel2Underscore(nameWithoutSuffix);
        result.writeln(
            "  final String $varName = 'assets/$folder/${basename(file.path)}';\n");
        allImages.add('assets/$folder/${basename(file.path)}');
      }
    }
  }
  print(allImages
      .where((it) => it.contains('-wheels-') && it.contains('MS-hero-front'))
      .join('\n'));
  // result.writeln('  late final all_images = [${allImages.join(', ')}];');
  result.writeln('}');

  // final formatter = DartFormatter();
  // final formatted = formatter.format(result.toString());

  final targetFile = File('lib/resource/drawables.dart');
  if (!targetFile.existsSync()) {
    targetFile.createSync();
  }
  targetFile.writeAsStringSync(result.toString());

  // print(result.toString());
}

/// 驼峰风格转为下划线风格
String camel2Underscore(String input) {
  if ('' == input.trim()) {
    return '';
  }
  final len = input.length;
  final sb = StringBuffer();
  for (var i = 0; i < len; i++) {
    final c = input[i];
    if (isUppercase(c) && isAlpha(c)) {
      if (i != 0) sb.write('_');
      sb.write(c.toLowerCase());
    } else {
      sb.write(c);
    }
  }
  return sb
      .toString()
      .replaceAll('-', '_')
      .replaceAll('(', '_')
      .replaceAll(')', '_');
}

String remove_1(String input) {
  return input.replaceAll('_1', '');
}

final reserved = [
  'abstract',
  'dynamic',
  'implements',
  'show',
  'as',
  'else',
  'import',
  'static',
  'assert',
  'enum',
  'in',
  'super',
  'async',
  'export',
  'interface',
  'switch',
  'await',
  'extends',
  'is',
  'sync',
  'break',
  'external',
  'library',
  'this',
  'case',
  'factory',
  'mixin',
  'throw',
  'catch',
  'false',
  'new',
  'true',
  'class',
  'final',
  'null',
  'try',
  'const',
  'finally',
  'on',
  'typedef',
  'continue',
  'for',
  'operator',
  'var',
  'covariant',
  'Function',
  'part',
  'void',
  'default',
  'get',
  'rethrow',
  'while',
  'deferred',
  'hide',
  'return',
  'with',
  'do',
  'if',
  'set',
  'yield',
];

final allowedFileType = [
  '.png',
  '.svg',
  '.jpg',
  '.webp',
  '.gif',
  '.json',
  '.mp4'
];
