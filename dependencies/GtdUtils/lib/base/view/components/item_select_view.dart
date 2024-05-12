import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/bloc/cubit/item_select_cubit.dart';
import 'package:gtd_utils/base/view_model/item_select_vm.dart';

class ItemSelectView<T extends ItemSelectVM> extends StatelessWidget {
  final T viewModel;
  final Widget? leftIcon;
  final Widget? rightIconUnSelected;
  final Widget? rightIconSelected;
  final Function(T item)? onTapItem;
  final Function(T item)? onChanged;
  const ItemSelectView({
    super.key,
    required this.viewModel,
    this.leftIcon,
    this.rightIconUnSelected,
    this.rightIconSelected,
    this.onTapItem,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemSelectCubit(),
      child: BlocBuilder<ItemSelectCubit, ItemSelectState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              if (onTapItem != null) {
                onTapItem?.call(viewModel);
              } else {
                viewModel.toggle();
                BlocProvider.of<ItemSelectCubit>(context).rebuildWidget();
              }
              onChanged?.call(viewModel);
            },
            child: Row(
              children: [
                (leftIcon != null)
                    ? SizedBox(
                        width: 40,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                          child: leftIcon,
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  child: ListTile(
                    title: Text(viewModel.itemTitle),
                    subtitle: viewModel.itemSubTitle.isNotEmpty ? Text(viewModel.itemSubTitle) : null,
                  ),
                ),
                (rightIconUnSelected != null)
                    ? SizedBox(
                        width: 40,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                          child:
                              (!viewModel.isSelected) ? rightIconUnSelected : (rightIconSelected ?? const SizedBox()),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
}
