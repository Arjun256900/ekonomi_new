import 'package:ekonomi_new/background/backGround.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// Define the primary color for reuse
const Color primaryColor = Color.fromRGBO(6, 139, 147, 1);

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  bool _isListening = false;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        // Simulate voice recognition after a short delay
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted && _isListening) {
            setState(() {
              _textController.text = "Show my savings trend this month";
            });
          }
        });
      } else {
        _textController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Background()),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            // The default back button is automatically added
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Voice Chat",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    // Show the animated equalizer when listening
                    child: _isListening
                        ? const VoiceEqualizer()
                        : const SizedBox.shrink(),
                  ),
                ),
                Container(
                  height: 18.0, // Match the Marquee's container height
                  width: 12.0, // The width of the fade effect
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        // Start with the background color (fully opaque)
                        Colors.white,

                        // End with the background color (fully transparent)
                        Colors.white.withAlpha(0),
                      ],
                    ),
                  ),
                ),
                // Text field
                _buildTextField(),
                const SizedBox(height: 30),
                // Microphone/Stop button
                _buildMicButton(),
                const SizedBox(height: 10),
                // Label below the button
                Text(
                  _isListening ? 'Stop' : 'Tap to Speak',
                  style: const TextStyle(fontSize: 16, color: Colors.black54),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: _textController,
      readOnly: true, // Make it non-editable by keyboard
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        color: _isListening ? Colors.black87 : Colors.grey.shade600,
      ),
      decoration: InputDecoration(
        hintText: 'Eg : Ask about your spending, savings, or goals...',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildMicButton() {
    return GestureDetector(
      onTap: _toggleListening,
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: primaryColor, blurRadius: 15, spreadRadius: -5),
          ],
        ),
        child: Icon(
          _isListening ? Icons.stop_rounded : Icons.mic,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

/// A widget that displays an animated voice equalizer.
class VoiceEqualizer extends StatefulWidget {
  const VoiceEqualizer({super.key});

  @override
  State<VoiceEqualizer> createState() => _VoiceEqualizerState();
}

class _VoiceEqualizerState extends State<VoiceEqualizer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;
  final int _barCount = 5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animations = List.generate(_barCount, (index) {
      // Stagger the animation of each bar
      final start = index * 0.1;
      final end = start + 0.5;
      return Tween<double>(begin: 10.0, end: 60.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(_barCount, (index) {
            return Container(
              width: 10,
              height: _animations[index].value,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
            );
          }),
        );
      },
    );
  }
}
