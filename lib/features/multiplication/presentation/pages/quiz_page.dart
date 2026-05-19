import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/multiplication_provider.dart';

class QuizPage extends ConsumerWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multiplicationProvider);
    final operation = state.currentOperation;

    if (operation == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildScoreBoard(state.correctCount, state.incorrectCount),
              const Spacer(),
              _buildQuestion(operation.questionText),
              const SizedBox(height: 48),
              _buildAnswersGrid(operation.allAnswers, state, ref),
              const Spacer(),
              if (state.isCorrect != null) _buildNextButton(ref),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBoard(int correct, int incorrect) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildScoreChip('✓ $correct', Colors.green),
        const SizedBox(width: 16),
        _buildScoreChip('✗ $incorrect', Colors.red),
      ],
    );
  }

  Widget _buildScoreChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Text(
        question,
        style: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildAnswersGrid(
    List<int> answers,
    MultiplicationState state,
    WidgetRef ref,
  ) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: answers.map((answer) {
        return _buildAnswerButton(answer, state, ref);
      }).toList(),
    );
  }

  Widget _buildAnswerButton(
    int answer,
    MultiplicationState state,
    WidgetRef ref,
  ) {
    final isSelected = state.selectedAnswer == answer;
    final isCorrectAnswer = state.currentOperation?.correctAnswer == answer;
    final showResult = state.selectedAnswer != null;

    Color backgroundColor = Colors.white;
    Color borderColor = const Color(0xFFE0E0E0);
    Color textColor = const Color(0xFF333333);

    if (showResult) {
      if (isCorrectAnswer) {
        backgroundColor = Colors.green;
        borderColor = Colors.green;
        textColor = Colors.white;
      } else if (isSelected && !isCorrectAnswer) {
        backgroundColor = Colors.red;
        borderColor = Colors.red;
        textColor = Colors.white;
      }
    }

    return GestureDetector(
      onTap: state.selectedAnswer == null
          ? () => ref.read(multiplicationProvider.notifier).selectAnswer(answer)
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 140,
        height: 100,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 3),
          boxShadow: isSelected && !showResult
              ? [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            '$answer',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton(WidgetRef ref) {
    return Column(
      children: [
        if (ref.read(multiplicationProvider).isCorrect == true)
          const Icon(Icons.check_circle, color: Colors.green, size: 48)
        else
          const Icon(Icons.cancel, color: Colors.red, size: 48),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () =>
              ref.read(multiplicationProvider.notifier).nextQuestion(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            'Siguiente',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}