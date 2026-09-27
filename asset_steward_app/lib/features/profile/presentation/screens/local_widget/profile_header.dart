import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

import '../../../data/models/profile_data.dart';

class ProfileHeader extends ConsumerWidget {
  final ProfileData data;

  const ProfileHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orgAsync = ref.watch(organizationCtrlProvider);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Insets.sm,
        horizontal: Insets.md,
      ),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      child: Column(
        children: [
          _ProfileInfo(data: data),

          AsyncBuilder(
            asyncValue: orgAsync,
            providers: [organizationCtrlProvider],
            onLoading: () => const SizedBox.shrink(),
            onError: (e, s) => const SizedBox.shrink(),
            builder: (org) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(Insets.sm),
                  const Divider(height: 0),
                  const Gap(Insets.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        spacing: Insets.xs,
                        children: [
                          Expanded(
                            child: SelectableText(
                              org.name,
                              style: context.text.titleMedium?.bold.textHeight(
                                1,
                              ),
                              maxLines: 1,
                            ),
                          ),

                          _RoleChip(role: data.role.name.titleCase),
                        ],
                      ),
                      if (org.email != null) ...[
                        const Gap(Insets.xs),
                        Row(
                          children: [
                            Icon(
                              HIStroke.mail01,
                              size: 13,
                              color: context.colors.outline,
                            ),
                            const Gap(Insets.sm),
                            Expanded(
                              child: SelectableText(
                                org.email!,
                                style: context.text.bodySmall?.textColor(
                                  context.colors.outline,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ],
                      if (org.phone != null || org.location != null) ...[
                        const Gap(Insets.xxs),
                        Row(
                          children: [
                            if (org.phone != null) ...[
                              Icon(
                                HIStroke.holdPhone,
                                size: 12,
                                color: context.colors.outline,
                              ),
                              const Gap(Insets.xs),
                              SelectableText(
                                org.phone!,
                                maxLines: 1,
                                style: context.text.bodySmall?.textColor(
                                  context.colors.outline,
                                ),
                              ),
                            ],
                            if (org.phone != null && org.location != null) ...[
                              const Gap(Insets.sm),
                              Icon(
                                Icons.circle,
                                size: 5,
                                color: context.colors.outline,
                              ),
                              const Gap(Insets.sm),
                            ],
                            if (org.location != null) ...[
                              Icon(
                                HIStroke.location01,
                                size: 12,
                                color: context.colors.outline,
                              ),
                              const Gap(Insets.xs),
                              Expanded(
                                child: SelectableText(
                                  org.location!,
                                  style: context.text.bodySmall?.textColor(
                                    context.colors.outline,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const new({required this.data});

  final ProfileData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: context.colors.primary.op(0.2), width: 2),
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: context.colors.primaryContainer,
            backgroundImage: data.profilePicture != null
                ? NetworkImage(data.profilePicture!)
                : null,
            child: data.profilePicture == null
                ? Text(
                    '${data.firstname[0]}${data.lastname[0]}',
                    style: context.text.headlineMedium?.copyWith(
                      color: context.colors.onPrimaryContainer,
                    ),
                  )
                : null,
          ),
        ),
        const Gap(Insets.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisAlignment: .center,
            children: [
              SelectableText(
                '${data.firstname} ${data.lastname}',
                style: context.text.titleMedium?.bold,
                maxLines: 1,
              ),
              Row(
                children: [
                  Icon(
                    HIStroke.mail01,
                    size: 13,
                    color: context.colors.outline,
                  ),
                  const Gap(Insets.sm),
                  Expanded(
                    child: SelectableText(
                      data.email,
                      style: context.text.bodySmall?.textColor(
                        context.colors.outline,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              if (data.gender != null || data.dob != null) ...[
                const Gap(Insets.xxs),
                Row(
                  children: [
                    if (data.gender != null) ...[
                      Icon(
                        HIStroke.userCircle02,
                        size: 12,
                        color: context.colors.outline,
                      ),
                      const Gap(Insets.xs),
                      Text(
                        data.gender!.titleCase,
                        style: context.text.bodySmall?.textColor(
                          context.colors.outline,
                        ),
                      ),
                    ],
                    if (data.gender != null && data.dob != null) ...[
                      const Gap(Insets.sm),
                      Icon(
                        Icons.circle,
                        size: 5,
                        color: context.colors.outline,
                      ),
                      const Gap(Insets.sm),
                    ],
                    if (data.dob != null) ...[
                      Icon(
                        HIStroke.calendar01,
                        size: 12,
                        color: context.colors.outline,
                      ),
                      const Gap(Insets.xs),
                      Text(
                        data.dob!,
                        style: context.text.bodySmall?.textColor(
                          context.colors.outline,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _RoleChip extends StatelessWidget {
  const new({required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: context.colors.primaryContainer,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        role,
        style: context.text.labelSmall
            ?.letterSpace(.5)
            .textColor(context.colors.onPrimaryContainer),
      ),
    );
  }
}
