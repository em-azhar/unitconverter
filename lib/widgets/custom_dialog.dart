import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

const TextStyle _kActionSheetActionStyle = TextStyle(
  fontFamily: '.SF UI Text',
  inherit: false,
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
  textBaseline: TextBaseline.alphabetic,
);

const TextStyle _kActionSheetContentStyle = TextStyle(
  fontFamily: '.SF UI Text',
  inherit: false,
  fontSize: 13.0,
  fontWeight: FontWeight.w400,
  color: _kActionSheetContentTextColor,
  textBaseline: TextBaseline.alphabetic,
);

const double _kBlurAmount = 20.0;
const double _kCornerRadius = 14.0;
const double _kDividerThickness = 1.0;

const double _kCupertinoDialogWidth = 270.0;
const double _kAccessibilityCupertinoDialogWidth = 310.0;

const double _kActionSheetEdgeHorizontalPadding = 8.0;
const double _kActionSheetCancelButtonPadding = 8.0;
const double _kActionSheetEdgeVerticalPadding = 10.0;
const double _kActionSheetContentHorizontalPadding = 40.0;
const double _kActionSheetContentVerticalPadding = 14.0;
const double _kActionSheetButtonHeight = 56.0;

const Color _kDialogColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xCCF2F2F2),
  darkColor: Color(0xBF1E1E1E),
);

const Color _kPressedColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFE1E1E1),
  darkColor: Color(0xFF2E2E2E),
);

const Color _kActionSheetBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xC7F9F9F9),
  darkColor: Color(0xC7252525),
);

const Color _kActionSheetContentTextColor = Color(0xFF8F8F8F);

const Color _kActionSheetButtonDividerColor = _kActionSheetContentTextColor;

const double _kMaxRegularTextScaleFactor = 1.4;

bool _isInAccessibilityMode(BuildContext context) {
  final MediaQueryData? data = MediaQuery.maybeOf(context);
  return data != null && data.textScaleFactor > _kMaxRegularTextScaleFactor;
}

class CustomCupertinoActionSheet extends StatelessWidget {
  const CustomCupertinoActionSheet({
    super.key,
    this.title,
    this.message,
    this.actions,
    this.messageScrollController,
    this.actionScrollController,
    this.cancelButton,
    this.color,
  }) : assert(
          actions != null ||
              title != null ||
              message != null ||
              cancelButton != null,
          'An action sheet must have a non-null value for at least one of the following arguments: '
          'actions, title, message, or cancelButton',
        );

  final Widget? title;

  final Color? color;

  final Widget? message;

  final List<Widget>? actions;

  final ScrollController? messageScrollController;

  ScrollController get _effectiveMessageScrollController =>
      messageScrollController ?? ScrollController();

  final ScrollController? actionScrollController;

  ScrollController get _effectiveActionScrollController =>
      actionScrollController ?? ScrollController();

  final Widget? cancelButton;

  Widget _buildContent(BuildContext context) {
    final List<Widget> content = <Widget>[];
    if (title != null || message != null) {
      final Widget titleSection = _CupertinoAlertContentSection(
        title: title,
        message: message,
        scrollController: _effectiveMessageScrollController,
        titlePadding: const EdgeInsets.only(
          left: _kActionSheetContentHorizontalPadding,
          right: _kActionSheetContentHorizontalPadding,
          bottom: _kActionSheetContentVerticalPadding,
          top: _kActionSheetContentVerticalPadding,
        ),
        messagePadding: EdgeInsets.only(
          left: _kActionSheetContentHorizontalPadding,
          right: _kActionSheetContentHorizontalPadding,
          bottom: title == null ? _kActionSheetContentVerticalPadding : 22.0,
          top: title == null ? _kActionSheetContentVerticalPadding : 0.0,
        ),
        titleTextStyle: message == null
            ? _kActionSheetContentStyle
            : _kActionSheetContentStyle.copyWith(fontWeight: FontWeight.w600),
        messageTextStyle: title == null
            ? _kActionSheetContentStyle.copyWith(fontWeight: FontWeight.w600)
            : _kActionSheetContentStyle,
        additionalPaddingBetweenTitleAndMessage:
            const EdgeInsets.only(top: 8.0),
      );
      content.add(Flexible(child: titleSection));
    }

    return Container(
      color:
          CupertinoDynamicColor.resolve(_kActionSheetBackgroundColor, context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: content,
      ),
    );
  }

  Widget _buildActions() {
    if (actions == null || actions!.isEmpty) {
      return Container(
        height: 0.0,
      );
    }
    return _CupertinoAlertActionSection(
      scrollController: _effectiveActionScrollController,
      hasCancelButton: cancelButton != null,
      isActionSheet: true,
      children: actions!,
    );
  }

  Widget _buildCancelButton() {
    final double cancelPadding =
        (actions != null || message != null || title != null)
            ? _kActionSheetCancelButtonPadding
            : 0.0;
    return Padding(
      padding: EdgeInsets.only(top: cancelPadding),
      child: _CupertinoActionSheetCancelButton(
        color: color,
        child: cancelButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));

    final List<Widget> children = <Widget>[
      Flexible(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          child: BackdropFilter(
            filter:
                ImageFilter.blur(sigmaX: _kBlurAmount, sigmaY: _kBlurAmount),
            child: _CupertinoDialogRenderWidget(
              contentSection: Builder(builder: _buildContent),
              actionsSection: _buildActions(),
              dividerColor: _kActionSheetButtonDividerColor,
              isActionSheet: true,
            ),
          ),
        ),
      ),
      if (cancelButton != null) _buildCancelButton(),
    ];

