# terraform-s3_1

Terraformで S3バケットを作るテスト。意外とめんどくさい。

デプロイは
backend.config
と
variables.tf(`variables.tf-`がテンプレート)
を編集してから

```bash
terraform init -backend-config=backend.conf
terraform plan
terraform apply
```

で。

`terraform destroy` するときは
`prevent_destroy = false` に書き換えてから実行。

ここ変数にならない。理由はよくわからない。
