# From Jupyter to Production

JupyterLab image for workshop: From Jupyter to Production - production-ready data science projects.

https://github.com/codecentric/from-jupyter-to-production-workshop

## Build & Push

A github action is defined to push a new version of the image to docker hub for every new commit to the repository. No need to do anything locally, besides testing the build with `docker build .`

The build is quite memory heavy, so assign a good amount of memory towards the docker engine (minimum 4gb, better 6gb)

## Run on Mac & Linux

Run in `from-jupyter-to-production-workshop` directory, containing the notebooks.

```bash
docker run -p 8888:8888 -v $(pwd)/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-baseimage
```

*Note: Running on Apple Silicon/M1 is currently not supported*

## Run on Windows

Run in `from-jupyter-to-production-workshop` directory, containing the notebooks.

```bash
docker run -p 8888:8888 -v %cd%/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-baseimage
```
