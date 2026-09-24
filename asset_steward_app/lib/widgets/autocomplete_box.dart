import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:material_ui/material_ui.dart';

class AutocompleteFormBox<T> extends FormBuilderField<T> {
  AutocompleteFormBox({
    super.key,
    required super.name,
    String? placeholder,
    String? label,
    required List<T> items,
    required String Function(T item) itemLabel,
    ValueChanged<T?>? onChanged,
    super.validator,
    super.initialValue,
    super.enabled,
    Widget? suffix,
    bool isRequired = false,
    super.valueTransformer,
  }) : super(
         builder: (field) {
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               AutocompleteBox<T>(
                 placeholder: placeholder,
                 label: label,
                 value: field.value,
                 items: items,
                 itemLabel: itemLabel,
                 suffix: suffix,
                 isRequired: isRequired,
                 onQueryChanged: (query) {
                   final selectedValue = field.value;
                   if (selectedValue == null) return;
                   if (query.trim() == itemLabel(selectedValue)) return;
                   field.didChange(null);
                   onChanged?.call(null);
                 },
                 onChanged: (value) {
                   field.didChange(value);
                   onChanged?.call(value);
                 },
               ),

               if (field.hasError) ...[
                 const SizedBox(height: 6),
                 Text(
                   field.errorText ?? '',
                   style: field.context.text.bodySmall?.textColor(field.context.colors.error),
                 ),
               ],
             ],
           );
         },
       );
}

class AutocompleteBox<T> extends StatefulWidget {
  const AutocompleteBox({
    super.key,
    this.placeholder,
    this.label,
    required this.items,
    required this.itemLabel,
    this.itemTextValue,
    this.value,
    this.onChanged,
    this.onQueryChanged,
    this.maxVisibleItems = 6,
    this.controller,
    this.focusNode,
    this.hideOnEmpty = false,
    this.itemBuilder,
    this.suffix,
    this.isRequired = false,
    this.enabled = true,
  });

  final String? placeholder;
  final String? label;
  final List<T> items;
  final String Function(T item) itemLabel;
  final String Function(T item)? itemTextValue;
  final T? value;
  final ValueChanged<T>? onChanged;
  final ValueChanged<String>? onQueryChanged;
  final int maxVisibleItems;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool hideOnEmpty;
  final Widget Function(BuildContext context, T item)? itemBuilder;
  final Widget? suffix;
  final bool isRequired;
  final bool enabled;

  @override
  State<AutocompleteBox<T>> createState() => _AutocompleteBoxState<T>();
}

class _AutocompleteBoxState<T> extends State<AutocompleteBox<T>> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: _labelForValue(widget.value));
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(AutocompleteBox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value && !_focusNode.hasFocus) {
      final nextText = _labelForValue(widget.value);
      if (_controller.text != nextText) {
        _controller.text = nextText;
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  String _labelForValue(T? value) {
    if (value == null) return '';
    return widget.itemTextValue?.call(value) ?? widget.itemLabel(value);
  }

  void _onTextChanged() {
    widget.onQueryChanged?.call(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return TypeAheadField<T>(
      controller: _controller,
      focusNode: _focusNode,
      animationDuration: Duration.zero,
      debounceDuration: Duration.zero,
      hideOnEmpty: widget.hideOnEmpty,
      transitionBuilder: (context, animation, child) => child,
      builder: (context, controller, focusNode) {
        return InputField(
          controller: controller,
          focusNode: focusNode,
          hintText: widget.placeholder,
          title: widget.label,
          onChanged: (_) {},
          isRequired: widget.isRequired,
          outsideSuffix: widget.suffix,
          readOnly: !widget.enabled,
        );
      },
      itemBuilder: (context, item) {
        if (widget.itemBuilder != null) return widget.itemBuilder!(context, item);
        return _AutocompleteItem(label: widget.itemLabel(item), selected: item == widget.value, colors: colors);
      },
      onSelected: (item) {
        final newText = widget.itemTextValue?.call(item) ?? widget.itemLabel(item);
        _controller.text = newText;
        _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
        widget.onChanged?.call(item);
        _focusNode.unfocus();
      },
      suggestionsCallback: (pattern) {
        final needle = pattern.trim().toLowerCase();
        if (needle.isEmpty) return widget.items.take(widget.maxVisibleItems).toList();

        return widget.items
            .where((item) => widget.itemLabel(item).toLowerCase().contains(needle))
            .take(widget.maxVisibleItems)
            .toList();
      },
      emptyBuilder: (context) {
        return Container(
          height: 48,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          color: colors.surface,
          child: Text('No matches', style: context.text.bodyMedium?.textColor(colors.onSurfaceVariant)),
        );
      },
      decorationBuilder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.outlineVariant),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(borderRadius: BorderRadius.circular(12.0), child: child),
        );
      },
      offset: const Offset(0, 4),
    );
  }
}

class _AutocompleteItem extends StatefulWidget {
  const _AutocompleteItem({required this.label, required this.selected, required this.colors});

  final String label;
  final bool selected;
  final ColorScheme colors;

  @override
  State<_AutocompleteItem> createState() => _AutocompleteItemState();
}

class _AutocompleteItemState extends State<_AutocompleteItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        color: _hovered ? widget.colors.surfaceContainerHighest : widget.colors.surface,
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.text.bodyMedium?.textColor(
                  widget.selected ? widget.colors.primary : widget.colors.onSurface,
                ),
              ),
            ),
            if (widget.selected)
              CustomPaint(
                size: const Size(16, 16),
                painter: _AutocompleteCheckPainter(color: widget.colors.primary),
              ),
          ],
        ),
      ),
    );
  }
}

class _AutocompleteCheckPainter extends CustomPainter {
  const _AutocompleteCheckPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.52)
      ..lineTo(size.width * 0.42, size.height * 0.74)
      ..lineTo(size.width * 0.8, size.height * 0.28);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AutocompleteCheckPainter oldDelegate) => oldDelegate.color != color;
}
