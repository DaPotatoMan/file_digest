# file_digest

## About

Create MD5, SHA-256, and SHA-512 digests from files, `XFile`s, bytes, or streams.

## Features

- Works with files, `XFile`, bytes, and streams
- Supports MD5, SHA-256, and SHA-512
- Uses a web worker for SHA digests in web apps

## How to use

```dart
import 'dart:typed_data';

import 'package:file_digest/file_digest.dart';

final digest = FileDigest.bytes(Uint8List.fromList('Hello'.codeUnits));

final md5 = await digest.md5();
final sha256 = await digest.sha256();
final sha512 = await digest.sha512();
```

You can also create a digest from a native file or an `XFile`:

```dart
final digest = FileDigest.xFile(file);
final sha256 = await digest.sha256();
```

`FileDigest.stream` can be read once. Use `bytes`, `file`, or `xFile` when you need to calculate more than one digest.

## Compatibility

| Input | Web | Android, iOS, Linux, macOS, Windows |
| --- | --- | --- |
| `FileDigest.bytes` | Yes | Yes |
| `FileDigest.stream` | Yes | Yes |
| `FileDigest.xFile` | Yes | Yes |
| `FileDigest.file` | No | Yes |

## License

Licensed under the MIT License. See [LICENSE](LICENSE).
