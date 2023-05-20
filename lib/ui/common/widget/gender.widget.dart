import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenderWidget extends StatelessWidget {
  final bool isMale;
  final double? width;
  final double? height;

  const GenderWidget({
    Key? key,
    required this.isMale,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final path = isMale ? "assets/svg/male.svg" : "assets/svg/female.svg";
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
    );
  }
}
