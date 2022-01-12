import 'package:car_rental/widgets/build_snack_error.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final List<Color> backColors;

  final List<Color> textColors;
  final TapDebouncerFunc onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final Duration cooldown;
  const ButtonWidget({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.backColors,
    required this.textColors,
    required this.onPressed,
    required this.borderRadius,
    required this.cooldown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Shader textGradient = LinearGradient(
      colors: <Color>[textColors[0], textColors[1]],
    ).createShader(
      const Rect.fromLTWH(
        0.0,
        0.0,
        200.0,
        70.0,
      ),
    );
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: height,
      width: width,
      child: TapDebouncer(
        cooldown: cooldown,
        onTap: onPressed,
        waitBuilder: (context, child) {
          return InkWell(
            onTap: () {
              buildSnackError(
                  'Please wait ${cooldown.inSeconds} seconds', context, size);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  stops: const [
                    0.4,
                    2,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: backColors,
                ),
              ),
              child: Align(
                child: Text(
                  text,
                  style: GoogleFonts.lato(
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = textGradient,
                  ),
                ),
              ),
            ),
          );
        },
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                gradient: LinearGradient(
                  stops: const [
                    0.4,
                    2,
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: backColors,
                ),
              ),
              child: Align(
                child: Text(
                  text,
                  style: GoogleFonts.lato(
                    fontSize: size.height * 0.025,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = textGradient,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
