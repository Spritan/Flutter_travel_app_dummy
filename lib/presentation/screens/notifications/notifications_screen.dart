import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/notifications_controller.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  Color _getIconColor(String type) {
    switch (type) {
      case 'promotion':
        return Colors.orange;
      case 'alert':
        return Colors.red;
      case 'booking':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'promotion':
        return Icons.local_offer;
      case 'alert':
        return Icons.warning;
      case 'booking':
        return Icons.confirmation_number;
      default:
        return Icons.notifications;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isSearching.value
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search notifications...',
                  border: InputBorder.none,
                ),
                onChanged: controller.updateSearchQuery,
              )
            : const Text('Notifications')),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                controller.isSearching.value ? Icons.close : Icons.search)),
            onPressed: controller.toggleSearch,
          ),
        ],
      ),
      body: Obx(() {
        final notifications = controller.filteredNotifications;

        if (notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.notifications_off,
                    size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  controller.searchQuery.isEmpty
                      ? 'No notifications yet'
                      : 'No notifications found',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      _getIconColor(notification['type']).withOpacity(0.2),
                  child: Icon(
                    _getIcon(notification['type']),
                    color: _getIconColor(notification['type']),
                  ),
                ),
                title: Text(
                  notification['title'],
                  style: TextStyle(
                    fontWeight: notification['isRead']
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(notification['message']),
                    const SizedBox(height: 4),
                    Text(
                      notification['timestamp'].substring(0, 10),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                onTap: () => controller.markAsRead(notification['id']),
              ),
            );
          },
        );
      }),
    );
  }
}
