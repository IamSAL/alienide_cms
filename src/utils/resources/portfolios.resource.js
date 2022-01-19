const { categoryResource } = require("./category.resource");
const { imageResource } = require("./image.resource");
const portfoliosResource = {
  image: imageResource,
  category: categoryResource,
};

module.exports = { portfoliosResource };
