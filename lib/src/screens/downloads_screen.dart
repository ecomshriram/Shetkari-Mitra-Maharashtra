import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class DownloadsScreen extends StatefulWidget {
  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  List<FileSystemEntity> _files = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final dir = await getExternalStorageDirectory();
    final folder = Directory(dir!.path);
    final files = folder.listSync().where((f) => f.path.endsWith('.pdf')).toList();
    setState(() {
      _files = files;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Center(child: CircularProgressIndicator(color: Colors.green));
    if (_files.isEmpty) return Center(child: Text('No downloads yet', style: TextStyle(color: Colors.grey)));
    return ListView.builder(
      itemCount: _files.length,
      itemBuilder: (c, i) {
        final f = _files[i];
        return ListTile(
          leading: Icon(Icons.picture_as_pdf, color: Colors.redAccent),
          title: Text(f.path.split('/').last),
          subtitle: Text(f.statSync().modified.toLocal().toString()),
          trailing: PopupMenuButton<String>(
            onSelected: (v) async {
              if (v == 'share') await Share.shareFiles([f.path]);
              if (v == 'delete') { await File(f.path).delete(); _loadFiles(); }
            },
            itemBuilder: (_) => [
              PopupMenuItem(value: 'share', child: Text('Share')),
              PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        );
      },
    );
  }
}
