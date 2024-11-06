part of 'index.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget leading;

  const SharedAppBar({super.key, required this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 44,
      elevation: 5,
      backgroundColor: AppColorsConfig.primary,
      title: Text(
        title,
        style: const TextStyle(color: AppColorsConfig.surface, fontSize: 16, ),
      ),
      leading: leading,

    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
