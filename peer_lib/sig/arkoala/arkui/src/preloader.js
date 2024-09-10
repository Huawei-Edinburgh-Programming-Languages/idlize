const path = require('path')
const child_process = require('child_process')

process.env.LD_LIBRARY_PATH = path.join(__dirname, '../native')
process.env.PANDA_HOME = path.join(__dirname, '../external/incremental/tools/panda/node_modules/@panda/sdk')

child_process.spawn('node', [path.join(__dirname, './loader.js'), process.argv[2]], { stdio: 'inherit' })
