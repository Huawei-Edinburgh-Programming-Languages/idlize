const child_process = require('child_process')

process.env.LD_LIBRARY_PATH = './native'
process.env.PANDA_HOME = './external/incremental/tools/panda/node_modules/@panda/sdk'

child_process.spawn('node', ['lib/loader.js', process.argv[2]], { stdio: 'inherit' })
