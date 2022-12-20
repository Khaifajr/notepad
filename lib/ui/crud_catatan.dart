import 'package:flutter/material.dart';
import 'package:notepad/model/catatan.dart';
import 'package:notepad/bloc/produk_bloc.dart';
import 'package:notepad/ui/page_catatan.dart';
import 'package:notepad/widget/warning_dialog.dart';

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
        _titleTextboxController.text = widget.catatan!.title!;
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
                ubah();
              } else {
                //kondisi tambah produk
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Catatan createProduk = Catatan(konten: null);
    createProduk.title = _titleTextboxController.text;
    createProduk.konten = _kontenTextboxController.text;
    ProdukBloc.addProduk(catatan: createProduk).then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => PageCatatan()));
    }, onError: (error) {
      showDialog(
          context: this.context,
          builder: (BuildContext context) => WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Catatan updateProduk = new Catatan();
    updateProduk.id = widget.catatan!.id;
    updateProduk.title = _titleTextboxController.text;
    updateProduk.konten = _kontenTextboxController.text;
    ProdukBloc.updateProduk(catatan: updateProduk).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const PageCatatan()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
                okClick: () {},
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
