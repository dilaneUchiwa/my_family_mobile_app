import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.assetIcon, {
    super.key,
    this.color,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetIcon;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetIcon,
      height: height,
      width: width,
      colorFilter:
      color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      fit: fit,
    );
  }
}
