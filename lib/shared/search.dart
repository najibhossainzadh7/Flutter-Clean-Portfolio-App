import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/core/constants/color_block.dart';
import 'package:flutter_clean_portfolio_app/core/debouncer.dart';

class Search extends StatefulWidget {
  const Search({
    super.key,
    this.onSearchTap,
    this.onFilterTap,
    this.onSearch,
    this.hasFilter = false,
  });

  final VoidCallback? onSearchTap;
  final VoidCallback? onFilterTap;
  final void Function(String query)? onSearch;
  final bool hasFilter;

  @override
  State<Search> createState() => _SearchAndFilterBarState();
}

class _SearchAndFilterBarState extends State<Search> {
  Debouncer? debouncer;

  @override
  void initState() {
    super.initState();

    if (widget.onSearch != null) {
      debouncer = Debouncer(milliseconds: 600);
    }
  }

  @override
  void dispose() {
    super.dispose();
    debouncer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final hasOnSearch = widget.onSearch != null;
    if (hasOnSearch) {
      assert(
        widget.onSearchTap == null,
        'Cannot provide both onSearch and onSearchTap',
      );
    }
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: widget.onSearchTap,
            child: TextField(
              autofocus: false,

              onChanged: (query) {
                debouncer?.run(() {
                  if (hasOnSearch) widget.onSearch!(query);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: ColorBlock.borderLight,
                    width: 1,
                  ),
                ),
                suffixIcon: const Icon(
                  Icons.search,
                  color: ColorBlock.grey,
                  size: 28,
                ),

                filled: true,
                hintText: 'Search by name...',
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(color: ColorBlock.borderLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(color: ColorBlock.borderLight),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
