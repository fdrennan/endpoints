FROM trestletech/plumber
MAINTAINER Docker User <docker@user.org>
  
RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev \
  libxml2-dev \
  xml2 \
  libapparmor1 \
  libedit2 \  
  libc6 \ 
  psmisc \ 
  rrdtool \
  build-essential \
  libcurl4-gnutls-dev \
  libxml2-dev \
  libssl-dev \ 
  libsasl2-dev \
  libgmp10-dev \
  libgsl0-dev \
  libnetcdf-dev \
  netcdf-bin \
  libdigest-hmac-perl \
  libgmp-dev \
  libgmp3-dev \
  libgl1-mesa-dev \
  libglu1-mesa-dev \
  libglpk-dev \
  tdsodbc \
  freetds-bin \
  freetds-common \
  freetds-dev \
  odbc-postgresql \
  libtiff-dev \
  libsndfile1 \
  libsndfile1-dev \
  libtiff-dev \
  tk8.5 \
  tk8.5-dev \
  tcl8.5 \
  tcl8.5-dev \
  libgsl0-dev \
  libv8-dev \
  libpq-dev

RUN R -e "install.packages('broom')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('mongolite')"
RUN R -e "install.packages('RPostgreSQL')"
RUN R -e "install.packages('rollbar')"

RUN R -e 'devtools::install_github("fdrennan/drentools", auth_token = "01c3e427280d5441f5f2b830bd2a15e8dd80c39f")'

EXPOSE 8000
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/app/plumber.R"]
