import 'package:cross_file/cross_file.dart';
import 'package:file_digest/file_digest.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const _App());
}

class _App extends StatelessWidget {
  const _App();

  static const input = 'Test content';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<Map<String, String>> getDigests() async {
    final file = XFile.fromData(.fromList(input.codeUnits));
    final digest = FileDigest.xFile(file);

    return {'MD5': await digest.md5(), 'SHA-256': await digest.sha256(), 'SHA-512': await digest.sha512()};
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('file_digest')),
        body: Center(
          child: Container(
            width: 700,
            alignment: .center,
            child: FutureBuilder(
              future: getDigests(),
              builder: (context, snapshot) {
                final data = snapshot.data;

                if (snapshot.error case final error?) {
                  return Text('Failed to create digests $error');
                }

                if (data == null) {
                  return const SizedBox.square(dimension: 20, child: CircularProgressIndicator());
                }

                return DataTable(
                  dividerThickness: 0.4,
                  horizontalMargin: 0,

                  dataRowMaxHeight: 70.0,

                  columns: const [
                    .new(label: Text('Type')),
                    .new(label: Text('Result')),
                  ],

                  rows: [
                    for (final item in data.entries)
                      .new(
                        cells: [
                          DataCell(Text(item.key, style: const .new(fontSize: 16, fontWeight: .w700))),
                          DataCell(
                            SizedBox(
                              width: 400,
                              child: Text(
                                item.value,
                                style: const .new(fontSize: 12.5, fontWeight: .normal),
                                softWrap: true,
                                overflow: .visible,
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
