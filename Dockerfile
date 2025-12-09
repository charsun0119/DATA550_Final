FROM rocker/tidyverse:4.5.1

RUN mkdir -p /project
WORKDIR /project

RUN mkdir -p renv
COPY renv.lock .
COPY .Rprofile .
COPY renv/activate.R renv/
COPY renv/settings.json renv/
RUN mkdir -p renv/.cache
ENV RENV_PATHS_CACHE="renv/.cache"

RUN apt-get update && apt-get install -y libv8-dev

RUN Rscript -e "renv::restore(prompt = FALSE)"

RUN mkdir -p code data outputs report

COPY code/ code/
COPY data/ data/
COPY outputs/ outputs/
COPY Makefile .
COPY Indicator_Report.Rmd .

ENTRYPOINT ["make"]
CMD ["report"]
