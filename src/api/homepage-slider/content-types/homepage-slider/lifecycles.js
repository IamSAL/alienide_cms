const {
  resolveImagePaths,
} = require("../../../../utils/functions/resolveImagePaths");
const os = require("os");
module.exports = {
  afterFindOne(event) {
    resolveImagePaths(event.result);
  },
  afterFindMany(event) {
    resolveImagePaths(event.result);
  },
};
