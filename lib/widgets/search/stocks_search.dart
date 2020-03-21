import 'package:flutter/material.dart';

import '../table/stock_table_header.dart';
import '../table/stock_table_search_row.dart';

class StocksSearch extends StatefulWidget {
  final List data;
  final Function filterSearchResults;
  final Function addToMyStocks;
  final Function refresh;

  StocksSearch(
    this.data,
    this.filterSearchResults,
    this.addToMyStocks,
    this.refresh,
  );

  @override
  _StocksSearchState createState() => _StocksSearchState();
}

class _StocksSearchState extends State<StocksSearch> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
            height: 40,
            child: TextField(
              onChanged: (value) {
                widget.filterSearchResults(value);
              },
              textCapitalization: TextCapitalization.characters,
              controller: _searchController,
              decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.background,
                  filled: true,
                  contentPadding: EdgeInsets.all(0),
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: _searchController.text != ""
                      ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              widget
                                  .filterSearchResults(_searchController.text);
                            });
                          })
                      : null,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),
          StockTableHeader(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: widget.refresh,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: widget.data.length,
                itemBuilder: (_, i) =>
                    StockTableSearchRow(widget.data[i], widget.addToMyStocks),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
