"use strict";
exports.__esModule = true;
exports.remember = exports.NodeAttach = exports.IncrementalNode = void 0;
var IncrementalNode = /** @class */ (function () {
    function IncrementalNode() {
    }
    return IncrementalNode;
}());
exports.IncrementalNode = IncrementalNode;
function NodeAttach(create, 
/** @memo */
update) { throw new Error("not implemented"); }
exports.NodeAttach = NodeAttach;
function remember(compute) {
    return compute();
}
exports.remember = remember;
