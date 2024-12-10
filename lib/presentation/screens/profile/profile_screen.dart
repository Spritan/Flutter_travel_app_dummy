import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              flexibleSpace: _buildProfileHeader(),
              actions: [
                Obx(() => IconButton(
                      icon: Icon(
                        controller.isEditing.value ? Icons.check : Icons.edit,
                      ),
                      onPressed: controller.toggleEditing,
                    )),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  _buildStatsCard(),
                  _buildPreferencesCard(),
                  _buildRecentActivityCard(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    return FlexibleSpaceBar(
      background: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade800, Colors.blue.shade500],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(controller.userData.value['avatar']),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () {
                    // TODO: Implement image picker
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Obx(() => controller.isEditing.value
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.nameController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                        ),
                        TextField(
                          controller: controller.bioController,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        controller.userData.value['name'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        controller.userData.value['bio'] ?? '',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Travel Stats',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.flight,
                  label: 'Countries',
                  value: '${controller.stats['countries']}',
                ),
                _buildStatItem(
                  icon: Icons.map,
                  label: 'Trips',
                  value: '${controller.stats['trips']}',
                ),
                _buildStatItem(
                  icon: Icons.hotel,
                  label: 'Bookings',
                  value: '${controller.stats['bookings']}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPreferencesCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Travel Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPreferenceItem(
              icon: Icons.beach_access,
              label: 'Favorite Destinations',
              value: controller.preferences['destinations'] ?? '',
              prefKey: 'destinations',
            ),
            _buildPreferenceItem(
              icon: Icons.restaurant_menu,
              label: 'Food Preferences',
              value: controller.preferences['food'] ?? '',
              prefKey: 'food',
            ),
            _buildPreferenceItem(
              icon: Icons.hotel,
              label: 'Accommodation',
              value: controller.preferences['accommodation'] ?? '',
              prefKey: 'accommodation',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required String label,
    required String value,
    String? prefKey,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                Obx(() => controller.isEditing.value && prefKey != null
                    ? TextField(
                        controller: TextEditingController(text: value),
                        onChanged: (newValue) =>
                            controller.updatePreference(prefKey, newValue),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                        ),
                      )
                    : Text(
                        value,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivityCard() {
    return const Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            // Add recent activity items here
          ],
        ),
      ),
    );
  }
}
