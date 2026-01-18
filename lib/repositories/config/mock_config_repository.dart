import 'package:futly_scout/repositories/config/i_config_repository.dart';
import 'package:futly_scout/models/weights_template.dart';
import 'package:futly_scout/data/mock_data.dart';

/// Mock implementation of IConfigRepository for offline-first testing
class MockConfigRepository implements IConfigRepository {
  final List<WeightsTemplate> _templates = List.from(MockData.mockTemplates);

  @override
  Future<List<WeightsTemplate>> getTemplates() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return List.from(_templates);
  }

  @override
  Future<WeightsTemplate?> getTemplateById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      return _templates.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveTemplate(WeightsTemplate template) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final index = _templates.indexWhere((t) => t.id == template.id);
    if (index != -1) {
      _templates[index] = template;
    } else {
      _templates.add(template);
    }
  }
}
