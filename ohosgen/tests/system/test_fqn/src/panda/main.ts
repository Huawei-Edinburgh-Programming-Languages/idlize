import { init, resize } from "./compat";

export function main() {
    init();
    console.log('Starting demo: test_fqn');
    resize({
        numSize:   { height:  8,   width:  4 },
        intSize:   { height: 18,   width: 14 },
        floatSize: { height: 28.0, width: 24.0 },
    });
}
