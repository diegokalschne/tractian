import 'package:flutter/material.dart';

import '../models/assets/asset_model.dart';
import '../models/tree/tree_model.dart';

class TreeWidget extends StatefulWidget {
  const TreeWidget({
    required this.node,
    this.onLongPressNode,
    super.key,
  });

  final TreeModel node;
  final void Function(AssetLocationBaseModel)? onLongPressNode;

  @override
  State<TreeWidget> createState() => _TreeWidgetState();
}

class _TreeWidgetState extends State<TreeWidget> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final AnimationController controller;
  late final Animation<double> animation;

  late final TreeModel node;

  bool expanded = true;

  @override
  void initState() {
    super.initState();

    node = widget.node;

    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );

    animation = CurvedAnimation(
      curve: Curves.easeInToLinear,
      reverseCurve: Curves.easeInToLinear,
      parent: controller,
    );

    controller.forward(from: 1);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  void changeExpanded() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: node.leaves.isEmpty ? null : changeExpanded,
          onLongPress: widget.onLongPressNode == null ? null : () => widget.onLongPressNode!(node.node),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (node.leaves.isNotEmpty) ...[
                  Icon(
                    expanded ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
                    color: theme.colorScheme.onSurface,
                  ),
                ] else ...[
                  const Icon(null),
                ],
                Image.asset(node.node.getIcon, width: 25),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    node.node.name,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 5),
                node.node.suffixIcon,
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Flexible(
          child: SizeTransition(
            sizeFactor: animation,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: node.leaves.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, index) {
                final leave = node.leaves[index];

                return Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: TreeWidget(
                    node: leave,
                    onLongPressNode: widget.onLongPressNode,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
