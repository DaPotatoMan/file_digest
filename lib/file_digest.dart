/// A package for creating file digests.
library;

import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:file_digest/src/stub.dart'
    if (dart.library.io) 'package:file_digest/src/vm.dart'
    if (dart.library.js_interop) 'package:file_digest/src/web.dart'
    as backend;
import 'package:file_digest/src/types.dart';

export 'package:file_digest/src/types.dart';

/// Provides methods for creating file digests.
class FileDigest {
  /// Creates a digest from a stream. The stream can only be used once.
  FileDigest.stream(Stream<List<int>> stream) : _openRead = _singleUse(stream);

  /// Creates a digest from [bytes].
  FileDigest.bytes(Uint8List bytes) : _openRead = (() => .value(bytes));

  /// Creates a digest from a [File].
  FileDigest.file(File file) : _openRead = file.openRead;

  /// Creates a digest from an [XFile].
  FileDigest.xFile(XFile file) : _openRead = file.openRead;

  final FileStreamReader _openRead;

  /// Returns the digest for [type].
  Future<String> convert(DigestType type) => backend.convert(type, _openRead);

  /// Returns the MD5 digest.
  Future<String> md5() => convert(.md5);

  /// Returns the SHA-256 digest.
  Future<String> sha256() => convert(.sha256);

  /// Returns the SHA-512 digest.
  Future<String> sha512() => convert(.sha512);

  static FileStreamReader _singleUse(Stream<List<int>> stream) {
    var opened = false;

    return () {
      if (opened) {
        throw StateError(
          'A FileDigest created with FileDigest.stream can only be used once. '
          'Use a file, XFile, bytes, or create a new stream for each digest.',
        );
      }

      opened = true;
      return stream;
    };
  }
}
