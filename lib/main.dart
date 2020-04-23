import 'dart:convert';
 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
 
void main() => runApp(MyApp());
 
WebViewController _controller; // WebViewコントローラー
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'camera filter sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('webviewを使ったフィルターの実験'),
        ),
        body: ListView(
          itemExtent: 500,
          children: <Widget>[
            Image.asset('assets/samplebase64.png'),
            WebView(
              // onWebViewCreatedはWebViewが生成された時に行う処理を記述できます
              onWebViewCreated: (WebViewController webViewController) async { 
                _controller = webViewController; // 生成されたWebViewController情報を取得する
                await _loadHtmlFromAssets(); // HTMLファイルのURL（ローカルファイルの情報）をControllerに追加する処理
              },
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ],
        ),
        // 画面下にボタン配置
        floatingActionButton: FloatingActionButton(
          onPressed: _addFilter,
        ),
      ),
    );
  }
 
  /// フィルターをかけるfunctionを呼ぶ
  void _addFilter() {
    // JSメソッド呼び出し
    // WebViewControllerクラスのevaluateJavascriptの引数に呼び出すJSメソッドを入れる
    _controller.evaluateJavascript("test();");
  }

  /// HTMLファイルを読み込む処理
  Future _loadHtmlFromAssets() async {
    //　HTMLファイルを読み込んでHTML要素を文字列で返す
    String fileText = await rootBundle.loadString('assets/test.html');
    // <WebViewControllerのloadUrlメソッドにローカルファイルのURI情報を渡す>
    // WebViewControllerはWebViewウィジェットに情報を与えることができます。
    // <Uri.dataFromStringについて>
    // パラメータで指定されたエンコーディングまたは文字セット（指定されていないか認識されない場合はデフォルトでUS-ASCII）
    // を使用してコンテンツをバイトに変換し、結果のデータURIにバイトをエンコードします。
    _controller.loadUrl( Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }
}