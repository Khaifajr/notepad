import 'package:flutter/material.dart';
import 'package:notepad/model/catatan.dart';
import 'package:notepad/ui/crud_catatan.dart';
import 'package:notepad/bloc/produk_bloc.dart';
import 'package:notepad/ui/page_catatan.dart';
import 'package:notepad/widget/warning_dialog.dart';

class DetailCatatan extends StatefulWidget {
  Catatan catatan;

  DetailCatatan({required this.catatan});

  @override
  _DetailCatatanState createState() => _DetailCatatanState();
}

class _DetailCatatanState extends State<DetailCatatan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CATATAN"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Title : ${widget.catatan.title}",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Konten : ${widget.catatan.konten}",
              style: TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CrudCatatan(
                            catatan: widget.catatan,
                          )));
            }),
        //Tombol Hapus
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        ElevatedButton(
          child: const Text("Ya"),
          onPressed: () {
            ProdukBloc.deleteProduk(id: widget.catatan.id).then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const PageCatatan()));
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: ((context) => WarningDialog(
                        description: "Hapus data gagal, silahkan coba lagi",
                        okClick: () {},
                      )));
            });
          },
        ),

        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
