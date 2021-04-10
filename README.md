# From Jupyter to Production

JupyterLab image for workshop: From Jupyter to Production - production-ready data science projects.

https://github.com/codecentric/from-jupyter-to-production-workshop

## Image pullen
```bash
docker pull radtkem/from-jupyter-to-production-baseimage
```
## Run on Mac & Linux

Run in `from-jupyter-to-production-workshop` directory, containing the notebooks.

```bash
docker run -p 8888:8888 -v $(pwd)/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-baseimage
```

## Run on Windows

Run in `from-jupyter-to-production-workshop` directory, containing the notebooks.

```bash
docker run -p 8888:8888 -v %cd%/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-baseimage
```

## Build locally

```bash
cd /path/to/from-jupyter-to-production-baseimage
docker build .
```

The build is quite memory heavy, so assign a good amount of mem towards the docker engine (minimum 4gb, better 6gb)
