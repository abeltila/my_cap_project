part of './index.dart';

/// A widget for displaying SVG icons.
///
/// This widget takes an [icon] name (without the ".svg" extension) and
/// optional parameters for [color], [height], and [width].

class SvgIcon extends StatelessWidget {
   /// The name of the SVG icon file (without the ".svg" extension).
   /// 
   /// The [icon] parameter is required.
  final String icon;

  /// The color of the icon. If null, the default icon color will be used.
  final Color? color;

  /// The height of the icon. If null, the default icon height will be used.
  final double? height;

  /// The width of the icon. If null, the default icon width will be used.
  final double? width;

  const SvgIcon({
    super.key,
    required this.icon,
    this.color,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/$icon',
      colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
      height: height,
      width: width,
    );
  }
}
