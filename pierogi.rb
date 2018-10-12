require "roda"
require "open3"
require_relative "cfg/config.rb"

class Pierogi < Roda
  plugin :slash_path_empty
  plugin :json_parser

  route do |r|
    r.is "github" do
      r.post do
        # r.params is a map, json is parsed automatically by the json_parser plugin
        # if our request is content type application/json
        err = handle_request(r.params)
        # TODO: Should be json responses (status: ok) or whatever
        if err.nil?
          "Script executed!"
        else
          response.status = 400
          "Error: #{err}"
        end
      end
    end

    r.on "test" do
      r.get do
        "Hello World\n"
      end
    end
  end
end

def handle_request(params)
  if params.has_key? "script"
    execute_script(params["script"])
  else
    "No 'script' key found in request json"
  end
end

def execute_script(script)
  begin
    puts "START: Attempting to execute script #{SCRIPTS_PATH}/#{script}"
    stdin, stdout, wait_thr = Open3.popen2e("#{SCRIPTS_PATH}/#{script}")
    stdin.close
    puts stdout.gets(nil)
    stdout.close
    exit_code = wait_thr.value
    puts exit_code.exitstatus
    puts exit_code
    if exit_code.success?
      puts "END: Script execution succeeded"
      nil
    else
      "Script Execution Failed"
    end
  rescue Exception => e
    err = "#{e.class}, #{e.message}"
    puts "END: Error: #{err}"
    err
  end
end