    final Orientation orientation = MediaQuery.of(context).orientation;
    final double actionSheetWidth;
    if (orientation == Orientation.portrait) {
      actionSheetWidth = MediaQuery.of(context).size.width -
          (_kActionSheetEdgeHorizontalPadding * 2);
    } else {
      actionSheetWidth = MediaQuery.of(context).size.height -
          (_kActionSheetEdgeHorizontalPadding * 2);
    }

    return SafeArea(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: Semantics(
          namesRoute: true,
          scopesRoute: true,
          explicitChildNodes: true,
          label: 'Alert',
          child: CupertinoUserInterfaceLevel(
            data: CupertinoUserInterfaceLevelData.elevated,
            child: Container(
              width: actionSheetWidth,
              margin: const EdgeInsets.symmetric(
                horizontal: _kActionSheetEdgeHorizontalPadding,
                vertical: _kActionSheetEdgeVerticalPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCupertinoActionSheetAction extends StatelessWidget {
  const CustomCupertinoActionSheetAction({
    super.key,
    required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    required this.child,
  });

  final VoidCallback onPressed;

  final bool isDefaultAction;

  final bool isDestructiveAction;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    TextStyle style = _kActionSheetActionStyle.copyWith(
      color: isDestructiveAction
          ? CupertinoDynamicColor.resolve(CupertinoColors.systemRed, context)
          : CupertinoTheme.of(context).primaryColor,
    );

    if (isDefaultAction) {
      style = style.copyWith(fontWeight: FontWeight.w600);
    }

    return MouseRegion(
      cursor: kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: _kActionSheetButtonHeight,
          ),
          child: Semantics(
            button: true,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 10.0,
              ),
              child: DefaultTextStyle(
                style: style,
                textAlign: TextAlign.center,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CupertinoActionSheetCancelButton extends StatefulWidget {
  const _CupertinoActionSheetCancelButton({
    this.child,
    this.color,
  });

  final Widget? child;
  final Color? color;

  @override
  _CupertinoActionSheetCancelButtonState createState() =>
      _CupertinoActionSheetCancelButtonState();
}

class _CupertinoActionSheetCancelButtonState
    extends State<_CupertinoActionSheetCancelButton> {
  bool isBeingPressed = false;

  void _onTapDown(TapDownDetails event) {
    setState(() {
      isBeingPressed = true;
    });
  }

  void _onTapUp(TapUpDetails event) {
    setState(() {
      isBeingPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      isBeingPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      excludeFromSemantics: true,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.all(Radius.circular(_kCornerRadius)),
        ),
        child: widget.child,
      ),
    );
  }
}

class _CupertinoDialogRenderWidget extends RenderObjectWidget {
  const _CupertinoDialogRenderWidget({
    required this.contentSection,
    required this.actionsSection,
    required this.dividerColor,
    this.isActionSheet = false,
  });

  final Widget contentSection;
  final Widget actionsSection;
  final Color dividerColor;
  final bool isActionSheet;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCupertinoDialog(
      dividerThickness:
          _kDividerThickness / MediaQuery.of(context).devicePixelRatio,
      isInAccessibilityMode: _isInAccessibilityMode(context) && !isActionSheet,
      dividerColor: CupertinoDynamicColor.resolve(dividerColor, context),
      isActionSheet: isActionSheet,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderCupertinoDialog renderObject) {
    renderObject
      ..isInAccessibilityMode =
          _isInAccessibilityMode(context) && !isActionSheet
      ..dividerColor = CupertinoDynamicColor.resolve(dividerColor, context);
  }

  @override
  RenderObjectElement createElement() {
    return _CupertinoDialogRenderElement(this,
        allowMoveRenderObjectChild: isActionSheet);
  }
}

class _CupertinoDialogRenderElement extends RenderObjectElement {
  _CupertinoDialogRenderElement(_CupertinoDialogRenderWidget super.widget,
      {this.allowMoveRenderObjectChild = false});

  final bool allowMoveRenderObjectChild;

  Element? _contentElement;
  Element? _actionsElement;

  @override
  _RenderCupertinoDialog get renderObject =>
      super.renderObject as _RenderCupertinoDialog;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_contentElement != null) {
      visitor(_contentElement!);
    }
    if (_actionsElement != null) {
      visitor(_actionsElement!);
    }
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    final _CupertinoDialogRenderWidget dialogRenderWidget =
        widget as _CupertinoDialogRenderWidget;
    _contentElement = updateChild(_contentElement,
        dialogRenderWidget.contentSection, _AlertDialogSections.contentSection);
    _actionsElement = updateChild(_actionsElement,
        dialogRenderWidget.actionsSection, _AlertDialogSections.actionsSection);
  }

  @override
  void insertRenderObjectChild(RenderObject child, _AlertDialogSections slot) {
    _placeChildInSlot(child, slot);
  }

  @override
  void moveRenderObjectChild(RenderObject child, _AlertDialogSections oldSlot,
      _AlertDialogSections newSlot) {
    if (!allowMoveRenderObjectChild) {
      super.moveRenderObjectChild(child, oldSlot, newSlot);
      return;
    }

    _placeChildInSlot(child, newSlot);
  }

  @override
  void update(RenderObjectWidget newWidget) {
    super.update(newWidget);
    final _CupertinoDialogRenderWidget dialogRenderWidget =
        widget as _CupertinoDialogRenderWidget;
    _contentElement = updateChild(_contentElement,
        dialogRenderWidget.contentSection, _AlertDialogSections.contentSection);
    _actionsElement = updateChild(_actionsElement,
        dialogRenderWidget.actionsSection, _AlertDialogSections.actionsSection);
  }

  @override
  void forgetChild(Element child) {
    assert(child == _contentElement || child == _actionsElement);
    if (_contentElement == child) {
      _contentElement = null;
    } else {
      assert(_actionsElement == child);
      _actionsElement = null;
    }
    super.forgetChild(child);
  }

  @override
  void removeRenderObjectChild(RenderObject child, _AlertDialogSections slot) {
    assert(child == renderObject.contentSection ||
        child == renderObject.actionsSection);
    if (renderObject.contentSection == child) {
      renderObject.contentSection = null;
    } else {
      assert(renderObject.actionsSection == child);
      renderObject.actionsSection = null;
    }
  }

  void _placeChildInSlot(RenderObject child, _AlertDialogSections slot) {
    switch (slot) {
      case _AlertDialogSections.contentSection:
        renderObject.contentSection = child as RenderBox;
        break;
      case _AlertDialogSections.actionsSection:
        renderObject.actionsSection = child as RenderBox;
        break;
    }
  }
}

class _RenderCupertinoDialog extends RenderBox {
  _RenderCupertinoDialog({
    RenderBox? contentSection,
    RenderBox? actionsSection,
    double dividerThickness = 0.0,
    bool isInAccessibilityMode = false,
    bool isActionSheet = false,
    required Color dividerColor,
  })  : _contentSection = contentSection,
        _actionsSection = actionsSection,
        _dividerThickness = dividerThickness,
        _isInAccessibilityMode = isInAccessibilityMode,
        _isActionSheet = isActionSheet,
        _dividerPaint = Paint()
          ..color = dividerColor
          ..style = PaintingStyle.fill;

  RenderBox? get contentSection => _contentSection;
  RenderBox? _contentSection;
  set contentSection(RenderBox? newContentSection) {
    if (newContentSection != _contentSection) {
      if (_contentSection != null) {
        dropChild(_contentSection!);
      }
      _contentSection = newContentSection;
      if (_contentSection != null) {
        adoptChild(_contentSection!);
      }
    }
  }

  RenderBox? get actionsSection => _actionsSection;
  RenderBox? _actionsSection;
  set actionsSection(RenderBox? newActionsSection) {
    if (newActionsSection != _actionsSection) {
      if (null != _actionsSection) {
        dropChild(_actionsSection!);
      }
      _actionsSection = newActionsSection;
      if (null != _actionsSection) {
        adoptChild(_actionsSection!);
      }
    }
  }

  bool get isInAccessibilityMode => _isInAccessibilityMode;
  bool _isInAccessibilityMode;
  set isInAccessibilityMode(bool newValue) {
    if (newValue != _isInAccessibilityMode) {
      _isInAccessibilityMode = newValue;
      markNeedsLayout();
    }
  }

  bool _isActionSheet;
  bool get isActionSheet => _isActionSheet;
  set isActionSheet(bool newValue) {
    if (newValue != _isActionSheet) {
      _isActionSheet = newValue;
      markNeedsLayout();
    }
  }

  double get _dialogWidth => isInAccessibilityMode
      ? _kAccessibilityCupertinoDialogWidth
      : _kCupertinoDialogWidth;

  final double _dividerThickness;
  final Paint _dividerPaint;

  Color get dividerColor => _dividerPaint.color;
  set dividerColor(Color newValue) {
    if (dividerColor == newValue) {
      return;
    }

    _dividerPaint.color = newValue;
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    if (null != contentSection) {
      contentSection!.attach(owner);
    }
    if (null != actionsSection) {
      actionsSection!.attach(owner);
    }
  }

  @override
  void detach() {
    super.detach();
    if (null != contentSection) {
      contentSection!.detach();
    }
    if (null != actionsSection) {
      actionsSection!.detach();
    }
  }

  @override
  void redepthChildren() {
    if (null != contentSection) {
      redepthChild(contentSection!);
    }
    if (null != actionsSection) {
      redepthChild(actionsSection!);
    }
  }

  @override
  void setupParentData(RenderBox child) {
    if (!isActionSheet && child.parentData is! BoxParentData) {
      child.parentData = BoxParentData();
    } else if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (contentSection != null) {
      visitor(contentSection!);
    }
    if (actionsSection != null) {
      visitor(actionsSection!);
    }
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() => <DiagnosticsNode>[
        if (contentSection != null)
          contentSection!.toDiagnosticsNode(name: 'content'),
        if (actionsSection != null)
          actionsSection!.toDiagnosticsNode(name: 'actions'),
      ];

  @override
  double computeMinIntrinsicWidth(double height) {
    return isActionSheet ? constraints.minWidth : _dialogWidth;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return isActionSheet ? constraints.maxWidth : _dialogWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double contentHeight = contentSection!.getMinIntrinsicHeight(width);
    final double actionsHeight = actionsSection!.getMinIntrinsicHeight(width);
    final bool hasDivider = contentHeight > 0.0 && actionsHeight > 0.0;
    double height =
        contentHeight + (hasDivider ? _dividerThickness : 0.0) + actionsHeight;

    if (isActionSheet && (actionsHeight > 0 || contentHeight > 0)) {
      height -= 2 * _kActionSheetEdgeVerticalPadding;
    }
    if (height.isFinite) {
      return height;
    }
    return 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    final double contentHeight = contentSection!.getMaxIntrinsicHeight(width);
    final double actionsHeight = actionsSection!.getMaxIntrinsicHeight(width);
    final bool hasDivider = contentHeight > 0.0 && actionsHeight > 0.0;
    double height =
        contentHeight + (hasDivider ? _dividerThickness : 0.0) + actionsHeight;

    if (isActionSheet && (actionsHeight > 0 || contentHeight > 0)) {
      height -= 2 * _kActionSheetEdgeVerticalPadding;
    }
    if (height.isFinite) {
      return height;
    }
    return 0.0;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.dryLayoutChild,
    ).size;
  }

  @override
  void performLayout() {
    final _AlertDialogSizes dialogSizes = _performLayout(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );
    size = dialogSizes.size;

    assert(
      (!isActionSheet && actionsSection!.parentData is BoxParentData) ||
          (isActionSheet &&
              actionsSection!.parentData is MultiChildLayoutParentData),
    );
    if (isActionSheet) {
      final MultiChildLayoutParentData actionParentData =
          actionsSection!.parentData! as MultiChildLayoutParentData;
      actionParentData.offset =
          Offset(0.0, dialogSizes.contentHeight + dialogSizes.dividerThickness);
    } else {
      final BoxParentData actionParentData =
          actionsSection!.parentData! as BoxParentData;
      actionParentData.offset =
          Offset(0.0, dialogSizes.contentHeight + dialogSizes.dividerThickness);
    }
  }

  _AlertDialogSizes _performLayout(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
    return isInAccessibilityMode
        ? performAccessibilityLayout(
            constraints: constraints,
            layoutChild: layoutChild,
          )
        : performRegularLayout(
            constraints: constraints,
            layoutChild: layoutChild,
          );
  }

  _AlertDialogSizes performRegularLayout(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
    final bool hasDivider =
        contentSection!.getMaxIntrinsicHeight(computeMaxIntrinsicWidth(0)) >
                0.0 &&
            actionsSection!.getMaxIntrinsicHeight(computeMaxIntrinsicWidth(0)) >
                0.0;
    final double dividerThickness = hasDivider ? _dividerThickness : 0.0;

    final double minActionsHeight =
        actionsSection!.getMinIntrinsicHeight(computeMaxIntrinsicWidth(0));

    final Size contentSize = layoutChild(
      contentSection!,
      constraints.deflate(
          EdgeInsets.only(bottom: minActionsHeight + dividerThickness)),
    );

    final Size actionsSize = layoutChild(
      actionsSection!,
      constraints
          .deflate(EdgeInsets.only(top: contentSize.height + dividerThickness)),
    );

    final double dialogHeight =
        contentSize.height + dividerThickness + actionsSize.height;

    return _AlertDialogSizes(
      size: isActionSheet
          ? Size(constraints.maxWidth, dialogHeight)
          : constraints.constrain(Size(_dialogWidth, dialogHeight)),
      contentHeight: contentSize.height,
      dividerThickness: dividerThickness,
    );
  }

  _AlertDialogSizes performAccessibilityLayout(
      {required BoxConstraints constraints,
      required ChildLayouter layoutChild}) {
    final bool hasDivider =
        contentSection!.getMaxIntrinsicHeight(_dialogWidth) > 0.0 &&
            actionsSection!.getMaxIntrinsicHeight(_dialogWidth) > 0.0;
    final double dividerThickness = hasDivider ? _dividerThickness : 0.0;

    final double maxContentHeight =
        contentSection!.getMaxIntrinsicHeight(_dialogWidth);
    final double maxActionsHeight =
        actionsSection!.getMaxIntrinsicHeight(_dialogWidth);

    final Size contentSize;
    final Size actionsSize;
    if (maxContentHeight + dividerThickness + maxActionsHeight >
        constraints.maxHeight) {
      actionsSize = layoutChild(
        actionsSection!,
        constraints.deflate(EdgeInsets.only(top: constraints.maxHeight / 2.0)),
      );

      contentSize = layoutChild(
        contentSection!,
        constraints.deflate(
            EdgeInsets.only(bottom: actionsSize.height + dividerThickness)),
      );
    } else {
      contentSize = layoutChild(
        contentSection!,
        constraints,
      );

      actionsSize = layoutChild(
        actionsSection!,
        constraints.deflate(EdgeInsets.only(top: contentSize.height)),
      );
    }

    final double dialogHeight =
        contentSize.height + dividerThickness + actionsSize.height;

    return _AlertDialogSizes(
      size: constraints.constrain(Size(_dialogWidth, dialogHeight)),
      contentHeight: contentSize.height,
      dividerThickness: dividerThickness,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (isActionSheet) {
      final MultiChildLayoutParentData contentParentData =
          contentSection!.parentData! as MultiChildLayoutParentData;
      contentSection!.paint(context, offset + contentParentData.offset);
    } else {
      final BoxParentData contentParentData =
          contentSection!.parentData! as BoxParentData;
      contentSection!.paint(context, offset + contentParentData.offset);
    }

    final bool hasDivider =
        contentSection!.size.height > 0.0 && actionsSection!.size.height > 0.0;
    if (hasDivider) {
      _paintDividerBetweenContentAndActions(context.canvas, offset);
    }

    if (isActionSheet) {
      final MultiChildLayoutParentData actionsParentData =
          actionsSection!.parentData! as MultiChildLayoutParentData;
      actionsSection!.paint(context, offset + actionsParentData.offset);
    } else {
      final BoxParentData actionsParentData =
          actionsSection!.parentData! as BoxParentData;
      actionsSection!.paint(context, offset + actionsParentData.offset);
    }
  }

  void _paintDividerBetweenContentAndActions(Canvas canvas, Offset offset) {
    canvas.drawRect(
      Rect.fromLTWH(
        offset.dx,
        offset.dy + contentSection!.size.height,
        size.width,
        _dividerThickness,
      ),
      _dividerPaint,
    );
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (isActionSheet) {
      final MultiChildLayoutParentData contentSectionParentData =
          contentSection!.parentData! as MultiChildLayoutParentData;
      final MultiChildLayoutParentData actionsSectionParentData =
          actionsSection!.parentData! as MultiChildLayoutParentData;
      return result.addWithPaintOffset(
            offset: contentSectionParentData.offset,
            position: position,
            hitTest: (BoxHitTestResult result, Offset transformed) {
              assert(transformed == position - contentSectionParentData.offset);
              return contentSection!.hitTest(result, position: transformed);
            },
          ) ||
          result.addWithPaintOffset(
            offset: actionsSectionParentData.offset,
            position: position,
            hitTest: (BoxHitTestResult result, Offset transformed) {
              assert(transformed == position - actionsSectionParentData.offset);
              return actionsSection!.hitTest(result, position: transformed);
            },
          );
    }

    final BoxParentData contentSectionParentData =
        contentSection!.parentData! as BoxParentData;
    final BoxParentData actionsSectionParentData =
        actionsSection!.parentData! as BoxParentData;
    return result.addWithPaintOffset(
          offset: contentSectionParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            assert(transformed == position - contentSectionParentData.offset);
            return contentSection!.hitTest(result, position: transformed);
          },
        ) ||
        result.addWithPaintOffset(
          offset: actionsSectionParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            assert(transformed == position - actionsSectionParentData.offset);
            return actionsSection!.hitTest(result, position: transformed);
          },
        );
  }
}

class _AlertDialogSizes {
  const _AlertDialogSizes({
    required this.size,
    required this.contentHeight,
    required this.dividerThickness,
  });

  final Size size;
  final double contentHeight;
  final double dividerThickness;
}

enum _AlertDialogSections {
  contentSection,
  actionsSection,
}

class _CupertinoAlertContentSection extends StatelessWidget {
  const _CupertinoAlertContentSection({
    this.title,
    this.message,
    this.scrollController,
    this.titlePadding,
    this.messagePadding,
    this.titleTextStyle,
    this.messageTextStyle,
    this.additionalPaddingBetweenTitleAndMessage,
  })  : assert(title == null || titlePadding != null && titleTextStyle != null),
        assert(message == null ||
            messagePadding != null && messageTextStyle != null);

  final Widget? title;

  final Widget? message;

  final ScrollController? scrollController;

  final EdgeInsets? titlePadding;
  final EdgeInsets? messagePadding;

  final EdgeInsets? additionalPaddingBetweenTitleAndMessage;

  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;

  @override
  Widget build(BuildContext context) {
    if (title == null && message == null) {
      return SingleChildScrollView(
        controller: scrollController,
        child: const SizedBox(width: 0.0, height: 0.0),
      );
    }

    final List<Widget> titleContentGroup = <Widget>[
      if (title != null)
        Padding(
          padding: titlePadding!,
          child: DefaultTextStyle(
            style: titleTextStyle!,
            textAlign: TextAlign.center,
            child: title!,
          ),
        ),
      if (message != null)
        Padding(
          padding: messagePadding!,
          child: DefaultTextStyle(
            style: messageTextStyle!,
            textAlign: TextAlign.center,
            child: message!,
          ),
        ),
    ];

    if (additionalPaddingBetweenTitleAndMessage != null &&
        titleContentGroup.length > 1) {
      titleContentGroup.insert(
          1, Padding(padding: additionalPaddingBetweenTitleAndMessage!));
    }

    return CupertinoScrollbar(
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: titleContentGroup,
        ),
      ),
    );
  }
}

class _CupertinoAlertActionSection extends StatefulWidget {
  const _CupertinoAlertActionSection({
    required this.children,
    this.scrollController,
    this.hasCancelButton = false,
    this.isActionSheet = false,
  });

  final List<Widget> children;

  final ScrollController? scrollController;

  final bool hasCancelButton;

  final bool isActionSheet;

  @override
  _CupertinoAlertActionSectionState createState() =>
      _CupertinoAlertActionSectionState();
}

class _CupertinoAlertActionSectionState
    extends State<_CupertinoAlertActionSection> {
  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    final List<Widget> interactiveButtons = <Widget>[];
    for (int i = 0; i < widget.children.length; i += 1) {
      interactiveButtons.add(
        _PressableActionButton(
          child: widget.children[i],
        ),
      );
    }

    return CupertinoScrollbar(
      controller: widget.scrollController,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: _CupertinoDialogActionsRenderWidget(
          actionButtons: interactiveButtons,
          dividerThickness: _kDividerThickness / devicePixelRatio,
          hasCancelButton: widget.hasCancelButton,
          isActionSheet: widget.isActionSheet,
        ),
      ),
    );
  }
}

