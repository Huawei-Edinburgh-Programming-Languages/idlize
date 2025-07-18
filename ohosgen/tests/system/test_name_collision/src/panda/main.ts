import { init, resize, test } from "./compat";

function mainBody() {
    console.log('Starting demo: test_name_collision');
    resize({ height: 8, width: 4 });
    test.testSize({ spec: "very big" });
}

export function main() {
    init();
    mainBody();
}
