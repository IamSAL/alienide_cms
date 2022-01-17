const _ = require("lodash");
const removeAuthorFields = (entity) => {
  const sanitizedValue = _.omit(entity, [
    "createdAt",
    "updatedAt",
    "publishedAt",
  ]);

  _.forEach(sanitizedValue, (value, key) => {
    if (_.isArray(value)) {
      sanitizedValue[key] = value.map(removeAuthorFields);
    } else if (_.isObject(value)) {
      sanitizedValue[key] = removeAuthorFields(value);
    }
  });

  return sanitizedValue;
};

module.exports = { removeAuthorFields };
