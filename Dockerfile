FROM nanshe/nanshe:sge
MAINTAINER John Kirkham <jakirkham@gmail.com>

RUN for PYTHON_VERSION in 2 3; do \
        mkdir -p /notebooks && \
        export INSTALL_CONDA_PATH="/opt/conda${PYTHON_VERSION}" && \
        . ${INSTALL_CONDA_PATH}/bin/activate && \
        conda install -qy -n root notebook && \
        python -m ipykernel install && \
        conda clean -tipsy && \
        . ${INSTALL_CONDA_PATH}/bin/deactivate ; \
    done

ENTRYPOINT [ "/opt/conda/bin/tini", "--", "/usr/share/docker/entrypoint.sh", "/usr/share/docker/entrypoint_2.sh", "python3", "-m", "notebook", "--allow-root", "--no-browser", "--ip=*" , "--notebook-dir=/notebooks" ]
