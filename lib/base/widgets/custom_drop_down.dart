// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/basic_import.dart';

abstract class DropdownModel {
  String get title;
  String? get leading;
}

class CustomDropDown<T> extends StatefulWidget {
  final RxString selectMethod;
  final RxString? leadingAsset;
  final String? leadingPath;
  final EdgeInsets? selectMethodPadding;
  final List<T> itemsList;
  final void Function(T?)? onChanged;
  final bool showSearchField; // Control visibility of the search field
  final bool showDropDown; // Control visibility of the search field
  final RxString? subtitle;
  final Decoration? decoration;
  final Color? labelColor;
  final Color? buttonFillColor;
  final double? inputBoxHeight;
  final double? leadingRadius;
  final double? iconSize;
  final Color? dropdownIconColor;
  final Color? dropDownColor;
  final Widget? leadingWidget;
  final EdgeInsets? fieldPadding;
  final EdgeInsets? leadingPadding;
  final String label;
  final bool enabledBorder;
  final bool shrink;
  final bool hideSelectMethod;
  final bool isSuffix;
  final bool enableLeading;
  const CustomDropDown({
    required this.itemsList,
    required this.selectMethod,
    this.onChanged,
    this.inputBoxHeight,
    this.decoration,
    this.labelColor,
    this.label = '',
    this.dropdownIconColor,
    this.leadingWidget,
    this.fieldPadding,
    this.showSearchField = false, // Default is false (no search field)
    this.subtitle,
    this.enabledBorder = true,
    this.shrink = false,
    this.isSuffix = false,
    this.enableLeading = false,
    super.key,
    this.selectMethodPadding,
    this.leadingAsset,
    this.buttonFillColor,
    this.dropDownColor,
    this.leadingRadius,
    this.showDropDown = true,
    this.leadingPath,
    this.hideSelectMethod = false,
    this.leadingPadding,
    this.iconSize,
  });