class _PressableActionButton extends StatefulWidget {
  const _PressableActionButton({
    required this.child,
  });

  final Widget child;

  @override
  _PressableActionButtonState createState() => _PressableActionButtonState();
}

class _PressableActionButtonState extends State<_PressableActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return _ActionButtonParentDataWidget(
      isPressed: _isPressed,
      child: MergeSemantics(
        child: GestureDetector(
          excludeFromSemantics: true,
          behavior: HitTestBehavior.opaque,
          onTapDown: (TapDownDetails details) => setState(() {
            _isPressed = true;
          }),
          onTapUp: (TapUpDetails details) => setState(() {
            _isPressed = false;
          }),
          onTapCancel: () => setState(() => _isPressed = false),
          child: widget.child,
        ),
      ),
    );
  }
}

class _ActionButtonParentDataWidget
    extends ParentDataWidget<_ActionButtonParentData> {
  const _ActionButtonParentDataWidget({
    required this.isPressed,
    required super.child,
  });

  final bool isPressed;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is _ActionButtonParentData);
    final _ActionButtonParentData parentData =
        renderObject.parentData! as _ActionButtonParentData;
    if (parentData.isPressed != isPressed) {
      parentData.isPressed = isPressed;

      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsPaint();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass =>
      _CupertinoDialogActionsRenderWidget;
}

