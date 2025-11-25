import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class DownloadService {
  static Future<File> downloadFile(String url, {String prefix = 'file_'}) async {
    final client = http.Client();
    final resp = await client.get(Uri.parse(url));
    if (resp.statusCode != 200) throw Exception('Download error ${resp.statusCode}');
    final bytes = resp.bodyBytes;
    final dir = await getExternalStorageDirectory();
    final path = '${dir!.path}/$prefix${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(path);
    await file.writeAsBytes(bytes);
    return file;
  }
}
