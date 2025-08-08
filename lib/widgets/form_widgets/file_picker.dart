import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerWidget extends StatelessWidget {
  final String subtext;
  final Function(String) onFilePicked;
  final String filepath;

  const FilePickerWidget({
    super.key,
    required this.subtext,
    required this.onFilePicked,
    required this.filepath,
  });

  void _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      onFilePicked(result.files.single.path!);
    } else {
      debugPrint("No file selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = filepath.isNotEmpty ? filepath.split('/').last : '';

    return InkWell(
      onTap: () => _pickFile(context),
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(8),
          strokeWidth: 1.5,
          dashPattern: [6, 6],
          color: const Color.fromRGBO(0, 0, 0, 0.45),
        ),
        child: Container(
          height: 105,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    fileName.isNotEmpty ? Icons.done : Icons.upload,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  fileName.isNotEmpty ? fileName : subtext,
                  style:  TextStyle(fontSize: 14,color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
