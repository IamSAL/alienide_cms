const _ = require("lodash");
const resolveImagePaths = (path, entity) => {
  function resolver(entity) {
    const sanitizedValue = entity.url ? prefixURL(path, entity) : entity;

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

function prefixURL(path, entity) {
  if (!entity.url.includes(path)) {
    entity.url = path + entity.url;
  }
  return entity;
}

function prefixAbsoluteURL(path, relativeURL) {
  if (!relativeURL.includes(path)) {
    relativeURL = path + relativeURL;
  }
  return relativeURL;
}
module.exports = { resolveImagePaths, prefixAbsoluteURL };
