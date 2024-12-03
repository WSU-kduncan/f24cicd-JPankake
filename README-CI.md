# CI Project Overview
I am making a docker container and image. Containers are used like templates, and images are made from containers. This is important as it allows for easy sharing to others or quickly moving to new server providers.

To install docker you go to https://hub.docker.com/ and there is a download button on the top of the page. When run it will require a system restart.
You can make a repository in docker by going to https://hub.docker.com/repositories/{username} and clicking create repository in the top right. You can also choose whether it is public or private here. (Source: https://hub.docker.com/repository/create?namespace=jpankake67). Shows up when making a repo

*Note for grading I messed up some of these parts but decided to leave then in so you could see my process. Most of my errors are from not realizing docker has a terminal*

To extract angular-site into the repo I extracted it on my machine, then I uploaded the files with the GitHub web app. I also had to rename a folder using GitHub dev to follow the project outline.

I cloned the repo into my ubuntu. I then ran: `npm install -g @angular/cli`. A few errors later, I installed nodejs with docker using: (Source: https://nodejs.org/en/download/package-manager)

```
docker pull node:22-alpine
docker run node:22-alpine node -v
docker run node:22-alpine npm -v
```

Then I ran `sudo npm install -g @angular/cli` again.
This still uses the wrong version of nodejs when I use `node -v` I get: v12.22.9
I figure the easiest way would be to link my GitHub and docker repo to get the right version.

*I thought docker acted in a similar manor to github and I would be able to connect them to the extent that they would share files, I know now this is not the case. This is also getting in to part 2 before I finish part 1.*

I start by making an access token in the docker website.
I decided to use GitHub CLI and set that up. (Source: https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions?tool=cli)

I used: `gh secret set DOCKER_USERNAME` to set the username

I used: `gh secret set DOCKER_TOKEN` to set the access token

With both of these set, I realized Docker doesn't quite work how I thought it would and still need another way to update the nodejs to another version, regardless I got ahead on step 2.

*This turned out to be useless*
I found this website (https://nodejs.org/en/download/package-manager) setting it to Linux and nvm I used the following commands:
`curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash`
`nvm install 22`

It was only now I realized this was meant to be done in the docker repo and not the GitHub one. I got quite stuck here. I used docker's terminal to install nodejs this time, only now I am struggling with making the container. I can't figure out how to get docker to use the dockerfile.

I explored for a bit trying to figure it out with google but everything I tried wouldn't work, so I used ChatGPT just to figure out how to connect the files to the docker app and how to set up the file directories. I also used this website: https://docs.docker.com/get-started/docker-concepts/building-images/writing-a-dockerfile/ for writing the actual dockerfile, as well as the outline in the project instructions. I have the conversation with ChatGPT saved if necessary I could find a way to submit it for review as well.

I then used:
`docker build -f Dockerfile -t angular-app .` Which builds the container
`docker run -p 4200:4200 angular-app` Which runs the container

Looking back at some of my errors, I think they just stemmed from my unfamiliarity with docker and not realizing it had it's own terminal. I put the container as a local file on my machine with dockerfile and .dockerignore (ChatGPT) in the angular-site folder. Dockerfile was built following the guideline of the project and I used `node:18-bullseye` like suggested and didn't need to install nodejs like I did earlier. To view the image running you can go to http://localhost:4200. In the desktop app you can push and pull images by clicking on the three dots next to an image. You need to make sure you are logged in with `docker login`. Then you tag the image with `docker tag your_image username/repository_name:tag`, which allows you to push using: `docker push username/repository_name:tag`. (Source: https://docs.docker.com/reference/cli/docker/image/push/)

My Docker Hub repo is here: https://hub.docker.com/repository/docker/jpankake67/pankake-ceg3150/general

Earlier I set up the secrets. How I set them up is on line 23 to 34. I used `DOCKER_USERNAME` which is the username that will be used in authentication. I also used `DOCKER_TOKEN` which is used to push docker images.
GitHub workflow is used to automate actions. It will look in the repository for a dockerfile. After it will use the secrets to log into docker. The dockerfile will then be built in docker and pushed.
Link to the workflow file: [`.github/workflows/docker-publish.yml`](.github/workflows/docker-publish.yml).

My workflow file works by checking when a push happens on the main branch. It then looks for the dockerfile and logs into docker with my serects. The dockerfile is then built in docker and pushed. If someone wants to use my workflow they would need to set up the correct secrets using `DOCKER_USERNAME` and `DOCKER_TOKEN`.

```mermaid
graph LR
    A[Developer] -->|Push Code| B[GitHub Repository]
    B -->|Triggers| C[GitHub Actions Workflow]
    C -->|Check Out Code| D[Build Docker Image]
    D -->|Log In| E[DockerHub]
    D -->|Push Image| E
