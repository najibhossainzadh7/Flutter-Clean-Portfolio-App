import 'package:flutter/material.dart';

import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/constants/extensions.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    super.key,
    required this.hintText,
    this.enabled,
    this.title,
    this.initialValue,
    this.readOnly = false,
    this.textType = TextInputType.text,
    this.onTap,
    this.autovalidateMode,
    this.suffix,
    this.controller,
    this.obscureText = false,
    this.maxLines = 1,
    this.autofocus = false,
    this.onChanged,
    this.validator,
    this.focusNode,
  });
  final bool? enabled;
  final String? Function(String?)? validator;
  final TextInputType textType;
  final String hintText;
  final String? title;
  final String? initialValue;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffix;
  final TextEditingController? controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;
  final int? maxLines;
  final FocusNode? focusNode;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _hideObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title ?? '', style: context.textTheme.bodyMedium),
        const HeightGap(2),
        TextFormField(
          cursorColor: ColorBlock.accent,

          enabled: widget.enabled,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          obscureText: widget.obscureText && _hideObscureText,
          obscuringCharacter: '*',
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          initialValue: widget.initialValue,
          keyboardType: widget.textType,
          autovalidateMode: widget.autovalidateMode,
          maxLines: widget.maxLines,
          autofocus: widget.autofocus,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey.shade600),
            filled: true,
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 32,
              maxWidth: 32,
            ),
            suffixIconColor: ColorBlock.grey,
            suffixIcon:
                widget.obscureText
                    ? GestureDetector(
                      onTap:
                          () => setState(
                            () => _hideObscureText = !_hideObscureText,
                          ),
                      child: Icon(
                        _hideObscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    )
                    : widget.suffix,
          ),
        ),
      ],
    );
  }
}
