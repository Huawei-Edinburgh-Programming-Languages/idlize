import { init, resize } from "./compat";

export function main() {
    init();
    console.log('Starting demo: test_fqn');
    resize({ size: { height: 8, width: 4 }, offset: { x: 19, y: 23 } });
}
