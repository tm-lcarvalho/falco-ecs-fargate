# Build from unstable debian as it gets security updates faster than stable
FROM --platform=linux/x86_64 debian:stable AS base

LABEL maintainer="Lucio Carvalho lucio.carvalho@toumoro.com"

COPY . /falco-trace

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
    unzip \
    curl \
    supervisor \
#    cmake \
#    make \
#    build-essential \
#    libyaml-0-2 \
    ca-certificates

COPY --from=ollypom/pdig:latest /pdig /opt/falco/bin/pdig
COPY --from=falcosecurity/falco:0.36.2-slim /usr/bin/falco /opt/falco/bin/falco
COPY --from=falcosecurity/falco:0.36.2-slim /etc/falco/ /etc/falco/

#RUN /falco-trace/bin/build

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws && \
    rm awscliv2.zip

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./myscript.sh             /opt/falco/scripts/myscript.sh
COPY ./supervisord.conf        /opt/falco/scripts/supervisord.conf
COPY ./falco_custom_rule.yaml  /etc/falco/rules.d/falco_custom_rule.yaml

CMD [ "/usr/bin/supervisord", "-c", "/opt/falco/scripts/supervisord.conf" ]

#CMD ["/falco-trace/bin/falco"]

