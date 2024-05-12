import 'package:flutter/material.dart';

class GtdAppLoading extends StatelessWidget {
  final ValueNotifier<bool> _isLoadingNotifier;
  final Widget child;

  GtdAppLoading({super.key, required this.child}) : _isLoadingNotifier = ValueNotifier(false);

  static GtdAppLoading of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<GtdAppLoading>()!;
  }

  void show() {
    _isLoadingNotifier.value = true;
  }

  void hide() {
    _isLoadingNotifier.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoadingNotifier,
      child: child,
      builder: (context, isLoading, child) {
        return Stack(
          children: [
            child!,
            if (isLoading)
              const Opacity(
                opacity: 0.5,
                child: ModalBarrier(dismissible: false, color: Colors.black),
              ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}

// loading_overlay.dart
// class GtdAppLoading extends StatefulWidget {
//   const GtdAppLoading({Key? key, required this.child}) : super(key: key);

//   final Widget child;

//   static _GtdAppLoadingState of(BuildContext context) {
//     return context.findAncestorStateOfType<_GtdAppLoadingState>()!;
//   }

//   @override
//   State<GtdAppLoading> createState() => _GtdAppLoadingState();
// }

// class _GtdAppLoadingState extends State<GtdAppLoading> {
//   bool _isLoading = false;

//   void show() {
//     setState(() {
//       _isLoading = true;
//     });
//   }

//   void hide() {
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         widget.child,
//         if (_isLoading)
//           const Opacity(
//             opacity: 0.8,
//             child: ModalBarrier(dismissible: false, color: Colors.black),
//           ),
//         if (_isLoading)
//           const Center(
//             child: CircularProgressIndicator(),
//           ),
//       ],
//     );
//   }
// }
