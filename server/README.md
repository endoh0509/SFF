# Server

```bash
bundle install --path vendor/bundle
bundle exec ruby app.rb
```

## Production

https://qiita.com/abgata20000/items/d7de93fe8a82e8360fa9

### バックグラウンドで実行

```bash
nohup bundle exec ruby app.rb &
```

### 実行中のスクリプトを停止

```bash
ps ax | grep ruby
kill PROCESS_ID
```
