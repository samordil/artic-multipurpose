# ---- Builder Stage ----
    FROM mambaorg/micromamba:2.0.2 AS builder

    # Metadata
    LABEL maintainer="Samuel Odoyo" \
          version="1.0.0" \
          description="A micromamba-based image leveraging ARTIC v1.3, \
                        designed to support multiple reference assemblies \
                         for linear viruses like human metapneumovirus (hMPV) \
                         and circular viruses such as hepatitis B virus (HBV) \
                         sequenced using ONT." \
          license="Copyright (c) 2017-2018 Nick Loman & the ZiBRA Project & the ARTIC project"
    
    # Set environment variables
    ARG MAMBA_USER=mambauser
    ENV MAMBA_USER=${MAMBA_USER}
    ENV PATH="/opt/conda/bin:$PATH"
    ENV WORKDIR="/home/${MAMBA_USER}/app"
    
    # Install dependencies as root
    USER root
    RUN apt-get update && apt-get install -y --no-install-recommends git && \
        rm -rf /var/lib/apt/lists/*
    
    # Switch to non-root user
    USER ${MAMBA_USER}
    WORKDIR ${WORKDIR}
    
    # Copy source files from local directory
    COPY --chown=${MAMBA_USER}:${MAMBA_USER} . ${WORKDIR}/

    # Clone the GitHub repository (only latest commit for efficiency)
    # RUN git clone --depth=1 https://github.com/samordil/artic-multirefs ${WORKDIR}
    
    # Install dependencies in base environment
    RUN micromamba install -n base -f environment.yml -y && \
        micromamba run -n base python setup.py install && \
        micromamba clean --all --yes
    
    # Remove source files to reduce image size
    RUN rm -rf ${WORKDIR}
    
    # ---- Final Runtime Stage ----
    FROM mambaorg/micromamba:2.0.2
    
    # Metadata
    LABEL maintainer="Samuel Odoyo" \
          version="1.0.0" \
          description="A micromamba-based image leveraging ARTIC v1.3, \
                        designed to support multiple reference assemblies \
                         for linear viruses like human metapneumovirus (hMPV) \
                         and circular viruses such as hepatitis B virus (HBV) \
                         sequenced using ONT." \
          license="Copyright (c) 2017-2018 Nick Loman & the ZiBRA Project & the ARTIC project"
    
    # Set environment variables
    ARG MAMBA_USER=mambauser
    ENV MAMBA_USER=${MAMBA_USER}
    ENV PATH="/opt/conda/bin:$PATH"
    
    # Set working directory to the user's home
    WORKDIR "/home/${MAMBA_USER}"
    
    # Copy only the installed environment
    COPY --from=builder /opt/conda /opt/conda
    
    # Install ps command
    USER root
    RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*
    
    # Switch to the non-root user
    USER ${MAMBA_USER}
    
    # Create a hidden entrypoint script
    RUN printf '#!/bin/bash\n\
    eval "$(micromamba shell hook --shell=bash)"\n\
    micromamba activate base\n\
    exec "$@"\n' > /home/${MAMBA_USER}/.entrypoint.sh \
        && chmod +x /home/${MAMBA_USER}/.entrypoint.sh
    
    # Ensure activation in interactive shells
    RUN echo 'eval "$(micromamba shell hook --shell=bash)"' >> /home/${MAMBA_USER}/.bashrc && \
        echo 'micromamba activate base' >> /home/${MAMBA_USER}/.bashrc
    
    # Set entrypoint for automatic activation
    ENTRYPOINT ["/home/mambauser/.entrypoint.sh"]
    
    # Default to an interactive shell
    CMD ["bash"]
    