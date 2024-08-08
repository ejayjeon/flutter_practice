import 'package:path/path.dart' as p;

final iconPath = p.join('assets', 'icons');
final imagePath = p.join('assets', 'images');

String iconFilePath({
  required String fileName,
  String? subFolder,
}) {
  if (subFolder != null) {
    String subIconPath = p.join(iconPath, subFolder);
    return p.join(subIconPath, fileName);
  }
  return p.join(iconPath, fileName);
}
