part of 'index.dart';

class SnackBarUti {
  static void showErorSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: null,
        bottom: MediaQuery.of(context).padding.bottom + 45,
        left: 15,
        right: 15,
        child: Material(
          elevation: 6.0,
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: 51,
            color: Theme.of(context).colorScheme.error,
            child: Center(
              child: Text(
                message,
                style: const TextStyle(color: AppColorsConfig.error),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay
    overlay.insert(overlayEntry);

    // Remove the overlay entry after the specified duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
