part of 'index.dart';

/// ImageViewer is a widget for displaying images with customizable properties.
class ImageViewer extends StatelessWidget {

  // Width of the image container
  final double? width;
  // Height of the image container
  final double? height;
  // URL of the image to display
  final String imageUrl;
  // Border radius of the image container
  final BorderRadius? borderRadius;
  // How the image should fit inside the container
  final BoxFit? boxFit;
  // Shape of the image container
  final BoxShape? boxShape;
  // Border properties of the image container
  final BoxBorder? border;

  // Custom image provider
  final ImageProvider? imageProvider;

  const ImageViewer(
      {required this.imageUrl,
      this.width,
      this.height,
      this.borderRadius,
      this.boxFit,
      this.boxShape,
      super.key,
      this.border,
      this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: boxShape ?? BoxShape.rectangle,
        // borderRadius: borderRadius
      ),
      child: 
       ExtendedImage(
        borderRadius: borderRadius,
        shape: boxShape,
        border: border,
        fit: boxFit,
        handleLoadingProgress: false,
        enableLoadState: false,
        width: width?.toDouble(),
        height: height?.toDouble(),
        image: ExtendedResizeImage(
          imageProvider ??
              ExtendedNetworkImageProvider(
                imageUrl,
                cache: true,
              ),
          compressionRatio: 0.5,
          width: width?.toInt(),
          height: height?.toInt(),
        ),
             ),
    );
  }
}
