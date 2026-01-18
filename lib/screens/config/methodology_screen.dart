import 'package:flutter/material.dart';
import 'package:futly_scout/environment/app_environment.dart';
import 'package:futly_scout/constants/app_theme.dart';
import 'package:futly_scout/widgets/common/app_scaffold.dart';
import 'package:futly_scout/routes/app_routes.dart'; // Importante para o logout

/// Methodology/templates management screen
class MethodologyScreen extends StatefulWidget {
  const MethodologyScreen({Key? key}) : super(key: key);

  @override
  State<MethodologyScreen> createState() => _MethodologyScreenState();
}

class _MethodologyScreenState extends State<MethodologyScreen> {
  bool _showCreateForm = false;
  final _templateNameController = TextEditingController();
  String _selectedPosition = 'GOL';
  String _selectedRole = 'Defesa';
  final Map<String, double> _weights = {};

  @override
  void dispose() {
    _templateNameController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _templateNameController.clear();
    _selectedPosition = 'GOL';
    _selectedRole = 'Defesa';
    _weights.clear();
    setState(() => _showCreateForm = false);
  }

  Future<void> _saveTemplate() async {
    if (_templateNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o nome do modelo')),
      );
      return;
    }

    // Create template (Mock)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Modelo salvo com sucesso')),
    );
    _resetForm();
    setState(() {});
  }

  // --- FUNÇÃO DE LOGOUT ---
  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark,
        title:
            const Text('Sair da Conta', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Tem certeza que deseja desconectar?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Fecha o diálogo
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fecha o diálogo
              // Redireciona para o Login e remove todas as rotas anteriores
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.login,
                (route) => false,
              );
            },
            child:
                const Text('Sair', style: TextStyle(color: AppTheme.errorRed)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Metodologia',
      showAppBar: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header e Lista de Modelos
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Modelos de Avaliação',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() => _showCreateForm = true);
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Novo'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    FutureBuilder(
                      future: AppEnvironment.configRepository.getTemplates(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        final templates = snapshot.data ?? [];
                        if (templates.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Nenhum modelo criado ainda'),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: templates.length,
                          itemBuilder: (context, index) {
                            final template = templates[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(template.name),
                                subtitle: Text(
                                  '${template.positionCode} • ${template.roleName}',
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Editar modelo: ${template.name}',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Formulário de Criação (se aberto)
              if (_showCreateForm)
                Container(
                  color: AppTheme.surfaceDark,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Criar Novo Modelo',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: _templateNameController,
                        decoration: const InputDecoration(
                          hintText: 'Nome do modelo (ex: Volante Sub-20)',
                        ),
                      ),
                      // ... (Resto dos campos do formulário mantidos iguais) ...
                      const SizedBox(height: 12),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedPosition,
                        items: [
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
                        ]
                            .map((p) =>
                                DropdownMenuItem(value: p, child: Text(p)))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedPosition = value ?? 'GOL');
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedRole,
                        items: ['Defesa', 'Meio-Campo', 'Ataque']
                            .map((r) =>
                                DropdownMenuItem(value: r, child: Text(r)))
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedRole = value ?? 'Defesa');
                        },
                      ),
                      const SizedBox(height: 16),
                      Text('Critérios de Avaliação',
                          style: Theme.of(context).textTheme.titleSmall),
                      const SizedBox(height: 12),
                      ...['Técnica', 'Tática', 'Física', 'Mental']
                          .map((criterion) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(criterion),
                                      Text(
                                        '${(_weights[criterion] ?? 5).toInt()}/10',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.primaryGreen),
                                      ),
                                    ],
                                  ),
                                  Slider(
                                    min: 0,
                                    max: 10,
                                    value: _weights[criterion] ?? 5,
                                    onChanged: (value) {
                                      setState(() {
                                        _weights[criterion] = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ))
                          .toList(),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _resetForm,
                              child: const Text('Cancelar'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _saveTemplate,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryGreen),
                              child: const Text('Salvar Modelo'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              // --- BOTÃO DE LOGOUT ---
              const SizedBox(height: 4), // Espaço antes do botão
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: OutlinedButton.icon(
                  onPressed: _handleLogout,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.errorRed, // Texto vermelho
                    side: const BorderSide(
                        color: AppTheme.errorRed), // Borda vermelha
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Sair da Conta'),
                ),
              ),
              const SizedBox(height: 24), // Espaço extra no final
            ],
          ),
        ),
      ),
    );
  }
}
