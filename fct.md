1. Click on **New => Web + Mobile => Function App** and Enter desired **Function App name**, and other details. Select the storage account (or create a new one) and click on **Create**.

After clicking on new function, you will be redirected to the below page with all different Azure Functions templates.

2. select **‘GitHub Webhook – Node’** template which will be triggered as per event over GitHub takes place. Give some appropriate name to this function and click **Create**. 

3. Assuming you have your **GitHub** account, go to GitHub and login. Navigate to **Settings => Webhook & Services** tab. Enter Payload URL with Function URL and and Secret key with **Function Key** from function's **Manage page** (not **Admin Key**).
![github webhooks settings](images/Azure-Functions-7.png)

Choose **Let me select individual events**,  select **Commit comment** as we need to trigger the functions when someone enters comment to any Commit in GitHub.
Once done click on Add Webhook.

Webhook will be added and it would look like the below screenshot (**green tick indicates the webhook is working with our function**)
![github webhooks settings](images/Azure-Functions-9.png)

**Testing**
Commit a change with comment on GitHub.
The same should get logged in our Azure function window, **Log** section.
