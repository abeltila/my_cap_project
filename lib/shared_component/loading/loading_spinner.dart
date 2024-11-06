part of 'index.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color color;
  final Color? backgroundColor;

  const CustomCircularProgressIndicator({
    super.key,
    this.size = 50.0,
    this.strokeWidth = 4.0,
    this.color = Colors.blue,
    this.backgroundColor,
  });

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
