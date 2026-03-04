
import 'package:danceattix/core/app_constants/app_colors.dart';
import 'package:danceattix/global/custom_assets/assets.gen.dart';
import 'package:danceattix/views/widgets/custom_container.dart';
import 'package:danceattix/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RangeSliderScreen extends StatefulWidget {
  const RangeSliderScreen({super.key, this.onRangeChanged});

  final void Function(RangeValues)? onRangeChanged;


  @override
  State<RangeSliderScreen> createState() => _RangeSliderScreenState();
}



class _RangeSliderScreenState extends State<RangeSliderScreen> {
  RangeValues _currentRangeValues = const RangeValues(100, 1000);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final trackWidth = constraints.maxWidth;
          const min = 10.0;
          const max = 4000.0;

          final startX =
              (_currentRangeValues.start - min) / (max - min) * trackWidth;
          final endX =
              (_currentRangeValues.end - min) / (max - min) * trackWidth;

          // Base horizontal positions
          double startLabelX = (startX - 30.w).clamp(0, trackWidth - 60.w);
          double endLabelX = (endX - 30.w).clamp(0, trackWidth - 60.w);

           double minLabelGap = 130.w;

          // Overlap handling
          if ((endLabelX - startLabelX) < minLabelGap) {
            final overlap = minLabelGap - (endLabelX - startLabelX);

            if (_currentRangeValues.start <= _currentRangeValues.end) {
              // Left-to-right: move start left, end right stays
              startLabelX = (startLabelX - overlap / 2).clamp(0, trackWidth - 60.w);
              endLabelX = (endLabelX + overlap / 2).clamp(0, trackWidth - 60.w);
            } else {
              // Right-to-left: move end right, start left stays
              startLabelX = (startLabelX - overlap / 2).clamp(0, trackWidth - 60.w);
              endLabelX = (endLabelX + overlap / 2).clamp(0, trackWidth - 60.w);
            }
          }


          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Start label
              Positioned(
                top: 0,
                left: startLabelX,
                child: _buildLabel(_currentRangeValues.start.round()),
              ),

              // End label
              Positioned(
                top: 0,
                left: endLabelX,
                child: _buildLabel(_currentRangeValues.end.round()),
              ),

              // Slider
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 8.h,
                    activeTrackColor: AppColors.primaryColor,
                    inactiveTrackColor: AppColors.borderColor,
                    thumbColor: AppColors.primaryColor,
                    rangeThumbShape: const CustomRangeThumbShape(),
                  ),
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: min,
                    max: max,
                    onChanged: (RangeValues values) {
                      setState(() => _currentRangeValues = values);

                      // Notify parent
                      if (widget.onRangeChanged != null) {
                        widget.onRangeChanged!(values);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLabel(int value) {
    return CustomContainer(
      width: 60.w,
      alignment: Alignment.center,
      //paddingHorizontal: 10.w,
      paddingVertical: 6.h,
      radiusAll: 8.r,
      bordersColor: AppColors.primaryColor,
      child: CustomText(
        text: '${value.toString()} \$',
        fontSize: 10.sp,
        right: 2.w,
      ),
    );
  }
}







class CustomRangeThumbShape extends RangeSliderThumbShape {
  const CustomRangeThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(32, 32);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    // Pink thumb

    final thumbPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.pink
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 12, thumbPaint);

    // Outer black ring
    final outerPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 8, outerPaint);
  }
}
