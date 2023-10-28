# Nightowl Developers Frontend Architecture

The Nightowl Developers Frontend Architecture comprises of many features including i18n (internationizaton),
xml sitemap generation (seo), animations (ui), and cloud automation using Github Actions and Docker builds.

The first thing you should understand is that this application is built using [Svelte]() and [SvelteKit]().

These technologies allow us to accomplish the same thing other frameworks like React, Vue, or Angular in a
fraction of the lines of code. Svelte also conforms to the native behavior of the browser while being fast,
responsive, and powerful.

## Data Fetching

We use fetch on the server side and feed the results to our pages as props. This provides the expected
results without pushing too much JavaScript to the client during hydration.

## Styling

We use [tailwind-css](https://tailwindcss.com/) for all of our styling needs. It's like writing css, but
easier and faster.

## Internationalization

We use the [sveltekit-i18n](https://www.npmjs.com/package/sveltekit-i18n) package to add multi-locale
support to our applications. This isn't really used for our smaller business clients, but will be
something we can offer to growing or enterprise clients.

## XML Sitemap Generation

We use the [svelte-sitemap](https://www.npmjs.com/package/svelte-sitemap) package to generate sitemaps
based on the domain.

## Animations (UI)

We use the [@formkit/auto-animate](https://www.npmjs.com/package/@formkit/auto-animate) package to animate
ui on the screen.

## Forms and Validation

We use the [felte](https://www.npmjs.com/package/felte) form library and [yup](https://www.npmjs.com/package/yup)
for the validation schema.

## End-to-End Testing

We use [playwright]() by Microsoft to perform automated end-to-end tests on our client's most important functionality.

## Cloud Automation

We use many tools to automate our software's development and release lifecycle in a cloud native manner.

### Github Actions

At the root of the repository, there is a .github directory that contains a workflows directory. The
workflows directory contains our automated ci/cd pipelines. There should be 3, named `merge.yaml`,
`pull-request.yaml`, and `release.yaml`. Each of which automate a portion of the software release
lifecycle to make teams more agile in their development and release workflows.

### Docker Builds

At the root of the repository, there is a Dockerfile that contains 3 stages: build, dev-image,
and production-image.

The dev-image is what will run on your local machine when you run docker-compose.

The production-image is what will run on our kubernetes deployments in the cloud.

### Helm Charts

This section is TBD...

## Running the Application Locally

To run the application locally, assuming you just cloned the repository to your system. You first
need to install the dependencies. This also assumes that you have node 16 installed and have also
installed [Yarn]() globally.

**1. Install Dependencies**

```shell
yarn install
```

**2. Run Development Server**

When running the development server, the build and postbuild scripts are run before the dev server
is accessible. The postbuild script generates our `sitemap.xml` file and moves it to the static
folder so it is publicly accessible.

```shell
yarn dev
```

## Running the Application in Docker

**Note:** when deploying to docker, you are running a production-image container
of the website. You will not have devtools available as if you were running
the dev-image build.

To run our application locally via the docker images, you only need to
run a couple of commands. The `.docker` directory is where our
`docker-compose` file is. This file orchestrates your local code into a
docker container along with an nginx server configured as a reverse-proxy.

To start this server up you need to be in the `.docker` directory.

```shell
    cd .docker
```

Then you need to start up the docker-compose file in detached mode.

```shell
    docker-compose up -d
```

You should now be able to go [here](http://localhost:8080) and view
your project being served by nginx.