class _ActionButtonParentData extends MultiChildLayoutParentData {
  bool isPressed = false;
}

class _CupertinoDialogActionsRenderWidget extends MultiChildRenderObjectWidget {
  _CupertinoDialogActionsRenderWidget({
    required List<Widget> actionButtons,
    double dividerThickness = 0.0,
    bool hasCancelButton = false,
    bool isActionSheet = false,
  })  : _dividerThickness = dividerThickness,
        _hasCancelButton = hasCancelButton,
        _isActionSheet = isActionSheet,
        super(children: actionButtons);

  final double _dividerThickness;
  final bool _hasCancelButton;
  final bool _isActionSheet;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderCupertinoDialogActions(
      dialogWidth: _isActionSheet
          ? null
          : _isInAccessibilityMode(context)
              ? _kAccessibilityCupertinoDialogWidth
              : _kCupertinoDialogWidth,
      dividerThickness: _dividerThickness,
      dialogColor: CupertinoDynamicColor.resolve(
          _isActionSheet ? _kActionSheetBackgroundColor : _kDialogColor,
          context),
      dialogPressedColor:
          CupertinoDynamicColor.resolve(_kPressedColor, context),
      dividerColor: CupertinoDynamicColor.resolve(
          _isActionSheet
              ? _kActionSheetButtonDividerColor
              : CupertinoColors.separator,
          context),
      hasCancelButton: _hasCancelButton,
      isActionSheet: _isActionSheet,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderCupertinoDialogActions renderObject) {
    renderObject
      ..dialogWidth = _isActionSheet
          ? null
          : _isInAccessibilityMode(context)
              ? _kAccessibilityCupertinoDialogWidth
              : _kCupertinoDialogWidth
      ..dividerThickness = _dividerThickness
      ..dialogColor = CupertinoDynamicColor.resolve(
          _isActionSheet ? _kActionSheetBackgroundColor : _kDialogColor,
          context)
      ..dialogPressedColor =
          CupertinoDynamicColor.resolve(_kPressedColor, context)
      ..dividerColor = CupertinoDynamicColor.resolve(
          _isActionSheet
              ? _kActionSheetButtonDividerColor
              : CupertinoColors.separator,
          context)
      ..hasCancelButton = _hasCancelButton
      ..isActionSheet = _isActionSheet;
  }
}

