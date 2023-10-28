# Repository Automation

This repository has a lot of automation built into it. We
are currently leveraging automation for 3 tasks:

- code quality standards when a pull request is created, edited, pushed to, or commented on
- docker image is built when a pull request is merged into main
- helm chart deploys the latest docker image for our repository when a release is created

## Architecture Background

Docker: docker is a runtime that can run software in a sandbox called a container.

Docker Image: a sandbox you can build your software into. Our Sveltekit frontend website will
be wrapped in a Docker Image. That way it can be run inside of a container in our Kubernetes
clusters.

Kubernetes: a runtime developed by Google that can orchestrate docker images. Our Kubernetes
clusters for development are hosted on-site behind a vpn in an air-gapped network. Our production
Kubernetes clusters can be on any cloud based provider. That is why we chose Kubernetes as our
deployment engine.

Helm: the package manager for kubernetes applications.

Helm Chart: the package for your kubernetes instance. our helm chart contains the configuration
and architecture for our client's full-stack application (Sveltekit frontend, Strapi backend) as
well as how to configure the monitoring and networking level code.

Very confusing, I know. :(

## Pull Request Pipeline

When a developer wants to merge in a feature or bugfix to the main branch, as the main branch contains
code that goes to production. They must follow the code quality standards. These standards include the
following.

- Passing Build
- Zero Test Failures
- Zero Linting Failures
- Zero Security Issues
- Zero Critical or High Priority Code Smells
- 1 Approval from Peer Review

These will ensure that we are not putting ourselves at risk for any legal action from our clients. It
provides a paper-trail of due diligence and forth-coming.

## Merge Pipeline

When a developer does merge their code into the main branch via a pull request, another pipeline will do
some more work for us. By now, you must know how lazy I actually am. This pipeline will bump the version
in our `package.json` for us, tag our commit with that version (making it easy to find in the future),
and build our Docker Image.

We go by the philosophy that the main branch is the code that gets deployed to the production website. So
when new code is pushed to main, we want a Docker Image to be built. That way, we can deploy a new version
of a customer's website at the drop of a hat. Wether it be from our laptops or from the GitHub release
functionality.

## Release Pipeline

When a release manager creates a new release via the GitHub UI, a pipeline will run that will use our
custom built private [Helm Chart]() to deploy the frontend and cms at the same time. We will have a test
and production server to push to.
