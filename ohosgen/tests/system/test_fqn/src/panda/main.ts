import { init, resize } from "./compat";

export function main() {
    init();
    console.log('Starting demo: test_fqn');
    resize({
        numSize:   { numHeight:  8,   numWidth:  4 },
        intSize:   { intHeight: 18,   intWidth: 14 },
        floatSize: { floatHeight: 28.0, floatWidth: 24.0 },
    });
}
