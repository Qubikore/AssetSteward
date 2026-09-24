import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

import '../../../data/models/profile_data.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileData data;

  const ProfileHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.primary.op(0.2), width: 2),
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: context.colors.primaryContainer,
              backgroundImage: data.profilePicture != null ? NetworkImage(data.profilePicture!) : null,
              child: data.profilePicture == null
                  ? Text(
                      '${data.firstname[0]}${data.lastname[0]}',
                      style: context.text.headlineMedium?.copyWith(color: context.colors.onPrimaryContainer),
                    )
                  : null,
            ),
          ),
          const Gap(Insets.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${data.firstname} ${data.lastname}',
                  style: context.text.titleLarge?.bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(HIStroke.mail01, size: 16, color: context.colors.onSurfaceVariant),
                    const Gap(Insets.sm),
                    Expanded(
                      child: Text(
                        data.email,
                        style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (data.gender != null || data.dob != null) ...[
                  const Gap(Insets.xxs),
                  Row(
                    children: [
                      if (data.gender != null) ...[
                        Icon(HIStroke.userCircle02, size: 12, color: context.colors.onSurfaceVariant),
                        const Gap(Insets.xs),
                        Text(
                          data.gender!.titleCase,
                          style: context.text.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                        ),
                      ],
                      if (data.gender != null && data.dob != null) ...[
                        const Gap(Insets.sm),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(color: context.colors.outlineVariant, shape: BoxShape.circle),
                        ),
                        const Gap(Insets.sm),
                      ],
                      if (data.dob != null) ...[
                        Icon(HIStroke.calendar01, size: 12, color: context.colors.onSurfaceVariant),
                        const Gap(Insets.xs),
                        Text(
                          data.dob!,
                          style: context.text.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                        ),
                      ],
                    ],
                  ),
                ],
                const Gap(Insets.xs),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                    color: context.colors.primaryContainer,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    data.role.name.titleCase,
                    style: context.text.labelSmall?.letterSpace(.5).textColor(context.colors.onPrimaryContainer),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
