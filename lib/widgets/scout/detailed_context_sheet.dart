import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Bottom sheet for detailed context about scout events
class DetailedContextSheet extends StatefulWidget {
  final VoidCallback onConfirm;
  final ValueChanged<bool>? onPressureChanged;
  final ValueChanged<bool>? onProgressiveChanged;
  final ValueChanged<bool>? onLineBreakChanged;
  final ValueChanged<String>? onNoteChanged;

  const DetailedContextSheet({
    Key? key,
    required this.onConfirm,
    this.onPressureChanged,
    this.onProgressiveChanged,
    this.onLineBreakChanged,
    this.onNoteChanged,
  }) : super(key: key);

  @override
  State<DetailedContextSheet> createState() => _DetailedContextSheetState();
}

class _DetailedContextSheetState extends State<DetailedContextSheet> {
  bool underPressure = false;
  bool progressive = false;
  bool lineBreak = false;
  String notes = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Detalhes do Evento',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text('Sob Pressão'),
              value: underPressure,
              onChanged: (val) {
                setState(() {
                  underPressure = val ?? false;
                  widget.onPressureChanged?.call(underPressure);
                });
              },
              activeColor: AppTheme.primaryGreen,
              checkColor: AppTheme.backgroundDark,
            ),
            CheckboxListTile(
              title: const Text('Progressivo'),
              value: progressive,
              onChanged: (val) {
                setState(() {
                  progressive = val ?? false;
                  widget.onProgressiveChanged?.call(progressive);
                });
              },
              activeColor: AppTheme.primaryGreen,
              checkColor: AppTheme.backgroundDark,
            ),
            CheckboxListTile(
              title: const Text('Quebra de Linha'),
              value: lineBreak,
              onChanged: (val) {
                setState(() {
                  lineBreak = val ?? false;
                  widget.onLineBreakChanged?.call(lineBreak);
                });
              },
              activeColor: AppTheme.primaryGreen,
              checkColor: AppTheme.backgroundDark,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Adicionar nota (opcional)',
                filled: true,
                fillColor: AppTheme.backgroundDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppTheme.primaryBlue),
                ),
              ),
              maxLines: 3,
              style: const TextStyle(color: AppTheme.textPrimary),
              onChanged: (val) {
                notes = val;
                widget.onNoteChanged?.call(val);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: widget.onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: AppTheme.backgroundDark,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Confirmar',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
