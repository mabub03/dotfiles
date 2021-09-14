Dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/path/to/vscode-php-debug/out/phpDebug.js' }
}

Dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9000
  }
}

