# From Jupyter to Production

JupyterLab and Mlflow image for workshop: From Jupyter to Production - production-ready data
science projects.

https://github.com/codecentric/from-jupyter-to-production-workshop

## Build & Push

A github action is defined to push a new version of the image to Docker Hub every time a new
`git tag` is pushed to the repository.
The git tag is also used for the Docker images. An image tag with the git tag and the `latest` tag
is published for each Docker build.
No need to do anything locally, besides testing the build with `docker build .`

The build is quite memory heavy, so assign a good amount of memory towards the docker engine
(minimum 4gb, better 6gb)

## Run on Mac & Linux

Run in `from-jupyter-to-production-workshop` directory, containing the notebooks.

```bash
docker run -p 8888:8888 -v $(pwd)/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-jupyter
```

## Run on Windows

Run in `from-jupyter-to-production-workshop` directory, containing the notebooks.

```bash
docker run -p 8888:8888 -v %cd%/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-jupyter
```
