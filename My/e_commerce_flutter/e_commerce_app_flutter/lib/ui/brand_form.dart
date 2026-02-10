import 'dart:io';

import 'package:e_commerce_app_flutter/models/brand.dart';
import 'package:e_commerce_app_flutter/services/brand_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BrandFormPage extends StatefulWidget {
  final Brand? brand; // 👈 optional (null = create)

  const BrandFormPage({super.key, this.brand});

  @override
  State<BrandFormPage> createState() => _BrandFormPageState();
}

class _BrandFormPageState extends State<BrandFormPage> {
  final _formKey = GlobalKey<FormState>();
  final api = BrandService();

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  // final imageCtrl = TextEditingController();
  File? _image;

  bool active = true;
  bool loading = false;

  
  bool get isEdit => widget.brand != null;

  // ========================
  // Pick Image (Camera / Gallery)
  // ========================
  Future<void> _pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.photo_camera),
            label: const Text('Camera'),
            onPressed: () => Navigator.pop(ctx, ImageSource.camera),
          ),
          TextButton.icon(
            icon: const Icon(Icons.photo_library),
            label: const Text('Gallery'),
            onPressed: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (source != null) {
      final picked = await ImagePicker().pickImage(source: source);
      if (picked != null) setState(() => _image = File(picked.path));
    }
  }

  @override
  void initState() {
    super.initState();

    // Prefill fields if editing
    final b = widget.brand;
    if (b != null) {
      nameCtrl.text = b.name;
      descCtrl.text = b.description ?? '';
      if (b.logoUrl != null) _image = File(b.logoUrl!);
    }
  }

  void submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      final brand = Brand(
        id: widget.brand?.id,
        name: nameCtrl.text,
        description: descCtrl.text,
        logoUrl: _image != null ? _image!.path : '',
      );

      if (isEdit) {
        await api.updateBrand(brand.id!, brand);
      } else {
        await api.createBrand(brand.name, brand.description ?? '', _image);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEdit ? "✏️ Brand updated" : "✅ Brand created"),
        ),
      );

      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit Product" : "Add Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                  child: _image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Add Image",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                ),
              ),
              _input(nameCtrl, "Brand Name"),
              _input(descCtrl, "Description", maxLines: 3),

              SwitchListTile(
                title: const Text("Active"),
                value: active,
                onChanged: (v) => setState(() => active = v),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: loading ? null : submit,
                  child: loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(isEdit ? "UPDATE PRODUCT" : "SAVE PRODUCT"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (v) => v == null || v.isEmpty ? "Required" : null,
      ),
    );
  }
}
