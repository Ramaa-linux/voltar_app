import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voltar/models/learning_step.dart';
import 'package:voltar/repositories/materi_repository.dart';
import 'package:voltar/theme/app_colors.dart';
import 'package:voltar/pages/materi/detail/materi_detail_view.dart';

/// Provider untuk repository materi (singleton).
final materiRepositoryProvider = Provider<MateriRepository>((ref) {
  return const MateriRepository();
});

/// FutureProvider untuk satu learning step berdasarkan ID.
final stepDetailProvider = FutureProvider.family<LearningStep, String>((ref, stepId) async {
  final repo = ref.watch(materiRepositoryProvider);
  return repo.getStepById(stepId);
});

/// Halaman detail materi dengan renderer dinamis untuk blok konten.
class MateriDetailPage extends ConsumerWidget {
  const MateriDetailPage({super.key, required this.stepId});

  final String stepId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<LearningStep> stepAsync = ref.watch(stepDetailProvider(stepId));
    // Level number dari query parameter (default 1).
    final int levelNumber = int.tryParse(
      GoRouterState.of(context).uri.queryParameters['level'] ?? '1') ?? 1;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: stepAsync.when(
        data: (LearningStep step) => MateriDetailView(step: step, levelNumber: levelNumber),
        loading: () => const _MateriDetailLoadingView(),
        error: (Object error, StackTrace stack) => _MateriDetailErrorView(error: error),
      ),
    );
  }
}

class _MateriDetailLoadingView extends StatelessWidget {
  const _MateriDetailLoadingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: const SafeArea(
        bottom: false,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _MateriDetailErrorView extends StatelessWidget {
  const _MateriDetailErrorView({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Gagal memuat materi', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => Navigator.of(context).maybePop(),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}