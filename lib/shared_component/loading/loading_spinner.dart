part of 'index.dart';

/// A customizable circular progress indicator widget.
///
/// [CustomCircularProgressIndicator] allows for specifying the size, stroke width,
/// color, and optional background color for the progress indicator.
class CustomCircularProgressIndicator extends StatelessWidget {
  /// The size (height and width) of the progress indicator. Default is 50.0.
  final double size;

  /// The thickness of the progress indicator stroke. Default is 4.0.
  final double strokeWidth;

  /// The color of the progress indicator. Default is [Colors.blue].
  final Color color;

  /// Optional background color of the progress indicator.
  final Color? backgroundColor;

  /// Creates a [CustomCircularProgressIndicator] with customizable parameters.
  const CustomCircularProgressIndicator({
    super.key,
    this.size = 50.0,
    this.strokeWidth = 4.0,
    this.color = Colors.blue,
    this.backgroundColor,
  });

  /// Builds the widget with a [SizedBox] containing a [CircularProgressIndicator].
  ///
  /// The [CircularProgressIndicator] uses [size] for its height and width, [strokeWidth]
  /// for its thickness, and [color] and [backgroundColor] for visual customization.
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
