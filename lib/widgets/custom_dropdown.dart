import 'package:flutter/material.dart';

class CustomDropdown<T> extends FormField<T> {
  CustomDropdown({
    Key? key,
    required List<T> items,
    required T? selected,
    required ValueChanged<T> onChanged,
    required String Function(T) itemLabel,
    String hint = "Select an item",
    FormFieldValidator<T>? validator,
    bool enabled = true,
    // ✅ Only color customization
    Color? dropdownColor,
    Color? borderColor,
    Color? textColor,
    Color? hintColor,
    Color? iconColor,
  }) : super(
    key: key,
    initialValue: selected,
    validator: validator,
    enabled: enabled,
    builder: (FormFieldState<T> state) {
      final _layerLink = LayerLink();
      OverlayEntry? _overlayEntry;
      bool _isOpen = false;

      void _closeDropdown() {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _isOpen = false;
      }

      OverlayEntry _createOverlay(BuildContext context, Size size) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset offset = renderBox.localToGlobal(Offset.zero);
        final screenHeight = MediaQuery.of(context).size.height;

        const double verticalGap = 0;
        const double dropdownMaxHeight = 250;

        // Calculate available space
        final spaceBelow = screenHeight - offset.dy - size.height;
        final spaceAbove = offset.dy;

        final bool showAbove = spaceBelow < dropdownMaxHeight && spaceAbove > dropdownMaxHeight;

        return OverlayEntry(
          builder: (context) => Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: showAbove
                  ? Offset(0.0, -dropdownMaxHeight - verticalGap)
                  : Offset(0.0, size.height + verticalGap),
              showWhenUnlinked: false,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                color: dropdownColor ?? Theme.of(context).cardColor,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: dropdownMaxHeight),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(
                          itemLabel(item),
                          style: TextStyle(
                            color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        onTap: () {
                          onChanged(item);
                          state.didChange(item);
                          _closeDropdown();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }

      return CompositedTransformTarget(
        link: _layerLink,
        child: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                if (_isOpen) {
                  _closeDropdown();
                } else {
                  final box = context.findRenderObject() as RenderBox;
                  final size = box.size;

                  _overlayEntry = _createOverlay(context, size);
                  Overlay.of(context).insert(_overlayEntry!);
                  _isOpen = true;
                }
              },
              child: InputDecorator(
                isEmpty: state.value == null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 14, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: borderColor ?? Colors.grey,
                    ),
                  ),
                  errorText: state.errorText,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.value != null
                          ? itemLabel(state.value as T)
                          : hint,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: state.value == null
                            ? hintColor ?? Colors.grey
                            : textColor ?? Colors.black,
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: iconColor ?? Colors.black,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
