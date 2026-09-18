import 'dart:typed_data';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:file_digest/file_digest.dart';

const int _dataSize = 1024 * 1024;

class DigestBenchmark extends AsyncBenchmarkBase {
  DigestBenchmark(this._type) : super('FileDigest.bytes.${_type.name} (1 MiB)');

  final DigestType _type;
  late final Uint8List _data;

  @override
  Future<void> setup() async {
    _data = Uint8List.fromList(List<int>.generate(_dataSize, (index) => index));
  }

  @override
  Future<void> run() => FileDigest.bytes(_data).convert(_type);
}

Future<void> main() async {
  for (final type in DigestType.values) {
    await DigestBenchmark(type).report();
  }
}
