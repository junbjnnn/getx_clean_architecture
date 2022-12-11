import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jbbase_app/utils/config/app_constants.dart';

import 'common_paging_controller.dart';

class CommonPagedListView<T> extends StatelessWidget {
  const CommonPagedListView({
    required this.pagingController,
    required this.itemBuilder,
    this.animateTransitions = true,
    this.transitionDuration = DurationConstants.defaultListGridTransitionDuration,
    this.firstPageErrorIndicator,
    this.newPageErrorIndicator,
    this.firstPageProgressIndicator,
    this.newPageProgressIndicator,
    this.noItemsFoundIndicator,
    this.noMoreItemsIndicator,
    Key? key,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.cacheExtent,
    this.restorationId,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.dragStartBehavior = DragStartBehavior.start,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.clipBehavior = Clip.hardEdge,
    this.separatorBuilder,
    this.itemSize,
  }) : super(key: key);

  final CommonPagingController<T> pagingController;
  final Widget Function(
    BuildContext context,
    T item,
    int index,
  ) itemBuilder;
  final bool animateTransitions;
  final Duration transitionDuration;
  final Widget? firstPageErrorIndicator;
  final Widget? newPageErrorIndicator;
  final Widget? firstPageProgressIndicator;
  final Widget? newPageProgressIndicator;
  final Widget? noItemsFoundIndicator;
  final Widget? noMoreItemsIndicator;

  final ScrollController? scrollController;
  final Axis scrollDirection;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? itemExtent;
  final double? cacheExtent;
  final DragStartBehavior dragStartBehavior;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final String? restorationId;
  final Clip clipBehavior;
  final IndexedWidgetBuilder? separatorBuilder;

  ///Composed of the size of each item + its margin/padding.
  ///
  ///Size used is width if `scrollDirection` is `Axis.horizontal`, height if `Axis.vertical`.
  ///
  ///Example:
  ///- Horizontal list
  ///- Card with `width` 100
  ///- Margin is `EdgeInsets.symmetric(horizontal: 5)`
  ///- itemSize is `100+5+5 = 110`
  final double? itemSize;

  @override
  Widget build(BuildContext context) {
    final builderDelegate = PagedChildBuilderDelegate<T>(
      itemBuilder: itemBuilder,
      animateTransitions: animateTransitions,
      transitionDuration: transitionDuration,
      firstPageErrorIndicatorBuilder: (_) => firstPageErrorIndicator ?? const CommonFirstPageErrorIndicator(),
      newPageErrorIndicatorBuilder: (_) => newPageErrorIndicator ?? const CommonNewPageErrorIndicator(),
      firstPageProgressIndicatorBuilder: (_) => firstPageProgressIndicator ?? const CommonFirstPageProgressIndicator(),
      newPageProgressIndicatorBuilder: (_) => newPageProgressIndicator ?? const CommonNewPageProgressIndicator(),
      noItemsFoundIndicatorBuilder: (_) => noItemsFoundIndicator ?? const CommonNoItemsFoundIndicator(),
      noMoreItemsIndicatorBuilder: (_) => noMoreItemsIndicator ?? const CommonNoMoreItemsIndicator(),
    );

    PagedListView<int, T> pagedView(double maxWidth, double maxHeight) => separatorBuilder != null
        ? PagedListView.separated(
            pagingController: pagingController.pagingController,
            builderDelegate: builderDelegate,
            separatorBuilder: separatorBuilder!,
            scrollDirection: scrollDirection,
            reverse: reverse,
            scrollController: scrollController,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            cacheExtent: cacheExtent,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
          )
        : PagedListView<int, T>(
            pagingController: pagingController.pagingController,
            builderDelegate: builderDelegate,
            scrollDirection: scrollDirection,
            reverse: reverse,
            scrollController: scrollController,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            cacheExtent: cacheExtent,
            dragStartBehavior: dragStartBehavior,
            keyboardDismissBehavior: keyboardDismissBehavior,
            restorationId: restorationId,
            clipBehavior: clipBehavior,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
            itemExtent: itemExtent,
          );

    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraint) {
        return pagedView(constraint.maxWidth, constraint.maxHeight);
      },
    );
  }
}

class CommonFirstPageErrorIndicator extends StatelessWidget {
  const CommonFirstPageErrorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class CommonNewPageErrorIndicator extends StatelessWidget {
  const CommonNewPageErrorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class CommonFirstPageProgressIndicator extends StatelessWidget {
  const CommonFirstPageProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class CommonNewPageProgressIndicator extends StatelessWidget {
  const CommonNewPageProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

class CommonNoItemsFoundIndicator extends StatelessWidget {
  const CommonNoItemsFoundIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class CommonNoMoreItemsIndicator extends StatelessWidget {
  const CommonNoMoreItemsIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
