const {
  resolveImagePaths,
} = require("../../../../utils/functions/resolveImagePaths");

module.exports = {
  afterFindOne(event) {
    resolveImagePaths(event.result);
  },
  afterFindMany(event) {
    resolveImagePaths(event.result);
  },
};
