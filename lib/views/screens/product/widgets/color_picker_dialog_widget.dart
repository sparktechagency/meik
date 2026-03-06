import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  final File file;

  const ColorPickerDialog({super.key, required this.file});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  final GlobalKey _imageKey = GlobalKey();

  Offset _pointerPosition = const Offset(0, 0);
  Color _currentColor = Colors.transparent;
  bool _isDragging = false;

  // decoded image cache
  ui.Image? _uiImage;
  List<int>? _rgbaBytes;
  int? _imageWidth;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final bytes = await widget.file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;
    final byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);

    if (byteData != null) {
      setState(() {
        _uiImage = image;
        _rgbaBytes = byteData.buffer.asUint8List();
        _imageWidth = image.width;
      });
    }
  }

  Color _colorAtPosition(Offset localPos, Size widgetSize) {
    if (_rgbaBytes == null || _uiImage == null || _imageWidth == null) {
      return Colors.transparent;
    }

    final double scaleX = _uiImage!.width / widgetSize.width;
    final double scaleY = _uiImage!.height / widgetSize.height;

    final int px = (localPos.dx * scaleX).clamp(0, _uiImage!.width - 1).toInt();
    final int py = (localPos.dy * scaleY).clamp(0, _uiImage!.height - 1).toInt();

    final int offset = (py * _imageWidth! + px) * 4;
    final r = _rgbaBytes![offset];
    final g = _rgbaBytes![offset + 1];
    final b = _rgbaBytes![offset + 2];
    final a = _rgbaBytes![offset + 3];

    return Color.fromARGB(a, r, g, b);
  }

  void _handlePointer(Offset globalPos) {
    final RenderBox? box = _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;

    final localPos = box.globalToLocal(globalPos);
    final size = box.size;

    final clampedPos = Offset(
      localPos.dx.clamp(0, size.width),
      localPos.dy.clamp(0, size.height),
    );

    final color = _colorAtPosition(clampedPos, size);
    setState(() {
      _pointerPosition = clampedPos;
      _currentColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hex = _currentColor.alpha == 0
        ? '------'
        : '#${_currentColor.value.toRadixString(16).substring(2).toUpperCase()}';

    return Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          children: [
            // ─── Top Bar ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Tap & drag to pick color',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  // Confirm button — color pick হলে দেখাবে
                  if (_isDragging == false && _currentColor.alpha != 0)
                    GestureDetector(
                      onTap: () => Navigator.pop(context, _currentColor),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _currentColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Text(
                          hex,
                          style: TextStyle(
                            color: _currentColor.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // ─── Image Area ───────────────────────────────────
            Expanded(
              child: Listener(
                onPointerDown: (event) {
                  setState(() => _isDragging = true);
                  _handlePointer(event.position);
                },
                onPointerMove: (event) {
                  _handlePointer(event.position);
                },
                onPointerUp: (event) {
                  setState(() => _isDragging = false);
                  _handlePointer(event.position);
                },
                child: Stack(
                  children: [
                    // Image
                    Positioned.fill(
                      child: Image.file(
                        key: _imageKey,
                        widget.file,
                        fit: BoxFit.contain,
                      ),
                    ),

                    // Magnifier + crosshair — drag এর সময় দেখাবে
                    if (_isDragging && _uiImage != null)
                      _buildMagnifier(),
                  ],
                ),
              ),
            ),

            // ─── Bottom Color Info ────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: Colors.black,
              child: Row(
                children: [
                  // Color preview circle
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _currentColor.alpha == 0 ? Colors.grey.shade800 : _currentColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30, width: 1.5),
                      boxShadow: _currentColor.alpha == 0
                          ? []
                          : [
                        BoxShadow(
                          color: _currentColor.withOpacity(0.5),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hex,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _currentColor.alpha == 0
                            ? 'Tap on image'
                            : 'R: ${_currentColor.red}   G: ${_currentColor.green}   B: ${_currentColor.blue}',
                        style: const TextStyle(color: Colors.white54, fontSize: 13),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (_currentColor.alpha != 0)
                    GestureDetector(
                      onTap: () => Navigator.pop(context, _currentColor),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, color: Colors.black, size: 22),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Magnifier Widget ─────────────────────────────────────
  Widget _buildMagnifier() {
    const double magnifierSize = 120;
    const double magnifierScale = 2.5;
    const double crosshairSize = 20;

    // magnifier টা pointer এর উপরে দেখাবে
    final double left = _pointerPosition.dx - magnifierSize / 2;
    final double top = _pointerPosition.dy - magnifierSize - 30;

    return Positioned(
      left: left.clamp(0, MediaQuery.of(context).size.width - magnifierSize),
      top: top < 0 ? _pointerPosition.dy + 30 : top,
      child: Container(
        width: magnifierSize,
        height: magnifierSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: _currentColor, width: 4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
            ),
          ],
        ),
        child: ClipOval(
          child: OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: Transform.scale(
              scale: magnifierScale,
              child: Transform.translate(
                offset: Offset(
                  -(_pointerPosition.dx - magnifierSize / 2),
                  -(_pointerPosition.dy - magnifierSize / 2),
                ),
                child: Image.file(
                  widget.file,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}