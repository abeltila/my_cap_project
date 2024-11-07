part of 'index.dart';

/// A custom AppBar widget with a configurable title and leading widget.
///
/// [SharedAppBar] is a stateless widget that implements [PreferredSizeWidget]
/// to allow use as an AppBar with custom [title] and [leading] elements.
class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title displayed in the AppBar.
  final String title;

  /// The leading widget, typically an icon or button, displayed at the start of the AppBar.
  final Widget leading;

  /// Creates a [SharedAppBar] with a specified [title] and [leading] widget.
  const SharedAppBar({super.key, required this.title, required this.leading});

  /// Builds the AppBar with the given title and leading widget.
  ///
  /// The background color is set to [AppColorsConfig.primary],
  /// and the title text color is set to [AppColorsConfig.surface].
  /// [leadingWidth] is set to 44, and [elevation] provides a shadow effect.
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 44,
      elevation: 5,
      backgroundColor: AppColorsConfig.primary,
      title: Text(
        title,
        style: const TextStyle(color: AppColorsConfig.surface, fontSize: 16),
      ),
      leading: leading,
    );
  }

  /// Sets the preferred size of the AppBar to match the standard toolbar height.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
