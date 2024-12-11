import 'package:flutter/material.dart';
import 'package:stargroup/api/lib/api.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Pet>? pets;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchPets();
  }

  Future<void> _fetchPets() async {
    try {
      // Initialize the API client
      final apiClient = ApiClient(
        basePath:
            'https://petstore3.swagger.io/api/v3', // Removed trailing slash
      );

      // Create an instance of the API
      final petApi = PetApi(apiClient);

      // Make the API call
      final result = await petApi.findPetsByStatus(
        status: "available",
      );

      setState(() {
        pets = result;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
      print('Error fetching pets: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Pet Store Demo'),
        ),
        body: Center(
          child: error != null
              ? Text('Error: $error')
              : pets == null
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: pets!.length,
                      itemBuilder: (context, index) {
                        final pet = pets![index];
                        return ListTile(
                          title: Text(pet.name ?? 'Unnamed Pet'),
                          subtitle: Text('Status: ${pet.status ?? "Unknown"}'),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
