import 'dart:typed_data';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ekonomi_new/bloc/AddNewTransaction/transaction_list_event.dart';

class QrCamera extends StatefulWidget {
  final void Function(Uint8List?) onImageSelected;

  const QrCamera({super.key, required this.onImageSelected});

  @override
  _QrCameraState createState() => _QrCameraState();
}

class _QrCameraState extends State<QrCamera> {
  CameraController? _cameraController;
  // Uint8List? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras!.first,
        ResolutionPreset.medium,
      );
      await _cameraController!.initialize();
      if (mounted) setState(() {});
    }
  }

  // Capture from camera
  Future<void> _captureFromCamera() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    final XFile file = await _cameraController!.takePicture();
    final bytes = await file.readAsBytes();
    _showPreview(bytes);
  }

  // Pick from gallery
  Future<void> _pickFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      _showPreview(bytes);
    }
  }

  // Show preview overlay
  // Add at top of file:
  // import 'package:flutter_bloc/flutter_bloc.dart';
  // import 'package:ekonomi_new/bloc/transaction/transaction_event.dart';

  void _showPreview(Uint8List bytes) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          Center(child: Image.memory(bytes, fit: BoxFit.contain)),

          // Cancel button
          Positioned(
            bottom: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.red, size: 40),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),

          // Confirm button
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.check_circle,
                  color: Colors.green, size: 40),
              onPressed: () {
                widget.onImageSelected(bytes);

                final now = DateTime.now();
                final time = DateFormat('h a').format(now);
                final date = DateFormat('MMM d').format(now);

                final transactions = List.generate(10, (i) {
                  return {
                    "debitOrCredit": (i % 2 == 0) ? "Debit" : "Credit",
                    "amount": (100 * (i + 1)).toString(),
                    "date": date,
                    "sourceSelection": "Dummy Source ${i + 1}",
                    "category": "Dummy Category",
                    "filepath": "dummy_path_${i + 1}",
                    "time": time,
                  };
                });

                Navigator.of(context).pop(); // close image preview dialog

                // Show transaction list in another dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Preview Transactions",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 400, // scrollable area
                          width: double.maxFinite,
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final txn = transactions[index];
                              return ListTile(
                                title: Text(
                                  "${txn["debitOrCredit"]} - ${txn["amount"]}",
                                ),
                                subtitle: Text(
                                  "${txn["date"]} ${txn["time"]} | "
                                  "${txn["sourceSelection"]} | "
                                  "${txn["category"]}",
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              final bloc =
                                  context.read<TransactionListBloc>();
                              for (var txn in transactions) {
                                bloc.add(AddTransactionEvent(txn));
                              }
                              Navigator.of(context).pop(); // close preview
                            },
                            child: const Text("OK"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameraController != null && _cameraController!.value.isInitialized
          ? Stack(
              children: [
                // Fullscreen camera preview (mirror style)
                Positioned.fill(child: CameraPreview(_cameraController!)),

                // Buttons overlay
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Gallery button (bottom left)
                        IconButton(
                          icon: const Icon(
                            Icons.photo_library,
                            color: Colors.white,
                          ),
                          iconSize: 40,
                          onPressed: _pickFromGallery,
                        ),

                        // Camera button (bottom center)
                        IconButton(
                          icon: const Icon(Icons.camera, color: Colors.white),
                          iconSize: 70,
                          onPressed: _captureFromCamera,
                        ),

                        // Placeholder for spacing
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
