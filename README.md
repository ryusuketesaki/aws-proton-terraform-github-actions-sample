## AWS Proton の Terraform OpenSource GitHub Actions 自動化テンプレート

いらっしゃいませ！ このリポジトリは、Proton が Terraform オープン ソースと連携してインフラストラクチャをプロビジョニングする方法をテストするのに役立ちます。 このリポジトリには、次の 2 つがあります。

1. 基礎となる役割と権限の設定を支援する CloudFormation テンプレート (GitHubConfiguration.yaml)
2. このリポジトリへのコミットに基づいて Terraform オープン ソースを実行する GitHub アクション タスク

Terraform 用に作成されたときに AWS Proton テンプレートがどのように見えるかの例を探している場合は、[aws-samples/aws-proton-terraform-sample-templates](https://github.com/aws- samples/aws-proton-terraform-sample-templates)

＃＃ 方法：

次のものが必要です。
- `$ENVIRONMENT_NAME`: 作成する予定の環境の名前。これは任意の名前にすることができます
- `$REGION`: このサービスをデプロイするリージョン
- `$GITHUB_USER`: このリポジトリをフォークできる GitHub アカウント

以下の手順でこれらの文字列が表示された場合は、選択した値に置き換える必要があります。

1. このリポジトリから新しいリポジトリを作成します
    - このテンプレートを開始点として使用して変更を加えることを計画している場合、これはリポジトリ テンプレートであるため、[このテンプレートを使用] をクリックするだけで、このテンプレートの正確なコピーである新しいリポジトリがアカウントに作成されます。 .
    - 実際に変更を加える予定がない場合は、このテンプレートをフォークして、更新された場合にそれらの更新を取得することもできます。
2. Github アクションを使用して Terraform テンプレートをデプロイし、Proton にデプロイ ステータスを通知します。 [proton_run.yml](https://github.com/aws-samples/aws-proton-terraform-github-actions-sample/blob/main/.github/workflows/proton_run. yml)。 フォークされたリポジトリでは、デフォルトでアクションが有効になっていません。[このページ](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your- それらを有効にする方法については、repository/managing-github-actions-settings-for-a-repository) を参照してください。
3. アカウントに CodeStar 接続が設定されていることを確認します。
    前のステップでレポをフォークしました。 設定方法については、[このドキュメント](https://docs.aws.amazon.com/dtconsole/latest/userguide/connections-create.html)を参照してください。
4. CloudFormation (https://aws.amazon.com/cloudformation/) を介して GitHubConfiguration.yaml を実行します。 これにより、GitHub Actions がアカウントにリソースをプロビジョニングするために使用するロールと、Terraform オープン ソースの状態ファイルを保存するための S3 バケットが作成されます。 S3 バケットを作成して状態ファイルを保存するために使用するため、スタック名にはすべて小文字の名前を使用してください。
```
aws cloudformation create-stack --stack-name aws-proton-terraform-role-stack \
    --template-body ファイル:///$PWD/GitHubConfiguration.yaml \
    --parameters ParameterKey=FullRepoName,ParameterValue=$GITHUB_USER/aws-proton-terraform-github-actions-sample \
    --capabilities CAPABILITY_NAMED_IAM
```
5. ファイル「env_config.json」を開きます。 キーが「ENVIRONMENT_NAME」、「role」が(3)で作成されたスタックからの「Role」出力、および「REGION」のリージョンである構成辞書に新しいオブジェクトを追加します。 これにより、デプロイに使用するロールとリージョンが Terraform に通知されます。 このファイルにロールを追加することで、環境ごとに異なるロールを使用できます
6. 同じファイルで、(3) からの `BucketName` 出力で `state_bucket` を更新します。 これにより、状態ファイルを保存する場所が Terraform に通知されます。
7. 変更をコミットし、フォークされたリポジトリにプッシュします。
8. この時点で、デプロイする環境テンプレートを登録する必要があります。 例が必要な場合は、[aws-samples/aws-proton-terraform-sample-templates](https://github.com/aws-samples/aws-proton-terraform-sample-templates) にアクセスしてください。 試してみるべきいくつかのオプションがあります。
9. [こちら] (https://docs.aws.amazon.com/proton/latest/adminguide/ag-create-repo.html) の手順に従って、リポジトリを Proton に登録します。
10. 次のコマンドを使用して指示に従い、環境を Proton にデプロイします。 `GITHUB_USER` を、フォークされたリポジトリを持つ GitHub アカウントの名前に変更します。 詳細については、[こちら] のドキュメントを参照してください (https://docs.aws.amazon.com/proton/latest/adminguide/ag-create-env.html#ag-create-env-pull-request)
```
  aws proton create-environment \
         --name $ENVIRONMENT_NAME \
         --template-name "ENVIRONMENT_TEMPLATE_NAME" \
         --template-major-version "1" \
         --provisioning-repository="branch=main,name=$GITHUB_USER/aws-proton-terraform-github-actions-sample,provider=GITHUB" \
         --スペックファイル:///$PWD/specs/env-spec.yml
```
11. デプロイをトリガーした直後に、リポジトリに戻ってプル リクエストを確認します。 マージしたら、Proton に戻り、新しく作成された環境の更新されたステータスを確認できます。

ご質問やチケットのオープンはお気軽に
--
## Terraform OpenSource GitHub Actions automation template for AWS Proton

Welcome! This repository should help you test how Proton works with Terraform Open Source to provision your infrastructure. In this repository you will find two things:

1. A CloudFormation template (GitHubConfiguration.yaml) that will help you get the underlying roles and permissions set up
2. A GitHub Actions task to run Terraform Open Source based on commits to this repo

If you are looking to find an example of what an AWS Proton Template looks like when authored for Terraform, head over to [aws-samples/aws-proton-terraform-sample-templates](https://github.com/aws-samples/aws-proton-terraform-sample-templates)

## How to:

You will need the following:
- `$ENVIRONMENT_NAME`: the name of the environment you plan to create, this can be any name you would like
- `$REGION`: the region into which you will be deploying this service
- `$GITHUB_USER`: A GitHub account with which you can fork this repository

When you see these strings in the instructions below, you should replace them with the value you have chosen.

1. Create a new repository from this repository
   - If you plan on using this template as a starting point and making changes, this is a Repository Template, so you can just click "Use this template" and a new repository will get created in your account that is an exact copy of this one.
   - If you don't plan on really making any changes, you can also fork this template, and then if/when it is updated you can get those updates.
2. We will be using Github Actions to deploy our Terraform template, and notify Proton of the deployment status. You can see the steps of our workflow in [proton_run.yml](https://github.com/aws-samples/aws-proton-terraform-github-actions-sample/blob/main/.github/workflows/proton_run.yml). Forked repositories do not have Actions enabled by default, see [this page](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/enabling-features-for-your-repository/managing-github-actions-settings-for-a-repository) for information on how to enable them.
3. Ensure you have a CodeStar Connection set up for the account into which you
   forked the repo in the previous step. For information on how to set that up see [this documentation](https://docs.aws.amazon.com/dtconsole/latest/userguide/connections-create.html).
4. Run GitHubConfiguration.yaml through CloudFormation (https://aws.amazon.com/cloudformation/). This will create a role that GitHub Actions will use to provision resources into your account, as well as an S3 bucket to store Terraform Open Source state files. Make sure you use all lowercase names in the stack name, as we will use it to create an S3 bucket to save your state files.
```
aws cloudformation create-stack --stack-name aws-proton-terraform-role-stack \
   --template-body file:///$PWD/GitHubConfiguration.yaml \
   --parameters ParameterKey=FullRepoName,ParameterValue=$GITHUB_USER/aws-proton-terraform-github-actions-sample \
   --capabilities CAPABILITY_NAMED_IAM
```
5. Open the file `env_config.json`. Add a new object to the configuration dictionary where the key is `ENVIRONMENT_NAME`, `role` is the `Role` output from the stack created in (3), and the region with `REGION`. This will tell Terraform the role and region to use for deployments. You can use different roles for each environment by adding them to this file
6. In the same file update `state_bucket` with the `BucketName` output from (3). This will tell Terraform where to store the state file.
7. Commit your changes and push them to your forked repository.
8. At this point, you should register an Environment Template that you wish to deploy. If you need an example, head on over to [aws-samples/aws-proton-terraform-sample-templates](https://github.com/aws-samples/aws-proton-terraform-sample-templates) where there are some options to try out.
9. Register your repository with Proton by following the instructions [here](https://docs.aws.amazon.com/proton/latest/adminguide/ag-create-repo.html)
10. Deploy your environment in Proton by following the instructions using the following commands. Change `GITHUB_USER` to be name of the GitHub account with the forked repository. For more information see the documentation [here](https://docs.aws.amazon.com/proton/latest/adminguide/ag-create-env.html#ag-create-env-pull-request)
```
 aws proton create-environment \
        --name $ENVIRONMENT_NAME \
        --template-name "ENVIRONMENT_TEMPLATE_NAME" \
        --template-major-version "1" \
        --provisioning-repository="branch=main,name=$GITHUB_USER/aws-proton-terraform-github-actions-sample,provider=GITHUB" \
        --spec file:///$PWD/specs/env-spec.yml
```
11. Shortly after you trigger the deployment, come back to your repository to see the Pull Request. Once you merge it, you can go back to Proton and see the updated status of your newly created environment

Feel free to reach out with questions or open a ticket with suggestions in our public roadmap at https://github.com/aws/aws-proton-public-roadmap

Thank you!


## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

