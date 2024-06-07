// ignore_for_file: library_private_types_in_public_api

import 'package:astronomy_picture_of_the_day/src/models/apod_model.dart';
import 'package:astronomy_picture_of_the_day/src/views/apod_detail.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../controllers/apod_controller.dart';
class APODList extends StatefulWidget {
  const APODList({super.key});

  @override
  _APODListState createState() => _APODListState();
}

class _APODListState extends State<APODList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });

    Provider.of<APODController>(context, listen: false).fetchAPODs(
      List.generate(30, (index) => DateTime.now().subtract(Duration(days: index)).toIso8601String().split('T').first)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Imagem Astronômica do Dia"),
      ),
      body: Consumer<APODController>(
        builder: (context, apodController, child) {
          if (apodController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          List<APODModel> filteredAPODs = apodController.apods.where((apod) {
            return apod.title.toLowerCase().contains(_searchText.toLowerCase()) ||
                apod.date.contains(_searchText);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: "Pesquisar por título ou data",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredAPODs.length,
                  itemBuilder: (context, index) {
                    final apod = filteredAPODs[index];
                    return ListTile(
                      title: Text(apod.title),
                      subtitle: Text(apod.date),
                      leading: CachedNetworkImage(
                        imageUrl: apod.url,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => APODDetail(apod: apod),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
