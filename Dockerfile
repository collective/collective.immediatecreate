FROM plone/plone-backend:6.0.0a2

LABEL maintainer="Your contact <your@contact.email>" \
      org.label-schema.name="collective.immediatecreate" \
      org.label-schema.description="collective.immediatecreate CMS Plone Site" \
      org.label-schema.vendor="Your Name or Organization" \
      org.label-schema.docker.cmd="docker run -d -p 8080:8080 yourdockerhubnamespace/plone-collective.immediatecreate:latest"

# Add local collective.immediatecreate code
COPY . ./
RUN gosu make VENV=off VENV_FOLDER=. install