  @override
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>>
    with SingleTickerProviderStateMixin {
  bool isDropdownOpened = false;
  final LayerLink _layerLink = LayerLink();
  TextEditingController searchController = TextEditingController();
  List<T> filteredItems = [];
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.itemsList;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _toggleDropdown() {
    if (isDropdownOpened) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var screenHeight = MediaQuery.of(context).size.height;
    var spaceBelow =
        screenHeight - renderBox.localToGlobal(Offset.zero).dy - size.height;
    var spaceAbove = renderBox.localToGlobal(Offset.zero).dy;

    double itemHeight = 48.0;
    int maxVisibleItems = 6;
    double dropdownHeight = _calculateDropdownHeight(
      itemHeight,
      maxVisibleItems,
    );

    double spaceThresholdAbove = dropdownHeight - 20.0;
    bool openUpwards =
        spaceBelow < dropdownHeight && spaceAbove > spaceThresholdAbove;

    if (openUpwards && spaceAbove < dropdownHeight) {
      dropdownHeight = spaceAbove - 10.0;
    }

    _overlayEntry = _createOverlayEntry(
      openUpwards: openUpwards,
      dropdownHeight: dropdownHeight,
    );
    Overlay.of(context).insert(_overlayEntry!);

    setState(() {
      isDropdownOpened = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    setState(() {
      isDropdownOpened = false;
      searchController.clear();
      filteredItems = widget.itemsList;
    });
  }

  OverlayEntry _createOverlayEntry({
    bool openUpwards = false,
    double dropdownHeight = 200.0,
  }) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder:
          (context) => GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _closeDropdown,
            child: Stack(
              children: [
                Positioned(
                  width: size.width,
                  child: CompositedTransformFollower(
                    link: _layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(
                      0.0,
                      openUpwards
                          ? -dropdownHeight - size.height * 0.08
                          : size.height,
                    ),
                    child: _buildDropdownList(dropdownHeight),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  double _calculateDropdownHeight(double itemHeight, int maxVisibleItems) {
    return filteredItems.length <= maxVisibleItems
        ? filteredItems.length * itemHeight
        : maxVisibleItems * itemHeight;
  }

  Widget _buildDropdownList(double dropdownHeight) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Material(
        elevation: 2,
        color:
            widget.dropDownColor ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Dimensions.radius),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: Dimensions.verticalSize * 0.5),
          decoration: BoxDecoration(
            color:
                widget.dropDownColor ??
                Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: Column(
            children: [
              if (widget.showSearchField) _buildSearchField(),
              if (filteredItems.isNotEmpty)
                _buildFilteredItemsList(dropdownHeight)
              else
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('No data found', style: CustomStyle.titleMedium),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.horizontalSize * 0.5,
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            filteredItems =
                widget.itemsList
                    .where(
                      (item) => _getItemTitle(
                        item,
                      ).toLowerCase().contains(value.toLowerCase()),
                    )
                    .toList();
          });
        },
        cursorColor: CustomColor.primary,
        decoration: InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: CustomColor.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildFilteredItemsList(double dropdownHeight) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: dropdownHeight),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final value = filteredItems[index];
          return _buildDropdownItem(value);
        },
      ),
    );
  }

  Widget _buildDropdownItem(T value) {
    final itemTitle = _getItemTitle(value);
    final itemLeading = _getLeadingPath(value);

    return GestureDetector(
      onTap: () {
        widget.onChanged?.call(value);
        widget.selectMethod.value = itemTitle;
        if (widget.enableLeading && widget.leadingAsset != null) {
          widget.leadingAsset!.value = itemLeading ?? '';
        }
        // print(
        //   "||||||||||||||||||||||||||||||||||||||| flag url ${widget.leadingAsset!.value}",
        // );
        _closeDropdown();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color:
              widget.selectMethod.value == itemTitle
                  ? CustomColor.primary.withValues(alpha: 0.6)
                  : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: widget.enableLeading ? mainStart : mainStart,
            children: [
              widget.enableLeading
                  ? Container(
                    height: Dimensions.heightSize * 2.5,
                    width: Dimensions.widthSize * 2.5,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child:
                        itemLeading != null
                            ? CircleAvatar(
                              radius: Dimensions.radius * 1.5,
                              backgroundColor: CustomColor.background,
                              backgroundImage: _resolveImage(itemLeading),
                            )
                            : null,
                  )
                  : const SizedBox.shrink(),
              widget.enableLeading ? Sizes.width.v10 : const SizedBox.shrink(),
              widget.hideSelectMethod
                  ? SizedBox.shrink()
                  : Text(
                    itemTitle,
                    style: CustomStyle.titleMedium.copyWith(
                      color:
                          widget.selectMethod.value == itemTitle
                              ? Colors.white
                              : null,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButton(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.showDropDown ? _toggleDropdown : () {},
      child: Column(
        crossAxisAlignment: crossStart,
        children: [
          if (widget.label != '')
            Column(
              children: [
                // Sizes.height.btnInputTitleAndBox,
                TextWidget(
                  widget.label,
                  style: CustomStyle.labelMedium.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  color:
                      isDropdownOpened
                          ? Color(0xff1d1d1d)
                          : CustomColor.whiteColor,
                ),
                Sizes.height.btnInputTitleAndBox,
              ],
            ),
          Container(
            height: widget.inputBoxHeight ?? Dimensions.inputBoxHeight * 0.85,
            decoration:
                widget.enabledBorder
                    ? BoxDecoration(
                      border: Border.all(
                        color:
                            isDropdownOpened
                                ? CustomColor.primary
                                : CustomColor.disableColor,
                        width: isDropdownOpened ? 1 : 0.5,
                      ),
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius * 0.5,
                      ),
                      color: widget.buttonFillColor ?? CustomColor.background,
                    )
                    : widget.decoration ??
                        BoxDecoration(
                          color:
                              widget.buttonFillColor ?? CustomColor.whiteColor,
                        ),
            child: Padding(
              padding:
                  widget.fieldPadding ??
                  EdgeInsets.only(
                    left: 5,
                    // DynamicLanguage.languageDirection == TextDirection.rtl ?

                    // : 15,
                    // right:
                    //     DynamicLanguage.languageDirection == TextDirection.rtl
                    //         ? 15
                    //         : 5,
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      // mainAxisAlignment: mainSpaceBet,
                      children: [
                        widget.enableLeading
                            ? Obx(
                              () => Padding(
                                padding:
                                    widget.leadingPadding ?? EdgeInsets.zero,
                                child:
                                    widget.leadingWidget ??
                                    CircleAvatar(
                                      radius:
                                          widget.leadingRadius ??
                                          Dimensions.radius * 1.5,
                                      backgroundColor: CustomColor.background,
                                      backgroundImage: _resolveImage(
                                        widget.leadingAsset!.value,
                                      ),
                                    ),
                              ),
                            )
                            : const SizedBox.shrink(),
                        widget.hideSelectMethod
                            ? SizedBox.shrink()
                            : Expanded(
                              child: Padding(
                                padding:
                                    widget.selectMethodPadding ??
                                    EdgeInsets.only(
                                      left:
                                          widget.leadingWidget == null
                                              ? Dimensions.paddingSize * 0.5
                                              : Dimensions.paddingSize * 0.5,
                                    ),
                                child: Obx(
                                  () => Column(
                                    crossAxisAlignment: crossStart,
                                    mainAxisSize: mainMin,
                                    children: [
                                      TextWidget(
                                        widget.selectMethod.value,
                                        textOverflow: TextOverflow.ellipsis,
                                        typographyStyle:
                                            TypographyStyle.titleMedium,
                                        color: widget.labelColor,
                                        style: CustomStyle.titleMedium.copyWith(
                                          color:
                                              widget.labelColor ??
                                              (isDropdownOpened
                                                  ? CustomColor.primary
                                                  : null),
                                        ),
                                      ),
                                      if (widget.subtitle != null &&
                                          widget.subtitle!.value != '')
                                        Obx(
                                          () => TextWidget(
                                            widget.subtitle!.value,
                                            fontSize:
                                                Dimensions.labelSmall * 0.9,
                                            // color: CustomColor.whiteColor,
                                            fontWeight: FontWeight.w400,
                                            maxLines: 2,
                                            textOverflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        widget.isSuffix == false
                            ? Visibility(
                              visible: widget.shrink,
                              child: Icon(
                                isDropdownOpened
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
                                color:
                                    widget.dropdownIconColor ??
                                    (isDropdownOpened
                                        ? CustomColor.primary
                                        : CustomColor.disableColor),
                                size:
                                    widget.iconSize ??
                                    Dimensions.iconSizeDefault,
                              ),
                            )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  widget.isSuffix == false
                      ? Visibility(
                        visible: widget.shrink == false,
                        child: Icon(
                          isDropdownOpened
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down,
                          color:
                              widget.dropdownIconColor ??
                              (isDropdownOpened
                                  ? CustomColor.primary
                                  : CustomColor.disableColor),
                          size: widget.iconSize ?? Dimensions.iconSizeDefault,
                        ),
                      )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider<Object>? _resolveImage(String? path) {
    if (path == null || path.trim().isEmpty) return null;

    if (path.startsWith('http')) {
      return NetworkImage(path);
    }

    if (widget.leadingPath != null && widget.leadingPath!.isNotEmpty) {
      return NetworkImage("${widget.leadingPath}/$path");
    }

    try {
      return AssetImage(path);
    } catch (e) {
      debugPrint("AssetImage failed to load: $path");
      return null;
    }
  }

  String _getItemTitle(T item) {
    if (item is DropdownModel) {
      return item.title;
    } else if (item is String) {
      return item;
    } else {
      throw ArgumentError('Unsupported item type: ${item.runtimeType}');
    }
  }

  String? _getLeadingPath(T item) {
    if (item is DropdownModel) {
      return item.leading;
    } else if (item is String) {
      return item;
    } else {
      throw ArgumentError('Unsupported item type: ${item.runtimeType}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: _buildDropdownButton(context),
    );
  }
}
