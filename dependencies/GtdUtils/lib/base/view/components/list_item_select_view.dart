import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/bloc/cubit/item_select_cubit.dart';
import 'package:gtd_utils/base/view/components/item_select_view.dart';
import 'package:gtd_utils/base/view_model/item_select_vm.dart';

enum ListItemSelectType { single, multi }

class ListItemSelectView<T extends ItemSelectVM> extends StatelessWidget {
  final List<T> viewmodels;
  final Widget? leftIcon;
  final Widget? rightIconUnSelected;
  final Widget? rightIconSelected;
  final ListItemSelectType type;
  final Function(T item)? onSelectItem;
  const ListItemSelectView(
      {super.key,
      required this.viewmodels,
      this.type = ListItemSelectType.single,
      this.onSelectItem,
      this.leftIcon,
      this.rightIconUnSelected,
      this.rightIconSelected});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemSelectCubit(),
      child: BlocBuilder<ItemSelectCubit, ItemSelectState>(
        builder: (contextItem, state) {
          return ListView.builder(
            itemCount: viewmodels.length,
            itemBuilder: (context, index) {
              return ItemSelectView<T>(
                viewModel: viewmodels[index],
                rightIconUnSelected:
                    rightIconUnSelected ?? const Icon(Icons.check_box_outline_blank_rounded),
                rightIconSelected: rightIconSelected ?? const Icon(Icons.check_box),
                onTapItem: (item) {
                  if (type == ListItemSelectType.single) {
                    viewmodels.map((e) => e.isSelected = false).toList();
                  }
                  item.toggle();
                  BlocProvider.of<ItemSelectCubit>(contextItem).rebuildWidget();
                  onSelectItem?.call(item);
                },
              );
            },
          );
        },
      ),
    );
  }
}
