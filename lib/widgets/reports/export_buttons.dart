import 'package:flutter/material.dart';
import 'package:futly_scout/constants/app_theme.dart';

/// Export buttons for reports
class ExportButtons extends StatelessWidget {
  final VoidCallback onExportPDF;
  final VoidCallback onExportCSV;
  final VoidCallback onExportPresentation;

  const ExportButtons({
    Key? key,
    required this.onExportPDF,
    required this.onExportCSV,
    required this.onExportPresentation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton.icon(
          onPressed: onExportPDF,
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text('PDF'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.errorRed,
          ),
        ),
        ElevatedButton.icon(
          onPressed: onExportCSV,
          icon: const Icon(Icons.table_chart),
          label: const Text('CSV'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryBlue,
          ),
        ),
        ElevatedButton.icon(
          onPressed: onExportPresentation,
          icon: const Icon(Icons.slideshow),
          label: const Text('Apresentação'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.warningAmber,
          ),
        ),
      ],
    );
  }
}
