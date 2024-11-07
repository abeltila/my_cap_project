part of 'index.dart';

/// Utility class for displaying custom snack bars.
class SnackBarUti {
  /// Displays an error snack bar with a rounded design at the bottom of the screen.
  ///
  /// [context] is used to access the overlay and theme properties.
  /// [message] is the error message to display.
  /// [duration] specifies how long the snack bar remains visible (default is 3 seconds).
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

    // Insert the overlay entry into the overlay.
    overlay.insert(overlayEntry);

    // Remove the overlay entry after the specified duration.
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }
}
