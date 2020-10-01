# From Jupyter to Production

JupyterLab image for workshop: From Jupyter to Production - production-ready data science projects.

https://github.com/codecentric/from-jupyter-to-production-workshop

## Jupyterlab starten
```bash
docker pull radtkem/from-jupyter-to-production-baseimage
```
## Run on Mac & Linux

```bash
docker run -p 8888:8888 -v $(pwd)/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-baseimage
```

## Run on Windows

```bash
docker run -p 8888:8888 -v %cd%/notebooks:/workshop/notebooks radtkem/from-jupyter-to-production-baseimage
```

## Build locally

```bash
cd /path/to/from-jupyter-to-production-baseimage
docker build -t ws_jupyter_base .
```
