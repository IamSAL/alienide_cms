const _ = require("lodash");
const resolveImagePaths = (entity, urlPath) => {
  const path = urlPath || strapi.config.get("server.url");
  function resolver(entity) {
    const sanitizedValue = entity.url ? prefixURL(entity, path) : entity;

    _.forEach(sanitizedValue, (value, key) => {
      if (_.isArray(value)) {
        sanitizedValue[key] = value.map(resolver);
      } else if (_.isObject(value)) {
        sanitizedValue[key] = resolver(value);
      }
    });

    return sanitizedValue;
  }
  return resolver(entity);
};

function prefixURL(entity, path) {
  if (!entity.url.includes(path)) {
    entity.url = path + entity.url;
  }
  return entity;
}

function prefixAbsoluteURL(relativeURL, path) {
  if (!relativeURL.includes(path)) {
    relativeURL = path + relativeURL;
  }
  return relativeURL;
}
module.exports = { resolveImagePaths, prefixAbsoluteURL };
