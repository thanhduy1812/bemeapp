// import 'package:flutter/material.dart';
//
// class GtdAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final List<Widget>? actions;
//   final bool showBack;
//   final VoidCallback? onBack;
//
//   const GtdAppBar({
//     required this.title,
//     this.actions,
//     this.showBack = true,
//     this.onBack,
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       automaticallyImplyLeading: false,
//       leading: CupertinoButton(
//         padding: EdgeInsets.zero,
//         onPressed: onBack ?? () => Navigator.of(context).maybePop(),
//         child: SvgPicture.asset(OhReySVGIcons.arrowLeft),
//       ),
//       title: titleWidget ??
//           Text(
//             title,
//             style: context.tt.titleMedium,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//       actions: actions,
//     );
//     return const Placeholder();
//   }
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }
