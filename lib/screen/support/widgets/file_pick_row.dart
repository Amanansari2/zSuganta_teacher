import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class FilePickerRow extends StatefulWidget {
  final void Function(File? file)? onFileSelected;
  final File? file;

  const FilePickerRow({super.key, this.onFileSelected, this.file});

  @override
  State<FilePickerRow> createState() => _FilePickerRowState();
}

class _FilePickerRowState extends State<FilePickerRow> {
  File? _selectedFile;
  String? _error;

  @override
  void initState() {
    super.initState();
    _selectedFile = widget.file;
  }

  @override
  void didUpdateWidget(covariant FilePickerRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file != widget.file) {
      setState(() {
        _selectedFile = widget.file;
      });
    }
  }

  Future<void> _pickFile(BuildContext context) async {

    try {
      PermissionStatus permissionStatus = PermissionStatus.denied;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt <= 32) {
          permissionStatus = await Permission.storage.request();
        } else {
          permissionStatus = await Permission.photos.request();
        }

        if (permissionStatus.isDenied) {
          return;
        } else if (permissionStatus.isPermanentlyDenied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  "Permission permanently denied. Enable it in settings."),
            ),
          );
          openAppSettings();
          return;
        }
      }
      setState(() {
        _error = null;
      });

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'gif'
        ],
      );

      if (result != null && result.files.isNotEmpty) {
        final pickedFile = File(result.files.single.path!);


        final fileSize = pickedFile.lengthSync();
        if (fileSize > 10 * 1024 * 1024) {
          setState(() {
            _error = "File size must be less than 10MB";
            _selectedFile = null;
          });
          widget.onFileSelected?.call(null);
          return;
        }

        setState(() {
          _selectedFile = pickedFile;
        });
        widget.onFileSelected?.call(pickedFile);
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking files: $e")),
      );
    }
  }

  Future<bool> _isAndroid13OrAbove() async {
    try {
      String version = Platform.operatingSystemVersion;
      return version.contains("13");
    } catch (_) {
      return false;
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
    });
    widget.onFileSelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElevatedButton.icon(
              onPressed:() => _pickFile(context),
              icon: const Icon(Icons.attach_file),
              label: const Text("Choose File"),
            ),
            const SizedBox(width: 12),
            if (_selectedFile != null)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedFile!.path.split('/').last,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: _removeFile,
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        if (_error != null)
          Text(
            _error!,
            style: const TextStyle(fontSize: 14, color: Colors.red),
          ),
        const Text(
          "Max size: 10MB | Supported: PDF, DOC, DOCX, JPG, PNG, GIF",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
