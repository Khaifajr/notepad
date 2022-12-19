import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notepad/model/catatan.dart';
import 'package:notepad/ui/detail.catatan.dart';

class CrudCatatan extends StatefulWidget {
  Catatan? catatan;
  CrudCatatan({super.key, this.catatan});
  @override
  // ignore: library_private_types_in_public_api
  _CrudCatatanState createState() => _CrudCatatanState();
}

class _CrudCatatanState extends State<CrudCatatan> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH";
  String tombolSubmit = "SIMPAN";

  final _titleTextboxController = TextEditingController();
  final _tanggalTextboxController = TextEditingController();
  final _kontenTextboxController = TextEditingController();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (null != widget.catatan) {
      setState(() {
        judul = "UBAH CATATAN";
        tombolSubmit = "UBAH";
        _titleTextboxController.text = widget.catatan!.title;
        _kontenTextboxController.text = widget.catatan!.konten.toString();
      });
    } else {
      judul = "CATATAN BARU";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _titleTextField(),
                  _kontenTextField(),
                  _buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//Membuat Textbox Kode Produk
  Widget _titleTextField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Judul"),
        keyboardType: TextInputType.text,
        controller: _titleTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Kode Produk harus diisi";
          }
          return null;
        });
  }

  //Membuat Textbox Nama Produk
  Widget _kontenTextField() {
    return TextFormField(
        decoration: InputDecoration(labelText: "Isi"),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: _kontenTextboxController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Nama Produk harus diisi";
          }
          return null;
        });
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              // ignore: unnecessary_null_comparison
              if (widget.catatan != null) {
                //kondisi update produk
              }
            }
          }
        });
  }
}
