import 'package:flutter/material.dart';
import 'package:whaloo_genuinity/constants/controllers.dart';
import 'package:whaloo_genuinity/constants/style.dart';

class ProductsSearchForm extends StatelessWidget {
  const ProductsSearchForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(height: kSpacing * 4),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15))),
                  onPressed: () {
                    productsController.changeSearchFilter(
                        productsController.searchText.value);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Search "),
                      Icon(Icons.search_rounded),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
