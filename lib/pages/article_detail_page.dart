import 'package:flutter/material.dart';
import 'package:flutter_desktop/database/database_helper.dart';
import 'package:flutter_desktop/helpers/formatter.dart';
import 'package:flutter_desktop/models/article.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

// ignore: must_be_immutable
class ArticleDetailPage extends StatefulWidget {
  static const String routeName = '/articleDetailPage';

  TextEditingController nameController;
  MoneyMaskedTextController priceController;
  TextEditingController amountController;
  TextEditingController unitController;

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final _formKeyName = GlobalKey<FormState>();
  final _formKeyUnit = GlobalKey<FormState>();
  final _formKeyPrice = GlobalKey<FormState>();
  final _formKeyAmount = GlobalKey<FormState>();

  bool _validated = true;
  bool _editArticle = false;
  Article _article;

  void initArticleData() {
    _article = ModalRoute.of(context).settings.arguments;

    if (_article != null) {
      _editArticle = true;
    } else {
      _article = new Article.emptyArticle();
    }

    widget.nameController = new TextEditingController(text: _article.name);
    widget.priceController = new MoneyMaskedTextController(
        initialValue: _article.price, rightSymbol: ' €');
    widget.amountController =
        new TextEditingController(text: _article.amount.toString());
    widget.unitController = new TextEditingController(text: _article.unit);
  }

  @override
  Widget build(BuildContext context) {
    initArticleData();
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 123,
        leading: FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios, size: 24, color: Colors.grey[850]),
              Text(
                'Artikel',
                style: TextStyle(fontSize: 18, color: Colors.grey[850]),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () => applyArticle(),
            child: Text(
              _editArticle ? 'Speichern' : 'Erstellen',
              style: TextStyle(color: Colors.grey[850], fontSize: 18),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Column(
                children: [
                  Icon(
                    _editArticle ? Icons.article_outlined : Icons.post_add,
                    size: 100,
                    color: Colors.white,
                  ),
                  Text(
                    _editArticle ? _article.name : "Artikel anlegen",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding:
                    EdgeInsets.only(top: 5, bottom: 50, left: 10, right: 10),
                children: [
                  SizedBox(height: 15),
                  _buildName(),
                  _createSpaceBox(),
                  _buildPrice(),
                  _createSpaceBox(),
                  _buildAmount(),
                  _createSpaceBox(),
                  _buildUnit(),
                  _createSpaceBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textFieldStyle() {
    return TextStyle(fontWeight: FontWeight.w500);
  }

  TextStyle _textFieldLabelStyle() {
    return TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  }

  Widget _buildName() {
    return Form(
      key: _formKeyName,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 30),
        child: Row(
          children: [
            Icon(Icons.article, color: Colors.blue),
            SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: widget.nameController,
                decoration: InputDecoration(
                  labelText: 'Bezeichnung',
                  labelStyle: _textFieldLabelStyle(),
                ),
                style: _textFieldStyle(),
                onChanged: (value) => _formKeyName.currentState.validate(),
                validator: (value) {
                  if (value.isEmpty) {
                    _validated = false;
                    return 'Eingabe erforderlich';
                  }
                  _validated = true;
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Form(
      key: _formKeyPrice,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 30),
        child: Row(
          children: [
            Icon(Icons.attach_money, color: Colors.blue[500]),
            SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.streetAddress,
                controller: widget.priceController,
                decoration: InputDecoration(
                  labelText: 'Preis',
                  labelStyle: _textFieldLabelStyle(),
                ),
                style: _textFieldStyle(),
                validator: (value) {
                  double price =
                      Formatter.createDoubleFromCurrencyString(value);
                  if (price <= 0.00) {
                    _validated = false;
                    return 'Preis muss über 0,00 € sein';
                  }
                  _validated = true;
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmount() {
    return Form(
      key: _formKeyAmount,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 30),
        child: Row(
          children: [
            Icon(Icons.format_list_numbered, color: Colors.blue[500]),
            SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: widget.amountController,
                decoration: InputDecoration(
                  labelText: 'Menge',
                  labelStyle: _textFieldLabelStyle(),
                ),
                style: _textFieldStyle(),
                validator: (value) {
                  int price = int.parse(value);
                  if (price <= 0) {
                    _validated = false;
                    return 'Menge muss min. 1 betragen';
                  }
                  _validated = true;
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnit() {
    List<String> _units = [
      'Tafeln',
      'Stück',
      'Liter',
      'ml',
      'KG',
      'Gramm',
      'h',
      'Pack'
    ];

    return Form(
      key: _formKeyUnit,
      child: Container(
        padding: EdgeInsets.only(top: 5, left: 10, right: 30),
        child: Row(
          children: [
            Icon(Icons.category, color: Colors.blue[500]),
            SizedBox(width: 20),
            Expanded(
              child: DropdownButtonFormField(
                value: _editArticle ? widget.unitController.text : null,
                hint: Text('Einheit'),
                items: _units
                    .map(
                      (label) => DropdownMenuItem(
                        child: Text(label.toString()),
                        value: label,
                      ),
                    )
                    .toList(),
                onChanged: (value) => widget.unitController.text = value,
                validator: (value) {
                  if (value == null) {
                    _validated = false;
                    return 'Bitte Einheit auswählen';
                  }
                  _validated = true;
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createSpaceBox() {
    return SizedBox(height: 25);
  }

  void applyArticle() {
    if (_formKeyName.currentState.validate() &&
        _formKeyPrice.currentState.validate() &&
        _formKeyAmount.currentState.validate() &&
        _formKeyUnit.currentState.validate() &&
        _validated) {
      _article.name = widget.nameController.text;
      _article.price =
          Formatter.createDoubleFromCurrencyString(widget.priceController.text);
      _article.amount = int.parse(widget.amountController.text);
      _article.unit = widget.unitController.text;

      if (_editArticle) {
        DatabaseHelper.updateArticle(_article);
      } else {
        DatabaseHelper.addArticle(_article);
      }
      Navigator.pop(context);
    }
  }
}
