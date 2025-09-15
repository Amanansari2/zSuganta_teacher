import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/accounts/teaching_information_provider.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/theme/provider/theme_provider.dart';

class SubjectsSelectionContainer extends StatefulWidget {
  const SubjectsSelectionContainer({super.key});

  @override
  State<SubjectsSelectionContainer> createState() =>
      _SubjectsSelectionContainerState();
}

class _SubjectsSelectionContainerState extends State<SubjectsSelectionContainer> {
  String searchQuery = '';
  bool showOptions = false;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus) {
        setState(() {
          showOptions = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TeachingInformationProvider>();
    final dark = context.watch<ThemeProvider>().isDarkMode;

    final filteredSubjects = searchQuery.isEmpty
        ? provider.subjectOption
        : provider.subjectOption
              .where(
                (s) => s.name.toLowerCase().contains(searchQuery.toLowerCase()),
              )
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Subjects",
          style: TextStyle(
            fontSize: Sizes.fontSizeLg,
            fontWeight: FontWeight.w600,
            color: dark ? AppColors.white : AppColors.black,
          ),
        ),
        const SizedBox(height: Sizes.spaceBtwItems),


        TextField(
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: "Search subjects...",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          onTap: () {
            setState(() {
              showOptions = true;
            });
          },
        ),

        const SizedBox(height: Sizes.spaceBtwItems),

        if (provider.selectedSubjects.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: provider.selectedSubjects.map((subject) {
              return Chip(
                label: Text(subject.name),
                backgroundColor: dark ? AppColors.blue : AppColors.orange,
                labelStyle: const TextStyle(color: Colors.white),
                onDeleted: () => provider.setSelectedSubject(subject),
              );
            }).toList(),
          ),

        const SizedBox(height: Sizes.spaceBtwItems),

        if (showOptions)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredSubjects.isEmpty
                ? Container(
              decoration: BoxDecoration(
                color: dark ? AppColors.darkGrey : Colors.white,
                border: Border.all(
                  color: dark ? AppColors.blue : AppColors.orange,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
                  child: Center(
                      child: Text(
                        "No subjects found",
                        style: TextStyle(
                          fontSize: Sizes.fontSizeLg,
                          fontWeight: FontWeight.w600,
                          color: dark ? AppColors.white : AppColors.black,
                        ),
                      ),
                    ),
                )
                : Container(
                    decoration: BoxDecoration(
                      color: dark ? AppColors.darkGrey : Colors.white,
                      border: Border.all(
                        color: dark ? AppColors.blue : AppColors.orange,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: filteredSubjects.length,
                        itemBuilder: (context, index) {
                          final subject = filteredSubjects[index];
                          final isSelected = provider.selectedSubjects.contains(
                            subject,
                          );

                          return ListTile(
                            title: Text(
                              subject.name,
                              style: TextStyle(
                                color: dark ? Colors.white : Colors.black,
                              ),
                            ),
                            trailing: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: dark
                                        ? AppColors.blue
                                        : AppColors.orange,
                                  )
                                : null,
                            onTap: () => provider.setSelectedSubject(subject),
                          );
                        },
                      ),
                    ),
                  ),
          ),
      ],
    );
  }
}
