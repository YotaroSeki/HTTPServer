# todo API server

## set up

1. Install Crystal lang

```bash
apt install crystal
```
2. Install Amber framework

```bash
apt install amber
```

3. Install postgresql
```bash
apt install postgres@11
```

4. Edit `config/environments/development.yml`
```yaml
database_url: postgres://#{YOUR_USER_NAME}:@localhost:5432/todo_development
```

5. Create Table and migrate
```bash
amber db create migrate
```
6. Run server
```bash
amber w
```

## 動作

- 最初にlocalhost:3000にアクセスしてユーザー登録およびログインをする必要があります。

```bash
# イベント登録 API request
POST /api/v1/event
{"deadline": "2019-06-11T14:00:00+09:00", "title": "レポート提出", "memo": ""}

# イベント登録 API response
200 OK
{"status": "success", "message": "registered", "id": 1}

400 Bad Request
{"status": "failure", "message": "invalid date format"}
```

```bash
# イベント全取得 API request
GET /api/v1/event

# イベント全取得 API response
200 OK
{"events": [
    {"id": 1, "deadline": "2019-06-11T14:00:00+09:00", "title": "レポート提出", "memo": ""},
    ...
]}
```

```bash
# イベント1件取得 API request
GET /api/v1/event/${id}

# イベント1件取得 API response
200 OK
{"id": 1, "deadline": "2019-06-11T14:00:00+09:00", "title": "レポート提出", "memo": ""}

404 Not Found
```

```bash
# イベント1件削除 API request
DELETE /api/v1/event/${id}

# イベント1件取得 API response
204 OK

404 Not Found
```