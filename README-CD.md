## Part 1 Delpoyment with Docker and GitHub Actions

### Project Overview Part 1

In part one the project is being edited to immplement continuous deployment for Docker. This makes it so that whenever a tag is pushed Docker images are built and pushed to dockerhub. To do this I used **Docker**, **GitHub Actions**, **docker/metadata-action**, and **docker/build-push-action**


To create and push a tag in git I used the following format:
```bash
git tag -a v<MAJOR.MINOR.PATCH> -m "<message>"
git push origin v<MAJOR.MINOR.PATCH>

