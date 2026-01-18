import 'package:futly_scout/models/weights_template.dart';

/// Interface for configuration/templates repository
abstract class IConfigRepository {
  Future<List<WeightsTemplate>> getTemplates();

  Future<WeightsTemplate?> getTemplateById(String id);

  Future<void> saveTemplate(WeightsTemplate template);
}
