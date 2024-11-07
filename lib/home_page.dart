import 'package:api_integration/load_data.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  void _show(int? id) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: 'id',
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'name',
                  ),
                ),
                TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: 'comment',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (id == null) {
                      await LoadData().postData(
                        id: int.parse(_idController.text),
                        name: _nameController.text,
                        comments: _commentController.text,
                      );
                    } else {
                      await LoadData().updateData(
                        id: id,
                        name: _nameController.text,
                        comments: _commentController.text,
                      );
                    }
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'send data',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _show(null);
      }),
      body: FutureBuilder(
          future: LoadData.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final dm_2 = snapshot.data;
            return ListView(
              physics: const ScrollPhysics(),
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: dm_2!.length,
                  itemBuilder: (context, index) {
                    final dm_3 = dm_2[index];
                    return GestureDetector(
                      onLongPress: () {
                        _show(dm_3.id);
                      },
                      onTap: () {
                        LoadData().deleteData(id: dm_3.id);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.amber,
                        ),
                        child: Column(
                          children: [
                            Text(dm_3.name),
                            Text(dm_3.comments),
                            Text(dm_3.createdAt.toString()),
                            Text(dm_3.id.toString()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }),
    );
  }
}

// https://softcodix.pythonanywhere.com/api/serviceprovider/
