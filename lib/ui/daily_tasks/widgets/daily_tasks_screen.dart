import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toeic/ui/daily_tasks/view_models/daily_tasks_state.dart';
import 'package:toeic/ui/daily_tasks/view_models/daily_tasks_view_model.dart';
import 'package:toeic/ui/daily_tasks/widgets/daily_task_card.dart';
import 'package:toeic/utils/app_colors.dart';

class DailyTasksScreen extends ConsumerStatefulWidget {
  final String userId;
  
  const DailyTasksScreen({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<DailyTasksScreen> createState() => _DailyTasksScreenState();
}

class _DailyTasksScreenState extends ConsumerState<DailyTasksScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(dailyTasksProvider(widget.userId).notifier).loadDailyTasks());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dailyTasksProvider(widget.userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nhiệm vụ hàng ngày'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.primary,
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null
              ? Center(child: Text(state.errorMessage!))
              : Column(
                  children: [
                    _buildProgressCard(state),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return DailyTaskCard(
                            task: task,
                            onComplete: () {
                              ref
                                  .read(dailyTasksProvider(widget.userId).notifier)
                                  .completeTask(task.id);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildProgressCard(DailyTasksState state) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Tiến độ hôm nay',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: state.totalTasks > 0
                  ? state.completedTasks / state.totalTasks
                  : 0,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${state.completedTasks}/${state.totalTasks} nhiệm vụ',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '${state.experiencePoints} XP',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 