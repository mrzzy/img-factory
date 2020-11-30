#
# tf-gpu-dl-plugged
# Extends Kubeflow's tensorflow 2.1 gpu images with Jupyterlab plugins
#

FROM gcr.io/kubeflow-images-public/tensorflow-2.1.0-notebook-gpu:1.0.0

# escalate permissions to root to install
USER root

# change default shell to bash
ENV SHELL=/bin/bash

# install packages
RUN apt-get update && apt-get install -y \
    nodejs htop neovim \
    && rm -rf /var/lib/apt/lists/*
# install & upgrade python packages
# jupyterlab has to be upgraded as its too old for jupyterlab-lsp
RUN pip install --upgrade \
    jupyterlab==2.2.9 jupyter-lsp jupyterlab-git jupyter-server-proxy  \
    dask_labextension jupyterlab-s3-browser python-language-server[all]  \
    kaggle dask seaborn pandas-profiling[notebook] hyperas hyperopt

# install plugins/extensions
RUN jupyter labextension install @krassowski/jupyterlab-lsp --no-build \
    && jupyter labextension install @axlair/jupyterlab_vim --no-build  \
    && jupyter labextension install @jupyterlab/git --no-build \
    && jupyter labextension install @jupyterlab/toc --no-build \
    && jupyter labextension install @jupyterlab/server-proxy --no-build \
    && jupyter labextension install dask-labextension --no-build \
    && jupyter labextension install jupyterlab-s3-browser --no-build \
    && jupyter lab build
# enable server extensions
RUN jupyter serverextension enable --sys-prefix jupyter_server_proxy \
    && jupyter serverextension enable --py jupyterlab_s3_browser \
    && jupyter serverextension enable dask_labextension 


# revert user to jovyan
USER jovyan

# run jupyterlab instead of jupyter notebook
CMD ["sh","-c", "jupyter lab --notebook-dir=/home/${NB_USER} --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
