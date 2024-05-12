import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view_model/base_view_model.dart';
import 'package:meta/meta.dart';

class InjectorWidget extends InheritedWidget {
  final BaseViewModel viewModel;
  const InjectorWidget({super.key, required super.child, required this.viewModel});

  static InjectorWidget? of(BuildContext context) {
    InjectorWidget? injectorWidget = context.dependOnInheritedWidgetOfExactType<InjectorWidget>();
    return injectorWidget;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

// abstract class BaseView extends InheritedWidget {
//   final BaseViewModel viewModel;
//   final Builder builder;
//   const BaseView({super.key, required this.builder, required this.viewModel}) : super(child: builder);

//   static T? of<T extends BaseView>(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<T>();
//   }
// }

abstract class BaseView<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;

  const BaseView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return InjectorWidget(
      viewModel: viewModel,
      child: buildWidget(context),
    );
  }

  static BaseViewModel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InjectorWidget>()?.viewModel;
  }

  @mustBeOverridden
  Widget buildWidget(BuildContext context) {
    throw UnimplementedError();
  }
}

class InheritedConstraint extends InheritedWidget {
  const InheritedConstraint({
    super.key,
    required this.constraint,
    required super.child,
  }) : super();

  final BoxConstraints constraint;

  static InheritedConstraint? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedConstraint>();
  }

  @override
  bool updateShouldNotify(covariant InheritedConstraint oldWidget) => constraint != oldWidget.constraint;
}

extension $InheritedConstraint on BuildContext {
  /// Get the constraints provided by parent widget
  BoxConstraints? get constraints => InheritedConstraint.of(this)?.constraint;
}

class ChildUsingInheritedWidget extends StatelessWidget {
  const ChildUsingInheritedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Get the constrains provided by parent widget
    final constraint = context.constraints;
    // MARK: use the constraints as you wish
    return Container(
      color: Colors.green,
      height: constraint?.minHeight,
    );
  }
}

class GtdCardView extends BaseView {
  const GtdCardView({super.key, required super.viewModel});

  @override
  Widget buildWidget(BuildContext context) {
    // MARK: implement viewModelBinding
    throw UnimplementedError();
  }
}

//Example
class GtdBannerCardViewModel extends CardViewModel {
  final String url;
  GtdBannerCardViewModel({required super.width, required super.height, required this.url});
}

class GtdBannerCardView extends GtdCardView {
  const GtdBannerCardView({super.key, required super.viewModel});

  @override
  Widget buildWidget(BuildContext context) {
    // MARK: implement viewModelBinding
    throw UnimplementedError();
  }
}
