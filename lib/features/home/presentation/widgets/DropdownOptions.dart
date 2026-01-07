
import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/shared/spacer.dart';

class DropdownOptions extends StatefulWidget {
  final List<String> items;
  final String? hintText;
  final ValueChanged<String> onChanged;
  final String? selectedValue;
  final Widget? title;

  const DropdownOptions({
    this.title,
    this.hintText,
    required this.items,
    required this.onChanged,
    this.selectedValue,
    super.key,
  });

  @override
  State<DropdownOptions> createState() => _DropdownOptionsState();
}

class _DropdownOptionsState extends State<DropdownOptions> {
  late String? selectedValue = widget.selectedValue != null && widget.items.contains(widget.selectedValue)
      ? widget.selectedValue
      : null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) widget.title!,
        const HeightGap(8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                widget.hintText ?? '',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              value: selectedValue,
              icon: const Icon(Icons.keyboard_arrow_down),
              isExpanded: true,
              items: widget.items
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (val) {
                setState(() => selectedValue = val);
                if (val != null) widget.onChanged(val);
              },
            ),
          ),
        ),
      ],
    );
  }
}
