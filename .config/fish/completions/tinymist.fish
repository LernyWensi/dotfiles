# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_tinymist_global_optspecs
	string join \n h/help V/version
end

function __fish_tinymist_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_tinymist_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_tinymist_using_subcommand
	set -l cmd (__fish_tinymist_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c tinymist -n "__fish_tinymist_needs_command" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_needs_command" -s V -l version -d 'Print version'
complete -c tinymist -n "__fish_tinymist_needs_command" -f -a "completion" -d 'Generates completion script to stdout'
complete -c tinymist -n "__fish_tinymist_needs_command" -f -a "lsp" -d 'Runs language server'
complete -c tinymist -n "__fish_tinymist_needs_command" -f -a "query" -d 'Runs language query'
complete -c tinymist -n "__fish_tinymist_needs_command" -f -a "trace-lsp" -d 'Runs language server for tracing some typst program'
complete -c tinymist -n "__fish_tinymist_needs_command" -f -a "preview" -d 'Runs preview server'
complete -c tinymist -n "__fish_tinymist_needs_command" -f -a "probe" -d 'Probes existence (Nop run)'
complete -c tinymist -n "__fish_tinymist_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tinymist -n "__fish_tinymist_using_subcommand completion" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_using_subcommand lsp" -l mirror -d 'Mirror the stdin to the file' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand lsp" -l replay -d 'Replay input from the file' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand lsp" -l font-path -d 'Font paths' -r -F
complete -c tinymist -n "__fish_tinymist_using_subcommand lsp" -l ignore-system-fonts -d 'Ensures system fonts won\'t be searched, unless explicitly included via `--font-path`'
complete -c tinymist -n "__fish_tinymist_using_subcommand lsp" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and not __fish_seen_subcommand_from packageDocs checkPackage help" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and not __fish_seen_subcommand_from packageDocs checkPackage help" -f -a "packageDocs" -d 'Get the documentation for a specific package'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and not __fish_seen_subcommand_from packageDocs checkPackage help" -f -a "checkPackage" -d 'Check a specific package'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and not __fish_seen_subcommand_from packageDocs checkPackage help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from packageDocs" -l path -d 'The path of the package to request docs for' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from packageDocs" -l id -d 'The package of the package to request docs for' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from packageDocs" -s o -l output -d 'The output path for the requested docs' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from packageDocs" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from checkPackage" -l path -d 'The path of the package to request docs for' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from checkPackage" -l id -d 'The package of the package to request docs for' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from checkPackage" -s o -l output -d 'The output path for the requested docs' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from checkPackage" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from help" -f -a "packageDocs" -d 'Get the documentation for a specific package'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from help" -f -a "checkPackage" -d 'Check a specific package'
complete -c tinymist -n "__fish_tinymist_using_subcommand query; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l rpc-kind -r
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l mirror -d 'Mirror the stdin to the file' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l replay -d 'Replay input from the file' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l root -d 'Configures the project root (for absolute paths)' -r -F
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l input -d 'Add a string key-value pair visible through `sys.inputs`' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l font-path -d 'Font paths' -r -F
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l creation-timestamp -d 'The document\'s creation date formatted as a UNIX timestamp' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l cert -d 'Path to CA certificate file for network access, especially for downloading typst packages' -r -F
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l persist
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -l ignore-system-fonts -d 'Ensures system fonts won\'t be searched, unless explicitly included via `--font-path`'
complete -c tinymist -n "__fish_tinymist_using_subcommand trace-lsp" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l invert-colors -d 'Invert colors of the preview (useful for dark themes without cost). Please note you could see the origin colors when you hover elements in the preview' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l task-id -d 'Used by lsp for identifying the task' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l refresh-style -d 'Used by lsp for controlling the preview refresh style' -r -f -a "{onSave\t'Refresh preview on save',onType\t'Refresh preview on type'}"
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l root -d 'Configures the project root (for absolute paths)' -r -F
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l input -d 'Add a string key-value pair visible through `sys.inputs`' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l font-path -d 'Font paths' -r -F
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l creation-timestamp -d 'The document\'s creation date formatted as a UNIX timestamp' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l cert -d 'Path to CA certificate file for network access, especially for downloading typst packages' -r -F
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l preview-mode -d 'Preview mode' -r -f -a "{document\t'Preview mode for regular document',slide\t'Preview mode for slide'}"
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l data-plane-host -d 'Data plane server will bind to this address. Note: if it equals to `static_file_host`, same address will be used' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l control-plane-host -d 'Control plane server will bind to this address' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l host -d '(File) Host for the preview server. Note: if it equals to `data_plane_host`, same address will be used' -r
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l partial-rendering -d 'Only render visible part of the document. This can improve performance but still being experimental'
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l ignore-system-fonts -d 'Ensures system fonts won\'t be searched, unless explicitly included via `--font-path`'
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l not-primary -d 'Let it not be the primary instance'
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -l no-open -d 'Don\'t open the preview in the browser after compilation'
complete -c tinymist -n "__fish_tinymist_using_subcommand preview" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c tinymist -n "__fish_tinymist_using_subcommand probe" -s h -l help -d 'Print help'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and not __fish_seen_subcommand_from completion lsp query trace-lsp preview probe help" -f -a "completion" -d 'Generates completion script to stdout'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and not __fish_seen_subcommand_from completion lsp query trace-lsp preview probe help" -f -a "lsp" -d 'Runs language server'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and not __fish_seen_subcommand_from completion lsp query trace-lsp preview probe help" -f -a "query" -d 'Runs language query'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and not __fish_seen_subcommand_from completion lsp query trace-lsp preview probe help" -f -a "trace-lsp" -d 'Runs language server for tracing some typst program'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and not __fish_seen_subcommand_from completion lsp query trace-lsp preview probe help" -f -a "preview" -d 'Runs preview server'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and not __fish_seen_subcommand_from completion lsp query trace-lsp preview probe help" -f -a "probe" -d 'Probes existence (Nop run)'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and not __fish_seen_subcommand_from completion lsp query trace-lsp preview probe help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and __fish_seen_subcommand_from query" -f -a "packageDocs" -d 'Get the documentation for a specific package'
complete -c tinymist -n "__fish_tinymist_using_subcommand help; and __fish_seen_subcommand_from query" -f -a "checkPackage" -d 'Check a specific package'
