import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_tap_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

import 'gtd_input_msc.dart';

class GtdPasswordInput extends StatefulWidget {
  final String formControlName;
  final String label;
  final BehaviorSubject<GtdInputValidation> stream;
  final BehaviorSubject<Map<String, String>>? matchStream;

  const GtdPasswordInput({
    required this.formControlName,
    required this.label,
    required this.stream,
    this.matchStream,
    super.key,
  });

  @override
  State<GtdPasswordInput> createState() => _GtdPasswordInputState();
}

class _GtdPasswordInputState extends State<GtdPasswordInput> {
  bool _obscured = true;
  late final FocusNode _focusNode;
  String _value = '';

  @override
  void initState() {
    _focusNode = FocusNode(debugLabel: widget.formControlName);
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.stream.close();
    super.dispose();
  }

  Widget _buildMatchInput({required Widget child}) {
    return StreamBuilder(
      stream: widget.matchStream?.skip(1),
      builder: (context, snapshot) {
        _validateValue();
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final child = StreamBuilder<GtdInputValidation>(
      stream: widget.stream.skip(1),
      builder: (context, snapshot) {
        GtdInputValidation? validation;
        if (snapshot.hasData) {
          validation = snapshot.data;
        }
        return Column(
          children: [
            _buildInput(validation),
            if (validation != null && validation != GtdInputValidation.valid)
              _buildError(validation),
          ],
        );
      },
    );
    if (widget.matchStream != null) {
      return _buildMatchInput(child: child);
    }
    return child;
  }

  String _errorText(GtdInputValidation validation) {
    switch (validation) {
      case GtdInputValidation.valid:
        return '';
      case GtdInputValidation.required:
        return 'account.passwordError.required'.tr();
      case GtdInputValidation.invalid:
        return 'account.passwordError.invalid'.tr();
      case GtdInputValidation.notMatched:
        return 'account.passwordError.notMatched'.tr();
    }
  }

  Widget _buildError(GtdInputValidation? validation) {
    if (validation == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
      child: Row(
        children: [
          GtdImage.svgFromSupplier(assetName: 'assets/icons/info-red.svg'),
          const SizedBox(width: 6),
          Text(
            _errorText(validation),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GtdInputMsc.errorStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildInput(GtdInputValidation? validation) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: validation == null || validation == GtdInputValidation.valid
          ? GtdInputMsc.inputDecoration
          : GtdInputMsc.inputErrorDecoration,
      child: ReactiveTextField(
        onChanged: (control) {
          setState(() {
            _value = (control.value as String).trim();
            if (widget.matchStream != null) {
              final matchData = widget.matchStream!.value;
              matchData[widget.formControlName] = _value;
              widget.matchStream?.add(matchData);
            }
          });
          _validateValue();
        },
        focusNode: _focusNode,
        formControlName: widget.formControlName,
        style: GtdInputMsc.inputStyle,
        obscureText: _obscured,
        decoration: InputDecoration(
          label: Text(widget.label),
          labelStyle: TextStyle(
            color: GtdColors.slateGrey,
            fontSize: 16,
          ),
          border: InputBorder.none,
          suffixIconConstraints: const BoxConstraints(
            maxWidth: 40,
            maxHeight: 40,
          ),
          suffixIcon: GtdTapWidget(
            onTap: () {
              setState(() {
                _obscured = !_obscured;
              });
            },
            child: GtdImage.svgFromSupplier(
              assetName: _obscured
                  ? 'assets/icons/password-hide.svg'
                  : 'assets/icons/password-show.svg',
            ),
          ),
        ),
      ),
    );
  }

  _validateValue() {
    if (_value.isNotEmpty) {
      if (_value.length >= 8) {
        if (widget.matchStream != null) {
          bool matched = true;
          for (var entry in widget.matchStream!.value.entries) {
            if (entry.value != _value) {
              matched = false;
              break;
            }
          }
          if (matched) {
            widget.stream.add(GtdInputValidation.valid);
          } else {
            widget.stream.add(GtdInputValidation.notMatched);
          }
        } else {
          widget.stream.add(GtdInputValidation.valid);
        }
      } else {
        widget.stream.add(GtdInputValidation.invalid);
      }
    } else {
      widget.stream.add(GtdInputValidation.required);
    }
  }
}
