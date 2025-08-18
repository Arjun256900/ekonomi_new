import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class QrCamera extends StatefulWidget {
  final void Function(Uint8List?) onImageSelected;

  const QrCamera({super.key, required this.onImageSelected});

  @override
  _QrCameraState createState() => _QrCameraState();
}

class _QrCameraState extends State<QrCamera> {
  CameraController? _cameraController;
  Uint8List? _selectedImage;
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
  void _showPreview(Uint8List bytes) {
    setState(() {
      _selectedImage = bytes;
    });

    showDialog(
      context: context,
      barrierDismissible: false, // force user to choose
      builder: (_) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(child: Image.memory(bytes, fit: BoxFit.contain)),
            // Buttons
            Positioned(
              bottom: 20,
              left: 20,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.red, size: 40),
                onPressed: () {
                  Navigator.of(context).pop(); // cancel
                },
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.check_circle, color: Colors.green, size: 40),
                onPressed: () {
                  widget.onImageSelected(bytes); // send to backend
                  Navigator.of(context).pop();
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
