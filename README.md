# learn-cloud-build

This is a project developed to help my understanding of how terraform interacts with google cloud services by making a monorepo containing all function code, and a running service along with the infrastructure required to run them codified in `.tf` files.

After performing the following steps, you should have an up and running instance of google cloud run container serving a basic nodejs app "Ronin" and a cloud function that responds to http triggers.

Note: the title of this repo is not apt - that's because initially I didn't scope out this task properly due to lack of understanding. It kind of took on a life of its own!


1. Create a new Google Cloud Project
2. Copy the project ID string
3. Launch Cloud Shell - all the following CLI commands are in Cloud Shell
4. Set the current project in cloud shell to your new project ID
`gcloud config set project {PROJECT-ID}`
5. Clone this GitHub repo:
`git clone https://github.com/elightf/learn-cloud-build`
6. `cd` into the new repo directory `/learn-cloud-build`
7. Register a new container to the registry `gcloud builds submit`
8. The shell will tell you `API [cloudbuild.googleapis.com] not enabled on project` - enable it by typing `y`
9. `cd` into the `/terraform` directory
10. Type `terraform init`
11. Copy your project ID again
12. Type `terraform apply`
13. Terraform will ask you to specify the project ID - enter it now (might not hurt to double check)
14. When terraform asks "Do you want to perform these actions?", type `yes`
15. Go grab a :sparkles::coffee:
16. If Terraform yells at you that an API is not enabled, just retry from step 12
17. Look for the 2 links at the end of the logs output by terraform
    1. The cloud run instance with a running node app mock server 
    2. An http-triggered cloud function that responds with 200

This deployment may incur charges if you left these services up for a long time. So let's take them all down again:

14. Type `terraform destroy`

There is no trace of your deployment anymore.
