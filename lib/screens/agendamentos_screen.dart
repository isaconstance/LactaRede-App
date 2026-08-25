import 'package:flutter/material.dart';

class AgendamentosScreen extends StatefulWidget {
  const AgendamentosScreen({Key? key}) : super(key: key);

  @override
  State<AgendamentosScreen> createState() => _AgendamentosScreenState();
}

class _AgendamentosScreenState extends State<AgendamentosScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> proximos = [
    {
      "titulo": "Banco de Leite Humano",
      "local": "Hospital Santa Maria",
      "status": "Confirmado",
      "data": "Segunda, 26/05/2025 às 09:00",
      "endereco": "Av. Central, 123 · Centro · 2,3 km",
    },
    {
      "titulo": "Posto de Coleta - Maternidade",
      "local": "Maternidade Esperança",
      "status": "Pendente",
      "data": "Quarta, 28/05/2025 às 14:30",
      "endereco": "Rua das Flores, 45 · Centro · 3,1 km",
    },
  ];

  final List<Map<String, dynamic>> passados = [
    {
      "titulo": "Banco de Leite Humano",
      "local": "Hospital São Lucas",
      "status": "Finalizado",
      "data": "Segunda, 12/05/2025 às 10:00",
      "endereco": "Av. Paulista, 500 · Bela Vista · 5,0 km",
    },
  ];

  final List<Map<String, dynamic>> cancelados = [
    {
      "titulo": "Posto de Coleta - UBS",
      "local": "UBS Jardim Esperança",
      "status": "Cancelado",
      "data": "Quarta, 15/05/2025 às 15:00",
      "endereco": "Rua Verde, 100 · Jardim · 4,2 km",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Confirmado":
        return Colors.green;
      case "Pendente":
        return Colors.orange;
      case "Cancelado":
        return Colors.red;
      case "Finalizado":
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  Widget _buildCard(Map<String, dynamic> ag) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ag["titulo"],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(ag["local"], style: const TextStyle(color: Colors.black54)),
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.circle, size: 12, color: _statusColor(ag["status"])),
                const SizedBox(width: 6),
                Text(
                  ag["status"],
                  style: TextStyle(
                    color: _statusColor(ag["status"]),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(ag["data"]),
            Text(ag["endereco"]),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // ação de ver detalhes
                  },
                  child: const Text("Ver detalhes"),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // ação de cancelar
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus agendamentos"),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Próximos"),
            Tab(text: "Passados"),
            Tab(text: "Cancelados"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(children: proximos.map(_buildCard).toList()),
          ListView(children: passados.map(_buildCard).toList()),
          ListView(children: cancelados.map(_buildCard).toList()),
        ],
      ),
    );
  }
}
