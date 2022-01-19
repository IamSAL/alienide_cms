const {
  resolveImagePaths,
} = require("../../../../utils/functions/resolveImagePaths");
const os = require("os");
module.exports = {
  afterFindMany(event) {
    resolveImagePaths(event.result);
  },
};
