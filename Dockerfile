FROM node:16-alpine AS build

WORKDIR /app
COPY . .
RUN yarn install --frozen-lockfile
RUN yarn build

FROM node:16-alpine AS dev-image

ENV NODE_ENV=development

WORKDIR /app
COPY --from=build /app/package.json /app/package.json
COPY --from=build /app/.svelte-kit /app/.svelte-kit
COPY --from=build /app/dist /app/dist

CMD ["node", "dist/index.js"]

FROM node:16-alpine AS production-image

ENV NODE_ENV=production

WORKDIR /app
COPY --from=build /app/package.json /app/package.json
COPY --from=build /app/.svelte-kit /app/.svelte-kit
COPY --from=build /app/dist /app/dist

CMD ["node", "dist/index.js"]
