# From Jupyter to Production

JupyterLab image for workshop: From Jupyter to Production - production-ready data science projects.

## Jupyterlab starten
```bash
docker pull codecentric/from-jupyter-to-production-image
```
## Run on Mac & Linux

```bash
docker run -p 8888:8888 -v $(pwd)/notebooks:/workshop/notebooks codecentric/from-jupyter-to-production-image
```

## Run on Windows

```bash
docker run -p 8888:8888 -v %cd%/notebooks:/workshop/notebooks codecentric/from-jupyter-to-production-image
```

## Build locally

```bash
cd /path/to/from-jupyter-to-production-image
docker build -t ws_jupyter_base .
```
