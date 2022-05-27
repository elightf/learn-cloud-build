# learn-cloud-build

This is a project developed to help my understanding of how terraform interacts with google cloud services by making a monorepo containing all function code, and a running service along with the infrastructure required to run them codified in `.tf` files.

After performing the following steps, you should have an up and running instance of google cloud run container serving a basic nodejs app "Ronin" and a cloud function that responds to http triggers.

Note: the title of this repo is not apt - that's because initially I didn't scope out this task properly due to lack of understanding. It kind of took on a life of its own!

My primary reference for this work is [here](https://github.com/GoogleCloudPlatform/serverless-expeditions/tree/main/terraform-serverless)

* Create a new [Google Cloud Project](https://console.cloud.google.com/projectcreate)


* Copy the project ID string


* Launch Cloud Shell
  * Cloud Shell comes with installations of `git` and `terraform` included :ok:
  * all the following CLI commands are in Cloud Shell
  

* Set the current project in cloud shell to your new project ID
    ```
    gcloud config set project {PROJECT-ID}
    ```
  
* Clone this GitHub repo:
    ```
    git clone https://github.com/elightf/learn-cloud-build
    ```
  
* Navigate into the new repo directory (where [`cloudbuild.yaml`](https://github.com/elightf/learn-cloud-build/blob/main/cloudbuild.yaml) lives)

    ```
    cd learn-cloud-build
    ```
  
* Register a new container to the registry (uses [`cloudbuild.yaml`](https://github.com/elightf/learn-cloud-build/blob/main/cloudbuild.yaml) for config)
    ```
    gcloud builds submit
    ```

* The shell will tell you `API [cloudbuild.googleapis.com] not enabled on project` - enable it by typing `y`


* Navigate into the `/terraform` directory
    ```
    cd terraform
    ```
  

* Download terraform dependencies for this project (i.e. [google_provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs))
    ```
    terraform init
    ```

* Copy your project ID again


* Run terraform code to enable APIs, set up IAM role bindings, and deploy
    ```
    terraform apply
    ```


* Terraform will ask you to specify the project ID - enter it now


* When terraform asks "Do you want to perform these actions?", type `yes`


* Go grab a :sparkles::coffee:


* If Terraform yells at you that an API is not enabled, just rerun `terraform apply`


* Look for the 2 links at the end of the logs output by terraform 
  * The cloud run instance with a running node app mock server 
  * An http-triggered cloud function that responds with 200



This deployment may incur charges if you left these services up for a long time. So let's take them all down again:

* Reverse deployment and leave no trace

    ```
    terraform destroy
    ```

Change