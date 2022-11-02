import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../services/file_service.dart';

class FileWidget extends StatefulWidget {
  String? urlImagem;
  String? destino;
  FileWidget({super.key, required this.urlImagem, required this.destino});

  @override
  State<FileWidget> createState() => _FileWidgetState();
}

class _FileWidgetState extends State<FileWidget> {
  UploadTask? task;
  File? file;
  @override
  Widget build(BuildContext context) {
    return fieldPhoto();
  }

  fieldPhoto() {
    return Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          GestureDetector(
              onTap: () => selectFile(),
              child: Container(
                  width: 130,
                  height: 130,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: widget.urlImagem != null && widget.urlImagem != ''
                      ? Image.network(widget.urlImagem as String,
                          fit: BoxFit.cover)
                      : ContainerImagem())),
          task != null ? buildUploadStatus(task!) : Container()
        ]));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      uploadFile();
    });
  }

  Future uploadFile() async {
    if (file == null) return;

    final String destination;
    var id = DateTime.now().millisecondsSinceEpoch;

    if (widget.urlImagem != "") {
      destination = widget.urlImagem.toString();
    } else {
      destination = "${widget.destino}/${id}";
    }

    task = FileService.uploadFile(destination, file!);

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    widget.urlImagem = urlDownload;
    setState(() {});
  }

  Container ContainerImagem() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.12,
        child: Icon(Icons.add_a_photo,
            size: 100,
            color: Theme.of(context).primaryColor.withOpacity(0.85)));
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100);

            if (percentage < 100.0) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(strokeWidth: 10));
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      );
}