class _RenderCupertinoDialogActions extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData> {
  _RenderCupertinoDialogActions({
    List<RenderBox>? children,
    double? dialogWidth,
    double dividerThickness = 0.0,
    required Color dialogColor,
    required Color dialogPressedColor,
    required Color dividerColor,
    bool hasCancelButton = false,
    bool isActionSheet = false,
  })  : assert(isActionSheet || dialogWidth != null),
        _dialogWidth = dialogWidth,
        _buttonBackgroundPaint = Paint()
          ..color = dialogColor
          ..style = PaintingStyle.fill,
        _pressedButtonBackgroundPaint = Paint()
          ..color = dialogPressedColor
          ..style = PaintingStyle.fill,
        _dividerPaint = Paint()
          ..color = dividerColor
          ..style = PaintingStyle.fill,
        _dividerThickness = dividerThickness,
        _hasCancelButton = hasCancelButton,
        _isActionSheet = isActionSheet {
    addAll(children);
  }

  double? get dialogWidth => _dialogWidth;
  double? _dialogWidth;
  set dialogWidth(double? newWidth) {
    if (newWidth != _dialogWidth) {
      _dialogWidth = newWidth;
      markNeedsLayout();
    }
  }

  double get dividerThickness => _dividerThickness;
  double _dividerThickness;
  set dividerThickness(double newValue) {
    if (newValue != _dividerThickness) {
      _dividerThickness = newValue;
      markNeedsLayout();
    }
  }

