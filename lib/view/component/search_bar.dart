import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSubmit;

  const CustomSearchBar({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
      ),
      child: AnimSearchBar(
        width: 100.w,
        textController: searchController,
        onSuffixTap: () {
          searchController.clear();
        },
        onSubmitted: onSubmit,
      ),
    );
  }
}
