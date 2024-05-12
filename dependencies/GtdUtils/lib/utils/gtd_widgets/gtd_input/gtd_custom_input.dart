import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:gtd_utils/helpers/extension/string_extension.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rxdart/rxdart.dart';

import 'gtd_input_msc.dart';

class GtdEmailOrPhoneInput extends StatefulWidget {
  final String formControlName;
  final BehaviorSubject<GtdInputValidation> stream;

  const GtdEmailOrPhoneInput({
    required this.formControlName,
    required this.stream,
    super.key,
  });

  @override
  State<GtdEmailOrPhoneInput> createState() => _GtdEmailOrPhoneInputState();
}

class _GtdEmailOrPhoneInputState extends State<GtdEmailOrPhoneInput> {
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GtdInputValidation>(
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
  }

  String _errorText(GtdInputValidation validation) {
    switch (validation) {
      case GtdInputValidation.valid:
      case GtdInputValidation.notMatched:
        return '';
      case GtdInputValidation.required:
        return 'account.phoneOrEmailError.required'.tr();
      case GtdInputValidation.invalid:
        return 'account.phoneOrEmailError.invalid'.tr();
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
        keyboardType: TextInputType.emailAddress,
        onChanged: (control) {
          setState(() {
            _value = (control.value as String).trim();
          });
          _validateValue();
        },
        focusNode: _focusNode,
        formControlName: widget.formControlName,
        style: GtdInputMsc.inputStyle,
        decoration: InputDecoration(
          label: _focusNode.hasFocus
              ? Text(
            'account.phoneOrEmail'.tr(),
          )
              : Text(
            _value.isNotEmpty
                ? 'account.phoneOrEmail'.tr()
                : 'account.phoneOrEmailHint'.tr(),
          ),
          labelStyle: TextStyle(
            color: GtdColors.slateGrey,
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  _validateValue() {
    if (_value.isNotEmpty) {
      if (_value.isNumeric()) {
        if (_value.isPhoneNumber()) {
          widget.stream.add(GtdInputValidation.valid);
        } else {
          widget.stream.add(GtdInputValidation.invalid);
        }
      } else {
        if (_value.isEmailAddress()) {
          widget.stream.add(GtdInputValidation.valid);
        } else {
          widget.stream.add(GtdInputValidation.invalid);
        }
      }
    } else {
      widget.stream.add(GtdInputValidation.required);
    }
  }
}