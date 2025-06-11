#### Features

- Simple API
- Uses Web Workers in `Web` platforms to speed up parsing.
- Supports XFile from `cross-file` package

#### Why was this made?

Originally, it was created for the web platform to speed up digest creation through web workers. As parsing a large file in the main thread would freeze the app.

#### Example

From File

```dart
final file = File(...);

final String md5 = await FileDigest.file(file).md5();
final String sha256 = await FileDigest.file(file).sha256();
final String sha512 = await FileDigest.file(file).sha512();
```

From XFile

```dart
final file = XFile(...);

final String md5 = await FileDigest.xFile(file).md5();
final String sha256 = await FileDigest.xFile(file).sha256();
final String sha512 = await FileDigest.xFile(file).sha512();
```
