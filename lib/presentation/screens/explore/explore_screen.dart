import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/explore_controller.dart';
import '../../../data/models/travel_package.dart';
import '../../../data/models/blog_post.dart';

class ExploreScreen extends GetView<ExploreController> {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isSearching.value
            ? TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: controller.onSearchChanged,
              )
            : const Text('Explore')),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                controller.isSearching.value ? Icons.close : Icons.search)),
            onPressed: controller.toggleSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => controller.toggleView(),
                child: const Text('Travel Packages'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => controller.toggleView(),
                child: const Text('Blog Posts'),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              if (controller.showingPackages.value) {
                return ListView.builder(
                  itemCount: controller.filteredItems.length,
                  itemBuilder: (context, index) {
                    final package =
                        controller.filteredItems[index] as TravelPackage;
                    return ListTile(
                      leading: Image.network(package.imageUrl,
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(package.name),
                      subtitle: Text(package.location),
                      trailing: Text('\$${package.price.toStringAsFixed(2)}'),
                      onTap: () {
                        // TODO: Navigate to package details
                      },
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: controller.filteredItems.length,
                  itemBuilder: (context, index) {
                    final blog = controller.filteredItems[index] as BlogPost;
                    return ListTile(
                      leading: Image.network(blog.imageUrl,
                          width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(blog.title),
                      subtitle: Text(blog.excerpt),
                      onTap: () {
                        // TODO: Navigate to blog details
                      },
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
