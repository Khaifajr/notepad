import 'package:flutter/material.dart';
import 'package:notepad/bloc/logout_bloc.dart';
import 'package:notepad/bloc/produk_bloc.dart';
import 'package:notepad/model/catatan.dart';
import 'package:notepad/ui/login_page.dart';
import 'package:notepad/ui/detail_catatan.dart';
import 'package:notepad/ui/crud_catatan.dart';

class PageCatatan extends StatefulWidget {
  const PageCatatan({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _PageCatatan createState() => _PageCatatan();
}

class _PageCatatan extends State<PageCatatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Catatan'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CrudCatatan()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListCatatan(
                  list: snapshot.data ?? [],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListCatatan extends StatelessWidget {
  final List list;
  const ListCatatan({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return ItemCatatan(
            catatan: list[i],
          );
        });
  }
}

class ItemCatatan extends StatelessWidget {
  final Catatan catatan;

  const ItemCatatan({Key? key, required this.catatan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailCatatan(
                      catatan: catatan,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(catatan.title),
          subtitle: Text(catatan.konten.toString()),
        ),
      ),
    );
  }
}
