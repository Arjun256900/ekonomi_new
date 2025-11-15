import 'dart:typed_data';
import 'dart:ui';
import 'package:ekonomi_new/bloc/transaction/transaction_bloc.dart';
import 'package:ekonomi_new/bloc/transaction/transaction_event.dart';
import 'package:ekonomi_new/screens/bill_summary_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Enum to manage the selected scan mode
enum ScanMode { product, bill }

class QrCamera extends StatefulWidget {
  // Updated callback to handle a list of images
  final void Function(List<Uint8List>?) onImageSelected;

  const QrCamera({super.key, required this.onImageSelected});

  // Define the primary color from the design
  

  @override
  State<QrCamera> createState() => _QrCameraState();
}

class _QrCameraState extends State<QrCamera> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;

  // State for the new UI
  ScanMode _selectedMode = ScanMode.product;
  final List<Uint8List> _capturedImages = [];

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
        ResolutionPreset.high, // Use higher resolution for better quality
        enableAudio: false,
      );
      await _cameraController!.initialize();
      if (mounted) setState(() {});
    }
  }

  Future<void> _captureFromCamera() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    try {
      final XFile file = await _cameraController!.takePicture();
      final bytes = await file.readAsBytes();
      setState(() {
        // limit to say max 6 thumbnails
        if (_capturedImages.length < 6) _capturedImages.add(bytes);
      });
    } catch (e) {
      debugPrint("Error capturing picture: $e");
    }
  }

  void _onFinish() {
    if (_capturedImages.isEmpty) {
      return;
    }
    Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (context) => BillSummaryScreen()));
    // // Pass the list of captured images back
    // widget.onImageSelected(_capturedImages);

    // // Generate dummy transactions and show the preview list
    // final now = DateTime.now();
    // final time = DateFormat('h a').format(now);
    // final date = DateFormat('MMM d').format(now);

    // final transactions = List.generate(10, (i) {
    //   return {
    //     "debitOrCredit": (i % 2 == 0) ? "Debit" : "Credit",
    //     "amount": (100 * (i + 1)).toString(),
    //     "date": date,
    //     "sourceSelection": "Dummy Source ${i + 1}",
    //     "category": "category",
    //     "filepath": "dummy_path_${i + 1}",
    //     "time": time,
    //   };
    // });

    // _showTransactionList(transactions);
  }

  void _showTransactionList(List<Map<String, dynamic>> transactions) {
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Preview Transactions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 400,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final txn = transactions[index];
                  return ListTile(
                    title: Text("${txn["debitOrCredit"]} - ${txn["amount"]}"),
                    subtitle: Text(
                      "${txn["date"]} ${txn["time"]} | "
                      "${txn["sourceSelection"]} | ${txn["category"]}",
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final bloc = context.read<TransactionBloc>();
                  for (var txn in transactions) {
                    bloc.add(AddTransaction(txn, context));
                  }
                  // Pop twice: once for the dialog, once for the camera screen
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
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
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      // Light gradient background like the design
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEFF8F8), Color(0xFFF3F7F8), Color(0xFFEEF6F5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child:
              (_cameraController != null &&
                  _cameraController!.value.isInitialized)
              ? Stack(
                  children: [
                    // Camera Preview fills the screen behind overlays
                    Positioned.fill(child: CameraPreview(_cameraController!)),

                    // Soft overlay to lower contrast and give teal tint
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              primaryColor.withOpacity(0.06),
                              Colors.transparent,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: const [0.0, 0.6, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Top Toggle Buttons
                    _buildTopToggleButtons(),

                    // Scanner Area and corners
                    _buildScannerOverlay(),

                    // Bottom Controls (thumbnails + buttons)
                    _buildBottomControls(),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  /// Helper to build the top toggle buttons ("Product" and "Bill")
  Widget _buildTopToggleButtons() {
    return Positioned(
      top: 18,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildToggleButton(ScanMode.product, "Product"),
          const SizedBox(width: 16),
          _buildToggleButton(ScanMode.bill, "Bill"),
        ],
      ),
    );
  }

  Widget _buildToggleButton(ScanMode mode, String text) {
    final isSelected = _selectedMode == mode;
    return GestureDetector(
      onTap: () => setState(() => _selectedMode = mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ?Theme.of(context).primaryColor : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Scanner overlay center area and corners
  Widget _buildScannerOverlay() {
    final width = MediaQuery.of(context).size.width * 0.78;
    final height = MediaQuery.of(context).size.height * 0.46;
    return Center(
      child: Container(
        width: width,
        height: height,
        // transparent center, we draw only corners and a subtle inner shadow
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Subtle vignette / rounded inner area (not a full border)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                  child: Container(color: Colors.transparent),
                ),
              ),
            ),
            _buildScannerCorner(Alignment.topLeft),
            _buildScannerCorner(Alignment.topRight),
            _buildScannerCorner(Alignment.bottomLeft),
            _buildScannerCorner(Alignment.bottomRight),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerCorner(Alignment alignment) {
    const double cornerLength = 36.0;
    const double thickness = 4.5;
    final Color cornerColor = Theme.of(context).primaryColor;

    // determine which sides to draw
    final bool top = alignment.y < 0;
    final bool left = alignment.x < 0;
    final bool bottom = alignment.y > 0;
    final bool right = alignment.x > 0;

    return Align(
      alignment: alignment,
      child: Container(
        width: cornerLength,
        height: cornerLength,
        child: Stack(
          children: [
            // horizontal or vertical bars
            if (top)
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: Container(
                  height: thickness,
                  decoration: BoxDecoration(
                    color: cornerColor,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: cornerColor.withOpacity(0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            if (bottom)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: thickness,
                  decoration: BoxDecoration(
                    color: cornerColor,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: cornerColor.withOpacity(0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            if (left)
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: Container(
                  width: thickness,
                  decoration: BoxDecoration(
                    color: cornerColor,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: cornerColor.withOpacity(0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
            if (right)
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  width: thickness,
                  decoration: BoxDecoration(
                    color: cornerColor,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: cornerColor.withOpacity(0.35),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Helper to build the entire bottom section with thumbnails and buttons
  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        // gradient area similar to the screenshot (light to solid white)
        padding: const EdgeInsets.only(top: 16, bottom: 22),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.0),
              Colors.white.withOpacity(0.8),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.15, 0.5],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Six-box thumbnails row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8,
              ),
              child: _buildThumbnailsRow(),
            ),

            const SizedBox(height: 12),

            // Action Buttons row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cancel Button (pill)
                  _buildTextButton("Cancel", () => Navigator.of(context).pop()),

                  // Capture Button (big circle)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _captureFromCamera,
                        child: Container(
                          width: 78,
                          height: 78,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Container(
                              width: 58,
                              height: 58,
                              decoration:  BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Capture",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Finish Button
                  _buildElevatedButton(
                    "Finish",
                    _onFinish,
                    enabled: _capturedImages.isNotEmpty,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildElevatedButton(
    String text,
    VoidCallback onPressed, {
    bool enabled = true,
  }) {
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(0.45),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  /// Build the row of six thumbnail boxes.
  Widget _buildThumbnailsRow() {
    // show exactly six boxes (like the design)
    final boxes = List<Widget>.generate(6, (index) {
      final hasImage = index < _capturedImages.length;
      return GestureDetector(
        onTap: hasImage
            ? () {
                // remove tapped image
                setState(() {
                  _capturedImages.removeAt(index);
                });
              }
            : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 48,
          height: 48,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: hasImage ? Colors.white : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200, width: 1.2),
            boxShadow: hasImage
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: hasImage
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    _capturedImages[index],
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      );
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: boxes),
    );
  }
}
