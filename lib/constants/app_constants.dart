/// Constants and domain data for Futly Scout application.

class AppConstants {
  // Prevent instantiation
  AppConstants._();

  // Positions mapping: code -> PT-BR label
  static const Map<String, String> positionLabels = {
    'GOL': 'Goleiro',
    'ZAG': 'Zagueiro',
    'LD': 'Lateral Direito',
    'LE': 'Lateral Esquerdo',
    'ALA': 'Ala',
    'VOL': 'Volante',
    'MC': 'Meia Central',
    'MEI': 'Meia Ofensivo',
    'PD': 'Ponta Direita',
    'PE': 'Ponta Esquerda',
    'SA': 'Segundo Atacante',
    'ATA': 'Centroavante',
  };

  static const List<String> positionCodes = [
    'GOL',
    'ZAG',
    'LD',
    'LE',
    'ALA',
    'VOL',
    'MC',
    'MEI',
    'PD',
    'PE',
    'SA',
    'ATA'
  ];

  // Roles by category
  static const Map<String, List<String>> rolesByCategory = {
    'Defesa': [
      'Zagueiro Rebatedor',
      'Zagueiro Construtor',
      'Líbero',
      'Lateral Defensivo',
      'Ala Ofensivo',
      'Lateral Invertido'
    ],
    'Meio-Campo': [
      'Primeiro Volante (Cão de Guarda)',
      'Segundo Volante',
      'Box-to-Box',
      'Criador Recuado (Deep-lying playmaker)',
      'Meia Clássico (10)'
    ],
    'Ataque': [
      'Ponta Construtor',
      'Ponta de Velocidade',
      'Falso 9',
      'Pivô',
      'Atacante de Área',
      'Atacante de Mobilidade'
    ],
  };

  // Scout actions by category
  static const Map<String, List<String>> scoutActions = {
    'Com Bola': [
      'Passe Curto',
      'Passe Longo/Lançamento',
      'Passe em Ruptura (Assistência)',
      'Cruzamento',
      'Finalização (No Alvo)',
      'Finalização (Fora)',
      'Drible',
    ],
    'Sem Bola': [
      'Desarme',
      'Interceptação',
      'Duelo Aéreo (Ganho)',
      'Duelo Aéreo (Perdido)',
      'Bloqueio',
      'Pressão',
      'Recuperação de Posse',
    ],
    'Negativos': [
      'Perda de Posse',
      'Falta Cometida',
      'Cartão Amarelo',
      'Cartão Vermelho',
      'Impedimento',
    ],
  };

  // Evaluation criteria grouped by category
  static const Map<String, List<String>> evaluationCriteria = {
    'Técnica': [
      'Controle',
      'Passe',
      'Finalização',
      'Cabeceio',
      'Marcação',
    ],
    'Tática': [
      'Posicionamento',
      'Visão de Jogo',
      'Tomada de Decisão',
      'Leitura de Espaço',
    ],
    'Física': [
      'Velocidade',
      'Aceleração',
      'Força',
      'Impulsão',
      'Resistência',
    ],
    'Mental': [
      'Agressividade',
      'Concentração',
      'Liderança',
      'Bravura',
    ],
  };

  // Positive traits
  static const List<String> positiveTraits = [
    'Boa saída',
    'Passe progressivo',
    'Forte no aéreo',
    'Bom sob pressão',
    'Boa leitura defensiva',
    'Ótima aceleração',
    'Excelente visão',
    'Muito criativo',
    'Forte fisicamente',
    'Velocidade de elite',
  ];

  // Negative traits
  static const List<String> negativeTraits = [
    'Lento na transição',
    'Baixa agressividade',
    'Erra passes simples',
    'Decisão precipitada',
    'Marcação fraca',
    'Vulnerável no um-contra-um',
    'Pouca intensidade',
    'Falta de concentração',
    'Posicionamento ruim',
    'Fraco no aéreo',
  ];

  // Dominant foot
  static const List<String> dominantFeet = ['Destro', 'Canhoto', 'Ambidestro'];

  // Player categories
  static const List<String> playerCategories = [
    'Sub-20',
    'Profissional',
    'Sub-17',
    'Sub-23'
  ];

  // Alert severity levels
  static const List<String> alertSeverities = ['LOW', 'MEDIUM', 'HIGH'];

  // Scout event categories
  static const List<String> eventCategories = ['BALL', 'OFF_BALL', 'NEGATIVE'];

  // Sync states for UI display
  static const String syncStateOffline = 'Offline';
  static const String syncStateSyncing = 'Sincronizando...';
  static const String syncStateSynced = 'Sincronizado';

  // Default weights for new templates (0-10 scale)
  static const Map<String, double> defaultWeightsByPosition = {
    // Técnica weights
    'Controle': 7.0,
    'Passe': 8.0,
    'Finalização': 6.0,
    'Cabeceio': 5.0,
    'Marcação': 5.0,
    // Tática weights
    'Posicionamento': 8.0,
    'Visão de Jogo': 7.0,
    'Tomada de Decisão': 8.0,
    'Leitura de Espaço': 7.0,
    // Física weights
    'Velocidade': 6.0,
    'Aceleração': 7.0,
    'Força': 6.0,
    'Impulsão': 5.0,
    'Resistência': 7.0,
    // Mental weights
    'Agressividade': 6.0,
    'Concentração': 8.0,
    'Liderança': 5.0,
    'Bravura': 6.0,
  };

  /// Get label for position code
  static String getPositionLabel(String code) =>
      positionLabels[code] ?? code;

  /// Get all criteria for all categories
  static List<String> getAllCriteria() {
    final criteria = <String>[];
    evaluationCriteria.forEach((_, items) {
      criteria.addAll(items);
    });
    return criteria;
  }

  /// Get category for a criteria
  static String? getCategoryForCriteria(String criteria) {
    for (final entry in evaluationCriteria.entries) {
      if (entry.value.contains(criteria)) {
        return entry.key;
      }
    }
    return null;
  }
}
