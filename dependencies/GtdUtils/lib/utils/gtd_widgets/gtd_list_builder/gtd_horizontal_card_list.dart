import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view_model/base_view_model.dart';

class GtdHorizontalCardList extends StatelessWidget {
  final Widget cardWidget;
  final List<CardViewModel> cardViewModels;
  final EdgeInsets listPadding;
  final double contentHeight;
  final Widget? divider;

  const GtdHorizontalCardList({
    Key? key,
    required this.cardWidget,
    required this.cardViewModels,
    this.contentHeight = 100,
    this.listPadding = const EdgeInsets.all(8),
    this.divider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: contentHeight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cardViewModels.length,
          itemBuilder: (context, index) {
            // Implement binding with cardViewModel late
            return cardWidget;
            // return const SizedBox(
            //   width: 100,
            //   child: Card(
            //     child: Text("Data"),
            //   ),
            // );
          },
        ),
      ),
    );
  }

  Widget addDivider() => divider ?? const Padding(padding: EdgeInsets.symmetric(horizontal: 8));
}
