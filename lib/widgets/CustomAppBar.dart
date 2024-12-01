import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // final Widget? leading;
  final Widget text;
  // final Widget? action;
  const CustomAppBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: AppBar(
          // leading: leading!,
          title: text,
          centerTitle: true,
          // actions: [action!],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
        double.maxFinite,
        70,
      );
}
