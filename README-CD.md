# Project 5

## Part 1 Semantic Versioning

In part one the project is being edited to immplement continuous deployment for Docker. This makes it so that whenever a tag is pushed Docker images are built and pushed to dockerhub. To do this I used **Docker**, **GitHub Actions**, **docker/metadata-action**, and **docker/build-push-action**


To create and push a tag in git I used the following format:
```bash
git tag -a v<MAJOR.MINOR.PATCH> -m "<message>"
git push origin v<MAJOR.MINOR.PATCH>

The workflow has been updated as follows:

When: It is triggered when a tag is pushed in the format vMAJOR.MINOR.PATCH

What: First it checks the repository for the latest code and tag, then it logs into dockerhub using GitHub secrets, next it extract the metadata using **docker/metadata-action** to make tags, and finally it builds and pushes images to dockerhub.

Step by Step process of part 1:
This part is my unorganized thought process of working through the project. It has been placed at the end and made seperate from the rest of the answers for readibility as requested last project.

I started by looking through the resources and trying to understand how metadata worked with docker. After feeling like I had an Idea I looked over my workflow again and changed to first section so the workflow only runs when a tag is pushed. In the GitHub on metadata provided in the resources section I noticed that to specifiy the version they used 'v*'. Once I realizes this is a simple version tag I changed my workflow to use 'v*.*.*' so it follows the semantic versioning. The checking out and login sections didn't need anything changed. The extracting metadata was added still using the GitHub link as a reference. I struggled a bit trying to get the formatting right for this bit but I got the majority of it. After I finsihed the workflow I ran it through chatGPT to fix some grammar mistakes and formatting. I think it also changed some stuff it didn't need to but I didn't go back and unchange them.

## Part 2 Depolyment

To install docker I used 'sudo apt update' and `sudo apt-get install apt-transport-https ca-certificates curl software-properties-common` to get the prerequisites for docker. I then ran `curl -fsSL https://get.docker.com -o get-docker.sh` and `sudo sh get-docker.sh` to install docker itself. Running `docker --version` confirms it is installed.
