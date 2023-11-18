#### Features
- Simple API
- Uses Web Workers in `Web` platforms to speed up parsing.
- Uses Isolate.run in other platforms

#### Why was this made?
Originally, it was created for the web platform to speed up digest creation through web workers. As parsing a large file in the main thread would freeze the app.

#### Example
From Uint8List file data

```dart
final Uint8List data = ...;

final String sha256 = await FileDigest(data).sha256();
final String sha512 = await FileDigest(data).sha512();
```

From String content
```dart
const input = 'Test content';
final String sha256 = await FileDigest.fromString(input).sha256();
final String sha512 = await FileDigest.fromString(input).sha512();
```
