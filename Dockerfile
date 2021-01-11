FROM python

LABEL "com.github.actions.name"="Spellcheck Action"
LABEL "com.github.actions.description"="Check spelling of files in repo on any languages"
LABEL "com.github.actions.icon"="clipboard"
LABEL "com.github.actions.color"="green"
LABEL "repository"="http://github.com/igsekor/pyspelling-any"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Igor Korovchenko <igsekor@gmail.com>"

RUN apt-get update \
    && apt-get install -y aspell hunspell

RUN pip3 install pyspelling pyyaml

COPY extract-lang.py /extract-lang.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /action
ENTRYPOINT ["/entrypoint.sh"]
