part of '../index.dart';

class TextTile extends StatelessWidget {
  final String text;
  final String value;
  final IconData? icon;
  final Color? fontColor;
  final int? maxLines;

  const TextTile(
      {super.key,
      required this.text,
      required this.value,
      this.maxLines,
      this.icon,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(color: AppColorsConfig.background, fontSize: 12),
              ),
              icon == null
                  ? Container()
                  : Center(
                      child: Icon(
                      icon,
                      color: AppColorsConfig.surface,
                      size: 15,
                    )),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(color: fontColor ?? AppColorsConfig.surface, fontSize: 16),
                  maxLines: maxLines,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
