import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Agendamento confirmado",
      "subtitle": "Sua coleta foi agendada para 25/09/2026 às 14h00",
      "icon": Icons.event_available,
      "read": false,
    },
    {
      "title": "Triagem aprovada",
      "subtitle":
          "Você preencheu os requisitos para doar leite materno. Agradecemos muito por querer ajudar!",
      "icon": Icons.check_circle,
      "read": true,
    },
    {
      "title": "Sua doação faz a diferença",
      "subtitle":
          "O leite doado por você pode ajudar até 10 bebês prematuros por dia.",
      "icon": Icons.favorite,
      "read": false,
    },
    {
      "title": "Pontos de coleta próximo",
      "subtitle":
          "Há um ponto de coleta novo perto de você. Confira a localização.",
      "icon": Icons.location_on,
      "read": true,
    },
    {
      "title": "Atualização do aplicativo",
      "subtitle":
          "Uma nova versão do LactaRede está disponível. Atualize agora!",
      "icon": Icons.system_update,
      "read": true,
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

  List<Map<String, dynamic>> _filterNotifications(int index) {
    if (index == 1) {
      return notifications.where((n) => !n["read"]).toList();
    } else if (index == 2) {
      return notifications.where((n) => n["read"]).toList();
    }
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Notificações"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Todas"),
            Tab(text: "Não lidas"),
            Tab(text: "Lidas"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(3, (index) {
          final filtered = _filterNotifications(index);
          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final notif = filtered[i];
              return Card(
                child: ListTile(
                  leading: Icon(notif["icon"], color: Colors.blue),
                  title: Text(notif["title"]),
                  subtitle: Text(notif["subtitle"]),
                  trailing: notif["read"]
                      ? const Icon(
                          Icons.mark_email_read,
                          color: Colors.blueGrey,
                        )
                      : const Icon(Icons.mark_email_unread, color: Colors.blue),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
