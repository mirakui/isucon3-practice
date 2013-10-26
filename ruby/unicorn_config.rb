worker_processes 30
preload_app true

pid "/tmp/unicorn.pid"
listen "/tmp/unicorn.sock"
stderr_path "/tmp/unicorn-err.log"
stdout_path "/tmp/unicorn-out.log"