  bool _hasCancelButton;
  bool get hasCancelButton => _hasCancelButton;
  set hasCancelButton(bool newValue) {
    if (newValue == _hasCancelButton) {
      return;
    }

    _hasCancelButton = newValue;
    markNeedsLayout();
  }

  Color get dialogColor => _buttonBackgroundPaint.color;
  final Paint _buttonBackgroundPaint;
  set dialogColor(Color value) {
    if (value == _buttonBackgroundPaint.color) {
      return;
    }

    _buttonBackgroundPaint.color = value;
    markNeedsPaint();
  }

  Color get dialogPressedColor => _pressedButtonBackgroundPaint.color;
  final Paint _pressedButtonBackgroundPaint;
  set dialogPressedColor(Color value) {
    if (value == _pressedButtonBackgroundPaint.color) {
      return;
    }

    _pressedButtonBackgroundPaint.color = value;
    markNeedsPaint();
  }

  Color get dividerColor => _dividerPaint.color;
  final Paint _dividerPaint;
  set dividerColor(Color value) {
    if (value == _dividerPaint.color) {
      return;
    }

    _dividerPaint.color = value;
    markNeedsPaint();
  }

  bool get isActionSheet => _isActionSheet;
  bool _isActionSheet;
  set isActionSheet(bool value) {
    if (value == _isActionSheet) {
      return;
    }

    _isActionSheet = value;
    markNeedsPaint();
  }

  Iterable<RenderBox> get _pressedButtons {
    final List<RenderBox> boxes = <RenderBox>[];
    RenderBox? currentChild = firstChild;
    while (currentChild != null) {
      assert(currentChild.parentData is _ActionButtonParentData);
      final _ActionButtonParentData parentData =
          currentChild.parentData! as _ActionButtonParentData;
      if (parentData.isPressed) {
        boxes.add(currentChild);
      }
      currentChild = childAfter(currentChild);
    }
    return boxes;
  }

