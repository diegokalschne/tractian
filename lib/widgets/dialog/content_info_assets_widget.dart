import 'package:flutter/material.dart';

import '../../models/assets/asset_model.dart';
import '../cs_inline_info.dart';

class ContentInfoAssetsWidget extends StatelessWidget {
  const ContentInfoAssetsWidget({
    required this.node,
    super.key,
  });

  final AssetLocationBaseModel node;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(node.getIcon, width: 25),
              const SizedBox(width: 5),
              Flexible(
                child: CsInlineInfo(text: node.name),
              ),
              const SizedBox(width: 5),
              node.suffixIcon,
            ],
          ),
          Divider(
            color: theme.colorScheme.primaryContainer,
            thickness: 2,
          ),
          if (node.image != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                node.image!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
          ],
          const SizedBox(height: 10),
          if (node.type != null) ...[
            CsInlineInfo(
              label: 'Tipo: ',
              text: node.type!,
              icon: Icons.credit_card,
            ),
            const SizedBox(height: 5),
          ],
          if (node is ComponentModel) ...[
            CsInlineInfo(
              label: 'Status: ',
              text: (node as ComponentModel).status ?? '',
              icon: Icons.check,
            ),
            const SizedBox(height: 5),
            CsInlineInfo(
              label: 'Tipo de sensor: ',
              text: (node as ComponentModel).sensorType,
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 5),
            CsInlineInfo(
              label: 'ID do Sensor: ',
              text: (node as ComponentModel).sensorId ?? '',
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 5),
            CsInlineInfo(
              label: 'ID do Gateway: ',
              text: (node as ComponentModel).gatewayId,
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 5),
          ],
        ],
      ),
    );
  }
}
