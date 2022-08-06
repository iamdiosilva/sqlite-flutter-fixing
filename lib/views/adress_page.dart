import 'package:crud_flutter/repositories/adress_respository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/db.dart';

class AdressPage extends StatefulWidget {
  const AdressPage({Key? key}) : super(key: key);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  late TextEditingController streetController;
  late TextEditingController neighborhoodController;
  late TextEditingController stateController;
  late AdressRepository adressRep;

  @override
  void initState() {
    super.initState();

    streetController = TextEditingController();
    neighborhoodController = TextEditingController();
    stateController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    DB.instance.closeDB();
  }

  @override
  Widget build(BuildContext context) {
    adressRep = context.watch<AdressRepository>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Adress'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                controller: streetController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Street'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Form(
              child: TextFormField(
                controller: neighborhoodController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Neighborhood'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Form(
              child: TextFormField(
                controller: stateController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('State'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black54)),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        adressRep.addAdress(
                          street: streetController.value.text,
                          neighborhood: neighborhoodController.value.text,
                          state: stateController.value.text,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            (AdressRepository.adressList.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: AdressRepository.adressList.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(AdressRepository.adressList[index].street!),
                        subtitle: Text(AdressRepository.adressList[index].neighborhood!),
                        leading: Text(AdressRepository.adressList[index].state!),
                        trailing: Wrap(
                          children: [
                            IconButton(
                              onPressed: () {
                                adressRep.deleteAdress(AdressRepository.adressList[index].id!);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
