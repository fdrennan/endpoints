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
  rrdtool 

ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000)"]
CMD ["/app/plumber.R"]