  bool get _isButtonPressed {
    RenderBox? currentChild = firstChild;
    while (currentChild != null) {
      assert(currentChild.parentData is _ActionButtonParentData);
      final _ActionButtonParentData parentData =
          currentChild.parentData! as _ActionButtonParentData;
      if (parentData.isPressed) {
        return true;
      }
      currentChild = childAfter(currentChild);
    }
    return false;
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _ActionButtonParentData) {
      child.parentData = _ActionButtonParentData();
    }
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return isActionSheet ? constraints.minWidth : dialogWidth!;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return isActionSheet ? constraints.maxWidth : dialogWidth!;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    if (childCount == 0) {
      return 0.0;
    } else if (isActionSheet) {
      if (childCount == 1) {
        return firstChild!.computeMaxIntrinsicHeight(width) + dividerThickness;
      }
      if (hasCancelButton && childCount < 4) {
        return _computeMinIntrinsicHeightWithCancel(width);
      }
      return _computeMinIntrinsicHeightStacked(width);
    } else if (childCount == 1) {
      return _computeMinIntrinsicHeightSideBySide(width);
    } else if (childCount == 2 && _isSingleButtonRow(width)) {
      return _computeMinIntrinsicHeightSideBySide(width);
    }

    return _computeMinIntrinsicHeightStacked(width);
  }

  double _computeMinIntrinsicHeightWithCancel(double width) {
    assert(childCount == 2 || childCount == 3);
    if (childCount == 2) {
      return firstChild!.getMinIntrinsicHeight(width) +
          childAfter(firstChild!)!.getMinIntrinsicHeight(width) +
          dividerThickness;
    }
    return firstChild!.getMinIntrinsicHeight(width) +
        childAfter(firstChild!)!.getMinIntrinsicHeight(width) +
        childAfter(childAfter(firstChild!)!)!.getMinIntrinsicHeight(width) +
        (dividerThickness * 2);
  }

  double _computeMinIntrinsicHeightSideBySide(double width) {
    assert(childCount >= 1 && childCount <= 2);

    final double minHeight;
    if (childCount == 1) {
      minHeight = firstChild!.getMinIntrinsicHeight(width);
    } else {
      final double perButtonWidth = (width - dividerThickness) / 2.0;
      minHeight = math.max(
        firstChild!.getMinIntrinsicHeight(perButtonWidth),
        lastChild!.getMinIntrinsicHeight(perButtonWidth),
      );
    }
    return minHeight;
  }

  double _computeMinIntrinsicHeightStacked(double width) {
    assert(childCount >= 2);

    return firstChild!.getMinIntrinsicHeight(width) +
        dividerThickness +
        (0.5 * childAfter(firstChild!)!.getMinIntrinsicHeight(width));
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    if (childCount == 0) {
      return 0.0;
    } else if (isActionSheet) {
      if (childCount == 1) {
        return firstChild!.computeMaxIntrinsicHeight(width) + dividerThickness;
      }
      return _computeMaxIntrinsicHeightStacked(width);
    } else if (childCount == 1) {
      return firstChild!.getMaxIntrinsicHeight(width);
    } else if (childCount == 2) {
      if (_isSingleButtonRow(width)) {
        final double perButtonWidth = (width - dividerThickness) / 2.0;
        return math.max(
          firstChild!.getMaxIntrinsicHeight(perButtonWidth),
          lastChild!.getMaxIntrinsicHeight(perButtonWidth),
        );
      } else {
        return _computeMaxIntrinsicHeightStacked(width);
      }
    }

    return _computeMaxIntrinsicHeightStacked(width);
  }

  double _computeMaxIntrinsicHeightStacked(double width) {
    assert(childCount >= 2);

    final double allDividersHeight = (childCount - 1) * dividerThickness;
    double heightAccumulation = allDividersHeight;
    RenderBox? button = firstChild;
    while (button != null) {
      heightAccumulation += button.getMaxIntrinsicHeight(width);
      button = childAfter(button);
    }
    return heightAccumulation;
  }

  bool _isSingleButtonRow(double width) {
    final bool isSingleButtonRow;
    if (childCount == 1) {
      isSingleButtonRow = true;
    } else if (childCount == 2) {
      final double sideBySideWidth =
          firstChild!.getMaxIntrinsicWidth(double.infinity) +
              dividerThickness +
              lastChild!.getMaxIntrinsicWidth(double.infinity);
      isSingleButtonRow = sideBySideWidth <= width;
    } else {
      isSingleButtonRow = false;
    }
    return isSingleButtonRow;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout(constraints: constraints, dry: true);
  }

  @override
  void performLayout() {
    size = _performLayout(constraints: constraints);
  }

  Size _performLayout({required BoxConstraints constraints, bool dry = false}) {
    final ChildLayouter layoutChild =
        dry ? ChildLayoutHelper.dryLayoutChild : ChildLayoutHelper.layoutChild;

    if (!isActionSheet && _isSingleButtonRow(dialogWidth!)) {
      if (childCount == 1) {
        final Size childSize = layoutChild(
          firstChild!,
          constraints,
        );

        return constraints.constrain(
          Size(dialogWidth!, childSize.height),
        );
      } else {
        final BoxConstraints perButtonConstraints = BoxConstraints(
          minWidth: (constraints.minWidth - dividerThickness) / 2.0,
          maxWidth: (constraints.maxWidth - dividerThickness) / 2.0,
        );

        final Size firstChildSize = layoutChild(
          firstChild!,
          perButtonConstraints,
        );
        final Size lastChildSize = layoutChild(
          lastChild!,
          perButtonConstraints,
        );

        if (!dry) {
          assert(lastChild!.parentData is MultiChildLayoutParentData);
          final MultiChildLayoutParentData secondButtonParentData =
              lastChild!.parentData! as MultiChildLayoutParentData;
          secondButtonParentData.offset =
              Offset(firstChildSize.width + dividerThickness, 0.0);
        }

        return constraints.constrain(
          Size(
            dialogWidth!,
            math.max(
              firstChildSize.height,
              lastChildSize.height,
            ),
          ),
        );
      }
    } else {
      final BoxConstraints perButtonConstraints = constraints.copyWith(
        minHeight: 0.0,
        maxHeight: double.infinity,
      );

      RenderBox? child = firstChild;
      int index = 0;
      double verticalOffset = 0.0;
      while (child != null) {
        final Size childSize = layoutChild(
          child,
          perButtonConstraints,
        );

        if (!dry) {
          assert(child.parentData is MultiChildLayoutParentData);
          final MultiChildLayoutParentData parentData =
              child.parentData! as MultiChildLayoutParentData;
          parentData.offset = Offset(0.0, verticalOffset);
        }
        verticalOffset += childSize.height;
        if (index < childCount - 1) {
          verticalOffset += dividerThickness;
        }

        index += 1;
        child = childAfter(child);
      }

      return constraints.constrain(
        Size(computeMaxIntrinsicWidth(0), verticalOffset),
      );
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Canvas canvas = context.canvas;

    if (!isActionSheet && _isSingleButtonRow(size.width)) {
      _drawButtonBackgroundsAndDividersSingleRow(canvas, offset);
    } else {
      _drawButtonBackgroundsAndDividersStacked(canvas, offset);
    }

    _drawButtons(context, offset);
  }

  void _drawButtonBackgroundsAndDividersSingleRow(
      Canvas canvas, Offset offset) {
    final Rect verticalDivider = childCount == 2 && !_isButtonPressed
        ? Rect.fromLTWH(
            offset.dx + firstChild!.size.width,
            offset.dy,
            dividerThickness,
            math.max(
              firstChild!.size.height,
              lastChild!.size.height,
            ),
          )
        : Rect.zero;

    final List<Rect> pressedButtonRects =
        _pressedButtons.map<Rect>((RenderBox pressedButton) {
      final MultiChildLayoutParentData buttonParentData =
          pressedButton.parentData! as MultiChildLayoutParentData;

      return Rect.fromLTWH(
        offset.dx + buttonParentData.offset.dx,
        offset.dy + buttonParentData.offset.dy,
        pressedButton.size.width,
        pressedButton.size.height,
      );
    }).toList();

    final Path backgroundFillPath = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..addRect(verticalDivider);

    for (int i = 0; i < pressedButtonRects.length; i += 1) {
      backgroundFillPath.addRect(pressedButtonRects[i]);
    }

    canvas.drawPath(
      backgroundFillPath,
      _buttonBackgroundPaint,
    );

    final Path pressedBackgroundFillPath = Path();
    for (int i = 0; i < pressedButtonRects.length; i += 1) {
      pressedBackgroundFillPath.addRect(pressedButtonRects[i]);
    }

    canvas.drawPath(
      pressedBackgroundFillPath,
      _pressedButtonBackgroundPaint,
    );

    final Path dividersPath = Path()..addRect(verticalDivider);

    canvas.drawPath(
      dividersPath,
      _dividerPaint,
    );
  }

  void _drawButtonBackgroundsAndDividersStacked(Canvas canvas, Offset offset) {
    final Offset dividerOffset = Offset(0.0, dividerThickness);

    final Path backgroundFillPath = Path()
      ..fillType = PathFillType.evenOdd
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    final Path pressedBackgroundFillPath = Path();

    final Path dividersPath = Path();

    Offset accumulatingOffset = offset;

    RenderBox? child = firstChild;
    RenderBox? prevChild;
    while (child != null) {
      assert(child.parentData is _ActionButtonParentData);
      final _ActionButtonParentData currentButtonParentData =
          child.parentData! as _ActionButtonParentData;
      final bool isButtonPressed = currentButtonParentData.isPressed;

      bool isPrevButtonPressed = false;
      if (prevChild != null) {
        assert(prevChild.parentData is _ActionButtonParentData);
        final _ActionButtonParentData previousButtonParentData =
            prevChild.parentData! as _ActionButtonParentData;
        isPrevButtonPressed = previousButtonParentData.isPressed;
      }

      final bool isDividerPresent = child != firstChild;
      final bool isDividerPainted =
          isDividerPresent && !(isButtonPressed || isPrevButtonPressed);
      final Rect dividerRect = Rect.fromLTWH(
        accumulatingOffset.dx,
        accumulatingOffset.dy,
        size.width,
        dividerThickness,
      );

      final Rect buttonBackgroundRect = Rect.fromLTWH(
        accumulatingOffset.dx,
        accumulatingOffset.dy + (isDividerPresent ? dividerThickness : 0.0),
        size.width,
        child.size.height,
      );

      if (isButtonPressed) {
        backgroundFillPath.addRect(buttonBackgroundRect);
        pressedBackgroundFillPath.addRect(buttonBackgroundRect);
      }

      if (isDividerPainted) {
        backgroundFillPath.addRect(dividerRect);
        dividersPath.addRect(dividerRect);
      }

      accumulatingOffset += (isDividerPresent ? dividerOffset : Offset.zero) +
          Offset(0.0, child.size.height);

      prevChild = child;
      child = childAfter(child);
    }

    canvas.drawPath(backgroundFillPath, _buttonBackgroundPaint);
    canvas.drawPath(pressedBackgroundFillPath, _pressedButtonBackgroundPaint);
    canvas.drawPath(dividersPath, _dividerPaint);
  }

  void _drawButtons(PaintingContext context, Offset offset) {
    RenderBox? child = firstChild;
    while (child != null) {
      final MultiChildLayoutParentData childParentData =
          child.parentData! as MultiChildLayoutParentData;
      context.paintChild(child, childParentData.offset + offset);
      child = childAfter(child);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}
